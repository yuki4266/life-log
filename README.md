<div align="center">

<img src="assets/banner.svg" alt="life-log — the life log you just talk to" width="100%">

<br><br>

**🫶 Talk to Claude Code like a friend — a grumble, a tiny win, a passing thought — and it quietly tucks it into the right note and says something kind back.**

*No app. No forms. No schema. Just talk.* ✨

![License: MIT](https://img.shields.io/badge/license-MIT-C9A9E8?style=flat&labelColor=6E5A93)
![Works with Claude Code](https://img.shields.io/badge/works%20with-Claude%20Code-FFB182?style=flat&labelColor=C9743E)
![Version](https://img.shields.io/badge/version-0.1.0-8FD6A8?style=flat&labelColor=4E9A6B)
![Local first](https://img.shields.io/badge/local--first-no%20cloud-FF9EB5?style=flat&labelColor=C94F6D)

<br>

<img src="assets/demo.svg" alt="a cozy chat — a takeout grumble gets tucked into money and mood notes with a gentle suggestion, and a shipped feature gets logged as a win" width="90%">

<sub>💛 Example only — not real entries.</sub>

</div>

## How to use

### 1. Install the plugin (once)

From inside Claude Code, run:

```text
/plugin marketplace add yuki4266/life-log
/plugin install life-log@yuki-tools
/reload-plugins
```

> `yuki4266/life-log` is the GitHub repo you add as a marketplace; `yuki-tools` is the marketplace's name and `life-log` is the plugin inside it — hence `life-log@yuki-tools`.

**Requirements:** Claude Code, and `jq` recommended for the safety-net hook — it degrades gracefully without it (falls back to `perl`).

### 2. Create your log folder (once)

Make a new, empty folder, open Claude Code in it, and run:

```text
/life-log:setup
```

That scaffolds everything you need — and **never overwrites files that already exist**, so it's safe to re-run:

- **8 category notes** — `work` · `health` · `mood` · `people` · `learning` · `money` · `ideas` · `life`
- **`CLAUDE.md`** — the always-on recording rules (this is what makes every future message auto-file)
- **`.life-log`** — a marker that scopes the safety-net hook to *this* folder only
- **`_inbox.md`** — a raw backup of every message (created on your first message)

### 3. Just talk

From now on, anything you say in that folder is classified, timestamped, filed, and answered — **you never say "log this."** A single message can land in more than one note.

```text
you ›  ran 5k this morning, felt great
  → health.md  - [2025-03-10 08:12] Ran 5k; felt great
  "Nice — great way to start the day."

you ›  rough day, kind of argued with a friend
  → mood.md    - [2025-03-10 21:40] Rough day; feeling off
  → people.md  - [2025-03-10 21:40] Friction with a friend
  "Sorry, that sounds draining — want to talk it through?"

you ›  spent ~$40 on groceries
  → money.md   - [2025-03-10 19:50] Groceries ~$40

you ›  idea: a CLI that reads my commit history back to me as a story
  → ideas.md   - [2025-03-10 22:10] Idea — CLI narrating commit history as a story
```

*(All example data.)* Want a new category? Just make a file (e.g. `travel.md`) and add it to the list in `CLAUDE.md` — see [Configuration](#configuration).

### 4. Look back — `/life-log:review`

When you want to reflect, ask for a review:

```text
/life-log:review              # the current month
/life-log:review last week
/life-log:review June
```

It reads your notes across **every domain at once**, then hands you the highlights, the patterns worth noticing, and a few gentle, concrete suggestions — saved to `reviews/<period>.md`.

### Where everything lives

Everything is plain markdown in your folder — yours to grep, `git`, edit in Obsidian, or delete:

| File / folder | What it is |
|---|---|
| `work.md`, `health.md`, … | Your filed entries, one line each |
| `_inbox.md` | Raw backup of every message (the safety net) |
| `reviews/` | Your month/week reviews |
| `CLAUDE.md` | The recording rules — edit to change categories or tone |
| `.life-log` | Marker that turns the folder into a life-log |

---

## The problem

Journaling apps demand a ritual: open the app, pick a template, fill the fields, tag it, save it. By the time you've done all that, the thought you wanted to keep has already evaporated. And the notes you *do* manage to write rot in silos you never reopen. Keeping your own life shouldn't feel like data entry — it should feel like talking to someone who's paying attention.

## Why life-log

- 🗣️ **Talk like a friend.** Vent a complaint, drop a quick note, think out loud — in one line, mid-sentence. No template, no tag, no "new entry" button.
- 🗂️ **It files it for you.** Every message is classified into the right dated note, timestamped `[YYYY-MM-DD HH:MM]`, and appended as one clean summary line.
- 💡 **It gives you a suggestion, not just a record.** It notices patterns and offers a small, concrete next step when it helps — and stays quiet when a moment just needs to be heard.
- 🕸️ **Impossible to lose a thought.** An independent safety-net hook mirrors every raw message to `_inbox.md` before Claude ever files it. Even if a filing is missed, the original is already on disk.
- 🔮 **Month-end review.** `/life-log:review` reads back a whole month across every domain at once and hands you the highlights, the patterns, and a few gentle suggestions.
- 📄 **Just markdown, just yours.** Grep-able, Obsidian-compatible, editable in any text editor. Nothing proprietary, nothing to export.
- 🔒 **Local-first by design.** No cloud, no account, no telemetry. See [Privacy](#-privacy--local-first).

## Skills

Three namespaced skills ship with the plugin:

| Skill | What it does |
|-------|--------------|
| `/life-log:setup` | Scaffold a new logging folder (idempotent — never overwrites your data). |
| `/life-log:log` | The recording behavior: classify → timestamp → file → reply with a suggestion. Runs automatically; you rarely call it by hand. |
| `/life-log:review` | Read back a week or month across every domain and get highlights, patterns, and prioritized suggestions. |

## How it works

life-log is two independent layers. The first can't forget; the second is smart. Together they mean your thoughts are both *safe* and *organized*.

```text
   your message
        │
        ├─────────────► Layer 1 · Safety net
        │               UserPromptSubmit hook appends the raw
        │               message to _inbox.md — deterministic,
        │               every turn, before anything else runs.
        │               Only fires in folders with a .life-log
        │               marker, so your other projects are untouched.
        │
        └─────────────► Layer 2 · Smart filing
                        Recording rules (folder CLAUDE.md + the log
                        skill) tell Claude to classify → timestamp →
                        summarize into the right category note, then
                        reply like a friend with a suggestion.
```

**Layer 1** is a dumb, reliable machine: it never reasons, so it never fails to write. **Layer 2** is the intelligence: it decides *where* a thought belongs and *what to say back*. If Layer 2 ever slips, Layer 1 already has the original — that's what "impossible to lose a thought" actually means, in engineering terms.

## 🔒 Privacy / local-first

This is the whole point, so it gets its own section.

- **Everything lives on your disk.** Every note is a plain `.md` file in your folder. That's the entire database.
- **No cloud. No account. No sync service.** Nothing is uploaded anywhere by the plugin.
- **No telemetry.** life-log doesn't phone home, count you, or track you.
- **Open and portable.** Grep it, `git` it, open it in Obsidian, edit it in vim, delete it. It's just text.
- **Self-scoping.** The safety-net hook only runs in folders you've explicitly set up with a `.life-log` marker. Your other repos never see it.

Your life log should belong to you completely. This one does.

## Configuration

Everything is plain files you can edit.

- **Add or rename a category.** Create or rename the `.md` file (e.g. `travel.md`), then add it to the category list in your folder's `CLAUDE.md` so Claude knows to file into it.
- **Change the tone.** The recording rules in `CLAUDE.md` describe how Claude replies. Want it drier, funnier, quieter, more or less advice? Edit that description in plain English.
- **File locations.** All notes, `_inbox.md`, `CLAUDE.md`, and the `.life-log` marker live in your logging folder. Move the folder and the whole log comes with it.

## Contributing

Issues and PRs welcome at [`yuki4266/life-log`](https://github.com/yuki4266/life-log). If you've built a category, a tone, or a workflow you love, share it — this is meant to grow with the people who live in it.

## License

MIT © 2026. See [`LICENSE`](./LICENSE).
