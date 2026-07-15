# life-log

*The life log you just talk to.*

![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)
![Works with Claude Code](https://img.shields.io/badge/works%20with-Claude%20Code-8A2BE2.svg)
![Version 0.1.0](https://img.shields.io/badge/version-0.1.0-brightgreen.svg)

**You can tell it anything, and it acts on it.** Open a folder, talk to Claude Code like you'd talk to a friend, and every thought — a workout, a mood, a work vent, money spent, a half-formed idea — gets quietly classified, timestamped, and filed into plain markdown on your own disk. No app. No forms. No schema. Just talk.

---

## See it

```text
you ›  ran 5k this morning, felt great

  → health.md
    - [2025-03-10 08:12] Ran 5k; felt great

  Love that. Logged — nice way to start the day. 🏃

you ›  rough one today, kind of argued with a friend

  → mood.md
    - [2025-03-10 21:40] Rough day; feeling off
  → people.md
    - [2025-03-10 21:40] Friction with a friend

  Sorry, that sounds draining. Filed it under both mood and
  people so you can look back later. Want to talk it through?
```

*(Example data — not real entries.)* One message can land in more than one note. You never say "log this." It just happens.

## The problem

Journaling apps demand a ritual: open the app, pick a template, fill the fields, tag it, save it. By the time you've done all that, the thought you wanted to keep has already evaporated. And the notes you *do* manage to write rot in silos you never reopen. Capturing your own life shouldn't feel like data entry.

## Why life-log

- 🗣️ **Zero-friction capture.** Say anything, in any language, mid-sentence. No template, no tag, no "new entry" button.
- 🗂️ **Automatic filing.** Every message is classified into the right dated note — work, health, mood, people, learning, money, ideas, or life — timestamped `[YYYY-MM-DD HH:MM]`, and appended as one clean summary line.
- 🕸️ **Impossible to lose a thought.** An independent safety-net hook mirrors every raw message to `_inbox.md` before Claude ever files it. Even if a filing is missed, the original is already on disk.
- 💬 **Replies like someone who's listening.** Not a silent logger — a companion that notices the pattern and the rough day, and says something human back.
- 📄 **Just markdown, just yours.** Grep-able, Obsidian-compatible, editable in any text editor. Nothing proprietary, nothing to export.
- 🔒 **Local-first by design.** No cloud, no account, no telemetry. See [Privacy](#-privacy--local-first).

## Install

From inside Claude Code:

```text
/plugin marketplace add yuki4266/life-log
/plugin install life-log@yuki-tools
/reload-plugins
```

> `yuki4266/life-log` is the GitHub repo you add as a marketplace; `yuki-tools` is the marketplace's name and `life-log` is the plugin inside it — hence `life-log@yuki-tools`.

Then open a **new, empty folder** and scaffold it:

```text
/life-log:setup
```

This creates the 8 category files, a `CLAUDE.md` carrying the always-on recording rules, and a `.life-log` marker that scopes the safety-net hook to this folder only.

Now just talk.

**Requirements:** Claude Code, and `jq` recommended for the safety-net hook — it degrades gracefully without it.

## Quick start

Once your folder is set up, there's nothing to learn. Talk:

```text
you ›  shipped the auth refactor, finally
  → work.md   - [2025-03-10 18:03] Shipped the auth refactor

you ›  mom called, she sounded tired
  → people.md - [2025-03-10 19:15] Mom called; sounded tired

you ›  spent ~$40 on groceries
  → money.md  - [2025-03-10 19:50] Groceries ~$40

you ›  idea: a CLI that reads my commit history back to me as a story
  → ideas.md  - [2025-03-10 22:10] Idea — CLI narrating commit history as a story
```

*(All example data.)* Two namespaced skills ship with the plugin:

- `/life-log:setup` — scaffold a new logging folder.
- `/life-log:log` — the recording behavior itself (loaded automatically; you rarely call it by hand).

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
                        reply thoughtfully.
```

**Layer 1** is a dumb, reliable machine: it never reasons, so it never fails to write. **Layer 2** is the intelligence: it decides *where* a thought belongs and *how* to say something back. If Layer 2 ever slips, Layer 1 already has the original — that's what "impossible to lose a thought" actually means, in engineering terms.

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
- **Change the tone.** The recording rules in `CLAUDE.md` describe how Claude replies. Want it drier, funnier, quieter? Edit that description in plain English.
- **File locations.** All notes, `_inbox.md`, `CLAUDE.md`, and the `.life-log` marker live in your logging folder. Move the folder and the whole log comes with it.
- **The default categories:** `work` · `health` · `mood` · `people` · `learning` · `money` · `ideas` · `life` (the catch-all).

---

## 中文简介

**一句话介绍：** life-log 是一个 Claude Code 插件——你只管在一个文件夹里跟它随便聊，说什么它都会自动帮你归档。运动、心情、工作吐槽、花了多少钱、一个突然冒出来的想法……它会自动**分类**、打上 `[YYYY-MM-DD HH:MM]` **时间戳**、写成一行摘要存进对应的 markdown 笔记，并且**像一个在认真听你说话的朋友一样**回你。全部存在你自己的硬盘上，**无云端、无账号、无追踪**。

**安装：** 在 Claude Code 里依次执行：

```text
/plugin marketplace add yuki4266/life-log
/plugin install life-log@yuki-tools
/reload-plugins
```

然后新建一个**空文件夹**，运行 `/life-log:setup` 初始化（生成 8 个分类文件、带记录规则的 `CLAUDE.md`，以及 `.life-log` 标记）。

**用法：** 之后什么都不用记，直接说话就行（以下为示例数据）——

```text
你 ›  今天跑了 5 公里
  → health.md  - [2025-03-10 08:12] 跑步 5 公里
```

两层设计：`UserPromptSubmit` 钩子会先把每条原始消息备份进 `_inbox.md`（绝不遗漏），Claude 再负责聪明地分类归档并温暖地回应。就算归档偶尔漏了，原文也早已安全落盘——**一个想法永远丢不了**。

---

## Contributing

Issues and PRs welcome at [`yuki4266/life-log`](https://github.com/yuki4266/life-log). If you've built a category, a tone, or a workflow you love, share it — this is meant to grow with the people who live in it.

## License

MIT © 2026. See [`LICENSE`](./LICENSE).
