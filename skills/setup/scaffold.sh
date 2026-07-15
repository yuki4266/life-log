#!/usr/bin/env bash
# life-log setup — scaffold the current folder into a life-log project.
#
# Idempotent by construction: every file is created ONLY if it is missing, so it
# can never overwrite your existing data. Safe to re-run any time.
#
# Target: ${CLAUDE_PROJECT_DIR} if set, else the current working directory.
set -o pipefail

DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$DIR" || { echo "life-log: cannot enter $DIR" >&2; exit 1; }

created=()

# new_file <path> : create <path> from heredoc stdin only if it doesn't exist.
# If it exists, the heredoc is consumed and discarded (no overwrite).
new_file() {
  local path="$1"
  if [ -e "$path" ]; then
    cat >/dev/null
    return 0
  fi
  cat > "$path"
  created+=("$path")
}

# --- marker (enables the safety-net hook here) ---
new_file ".life-log" <<'EOF'
life-log
EOF

# --- category files ---
new_file "work.md" <<'EOF'
# 工作 Work

<!-- work / career / projects · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "health.md" <<'EOF'
# 健康 Health

<!-- health / fitness / body / symptoms · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "mood.md" <<'EOF'
# 心情 Mood

<!-- feelings / emotions · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "people.md" <<'EOF'
# 人际 People

<!-- relationships / family / friends · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "learning.md" <<'EOF'
# 学习 Learning

<!-- study / growth / reading · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "money.md" <<'EOF'
# 财务 Money

<!-- finance / spending / investing · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "ideas.md" <<'EOF'
# 想法 Ideas

<!-- ideas / inspiration / plans · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "life.md" <<'EOF'
# 生活 Life

<!-- everyday / catch-all · format: - [YYYY-MM-DD HH:MM] content -->
EOF

new_file "README.md" <<'EOF'
# My Life Log

A running log of my life, kept by talking to Claude Code.

## How to use

Just tell me anything — I'll classify it, timestamp it, and file it into the
right note. You never have to say "log this".

| File | For |
|------|-----|
| work.md | work / career / projects |
| health.md | health / fitness / body |
| mood.md | feelings / emotions |
| people.md | relationships / family / friends |
| learning.md | study / growth / reading |
| money.md | finance / spending / investing |
| ideas.md | ideas / inspiration / plans |
| life.md | everyday / catch-all |

Every entry: `- [YYYY-MM-DD HH:MM] content`

`_inbox.md` holds a raw backup of every message, captured automatically.
EOF

# --- CLAUDE.md : the always-on recording rules ---
# Written as an H2 section so it is valid both standalone and when appended to an
# existing CLAUDE.md. Created if absent; otherwise appended once.
read -r -d '' RULES <<'EOF'
## Life-log rules

This is a **life-log** project. On **every** message the user sends — whether or
not they say "log it":

1. **Classify** it into a category file below (fall back to `life.md`). One
   message may span several files — record it in each relevant one.
2. **Timestamp** with the real current time `[YYYY-MM-DD HH:MM]` — get it by
   running `date '+%Y-%m-%d %H:%M'`, never guess.
3. **Append** one line to each relevant file:
   `- [YYYY-MM-DD HH:MM] <summary>` — a clear, distilled summary you'll
   understand later, not a verbatim copy.
4. **Answer the user normally.** Recording is a side action; always give a real,
   thoughtful reply to what they actually said.

Pure project-maintenance requests (e.g. "change a rule") don't need a category
entry — the safety-net hook already keeps the raw copy in `_inbox.md`.

### Category files

| File | For |
|------|-----|
| `work.md` | work / career / projects |
| `health.md` | health / fitness / body / symptoms |
| `mood.md` | feelings / emotions |
| `people.md` | relationships / family / friends |
| `learning.md` | study / growth / reading |
| `money.md` | finance / spending / investing |
| `ideas.md` | ideas / inspiration / plans |
| `life.md` | everyday / catch-all |

### Entry format

Every record: `- [YYYY-MM-DD HH:MM] content`
EOF

if [ ! -e "CLAUDE.md" ]; then
  {
    printf '# CLAUDE.md — life-log\n\n'
    printf '%s\n' "$RULES"
  } > "CLAUDE.md"
  created+=("CLAUDE.md")
elif ! grep -q "Life-log rules" "CLAUDE.md"; then
  printf '\n%s\n' "$RULES" >> "CLAUDE.md"
  created+=("CLAUDE.md (appended life-log rules)")
fi

# --- report ---
echo "life-log: scaffold complete in $DIR"
if [ "${#created[@]}" -gt 0 ]; then
  echo "created:"
  printf '  - %s\n' "${created[@]}"
else
  echo "nothing to do — this folder is already set up."
fi
