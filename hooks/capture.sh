#!/usr/bin/env bash
# life-log safety net (UserPromptSubmit hook)
# Mirror every raw user message, timestamped, into _inbox.md so nothing is ever
# lost — even if the assistant forgets to file it.
#
# Self-scoping: only acts inside a folder initialized as a life-log (contains a
# `.life-log` marker). Stays completely silent everywhere else, so it never
# touches your other projects.
#
# stdin is JSON: { "prompt": "...", ... }. On UserPromptSubmit, anything printed
# to stdout is injected into Claude's context — so this hook prints nothing.
#
# No `set -e`: a safety net must never abort. It always exits 0.

DIR="${CLAUDE_PROJECT_DIR:-$PWD}"

# Only run inside an initialized life-log folder.
[ -f "$DIR/.life-log" ] || exit 0

INBOX="$DIR/_inbox.md"
ts="$(date '+%Y-%m-%d %H:%M')"

# Buffer stdin once, then extract the prompt field with the best tool available.
# `parsed` distinguishes "a parser ran and the prompt is genuinely empty" from
# "no parser could read it" — so a legitimately-empty message is skipped, not
# replaced by the raw JSON blob.
input="$(cat)"
prompt=""
parsed=0

# 1) jq — cleanest, if installed. Non-zero exit = JSON parse failure.
if command -v jq >/dev/null 2>&1; then
  if out="$(printf '%s' "$input" | jq -r '(.prompt // "") | gsub("\r?\n";" ")' 2>/dev/null)"; then
    prompt="$out"; parsed=1
  fi
fi

# 2) perl — ships on macOS/most Linux; handles JSON string escapes.
#    exit 0 (with the prompt printed) on match, exit 1 on no match.
if [ "$parsed" -eq 0 ] && command -v perl >/dev/null 2>&1; then
  if out="$(printf '%s' "$input" | perl -0777 -ne '
      if (/"prompt"\s*:\s*"((?:\\.|[^"\\])*)"/s) {
        my $s = $1;
        $s =~ s/\\n/ /g; $s =~ s/\\r/ /g; $s =~ s/\\t/ /g;
        $s =~ s/\\"/"/g; $s =~ s/\\\\/\\/g;
        print $s; exit 0;
      }
      exit 1;')"; then
    prompt="$out"; parsed=1
  fi
fi

# 3) Last resort: no JSON tool available — keep the raw line so nothing is lost.
if [ "$parsed" -eq 0 ]; then
  prompt="$(printf '%s' "$input" | tr '\r\n' '  ')"
fi

# Skip empty / whitespace-only messages (e.g. bare slash commands).
if ! printf '%s' "$prompt" | grep -q '[^[:space:]]'; then
  exit 0
fi

# Seed the inbox with a header on first write.
if [ ! -f "$INBOX" ]; then
  printf '# Inbox — raw capture\n\n> Auto-captured by the life-log safety-net hook. Never edited by hand.\n\n' > "$INBOX"
fi

printf -- '- [%s] %s\n' "$ts" "$prompt" >> "$INBOX"
exit 0
