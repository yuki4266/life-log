---
name: review
description: Reviews the user's life-log over a period (default the current month) from several perspectives at once — health, mood, work, money, people, learning — and produces a reflective summary with concrete, prioritized suggestions. Use when the user asks to review, reflect on, or summarize their week/month, or asks "how have I been doing?".
allowed-tools: Read, Write, Bash, Task
---

# Life-log review

Turn a month (or week) of scattered log lines into one reflective read-back:
what happened, the patterns worth noticing, and a few concrete suggestions. This
is the moment the log pays you back.

## 1. Determine the period

- Default: the **current calendar month**.
- Honor what the user asks: "review June", "this week", "last 30 days", a date
  range. Compute the start/end dates with `date` so filtering is exact.

## 2. Gather the entries

Read each category file (`work.md`, `health.md`, `mood.md`, `people.md`,
`learning.md`, `money.md`, `ideas.md`, `life.md`, plus any custom ones). Keep
only lines whose `[YYYY-MM-DD HH:MM]` timestamp falls inside the period. If a
category has no entries in range, skip it.

## 3. Analyze from multiple perspectives

Give each domain its own focused lens. **Prefer running these in parallel** with
the `Task` tool — one subagent per non-empty category — so a rich review comes
back fast; fall back to analyzing them yourself in sequence if subagents aren't
available. Each lens receives only that category's in-range entries and returns:

- **Summary** — what actually happened this period, in 2-4 sentences.
- **Patterns & trends** — recurring themes, direction of travel (better/worse),
  anything cyclical (e.g. mood dips on certain days, spending creep).
- **Flags** — anything that deserves attention or care.
- **Suggestions** — 1-3 concrete, kind, actionable next steps for this domain.

For health/mood especially: be supportive and non-judgmental, never clinical or
alarmist; suggest seeing a professional only if something genuinely warrants it.

## 4. Synthesize

Combine the lenses into one review. Look for **cross-domain connections** the
per-lens agents couldn't see (e.g. rough moods clustering with work stress; spend
spikes on low-sleep weeks). Then write:

1. **The month in a paragraph** — a warm, honest read-back.
2. **Highlights & wins** — don't only surface problems.
3. **Patterns worth noticing** — the 2-4 that matter most, cross-domain.
4. **Suggestions** — a short *prioritized* list (3-6), concrete and doable.

## 5. Save it

Write the review to `reviews/<period>.md` (e.g. `reviews/2025-03.md`), creating
the `reviews/` folder if needed. Never overwrite an existing review without
asking. Then show the user the summary and ask if they'd like to go deeper on any
one area.

## Tone

You're a thoughtful friend doing a month-end check-in, not an analytics
dashboard. Warm, specific, honest. Celebrate progress. Keep suggestions gentle
and few — a wall of advice helps no one.
