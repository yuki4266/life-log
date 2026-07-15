<div align="center">

<img src="assets/banner.svg" alt="life-log — the little diary you just talk to" width="100%">

<br><br>

**🌸 Just talk to it like a diary — a grumble, a tiny win, a stray thought.**
**It files what you said into the right note, and says something kind back.**

*No app. No forms. Just talk.*

![License: MIT](https://img.shields.io/badge/license-MIT-C9A9E8?style=flat&labelColor=6E5A93)
![Works with Claude Code](https://img.shields.io/badge/works%20with-Claude%20Code-FFB182?style=flat&labelColor=C9743E)
![Version](https://img.shields.io/badge/version-0.1.0-8FD6A8?style=flat&labelColor=4E9A6B)
![Local first](https://img.shields.io/badge/local--first-no%20cloud-FF9EB5?style=flat&labelColor=C94F6D)

<br>

<img src="assets/demo.svg" alt="A cozy chat: a takeout grumble is tucked into money.md and mood.md with a gentle suggestion, and a shipped feature is logged as a win." width="90%">

<sub>💛 Example only — not real entries.</sub>

</div>

---

## ✨ How to use

**1 · Install** — once, inside Claude Code:

```text
/plugin marketplace add yuki4266/life-log
/plugin install life-log@yuki-tools
/reload-plugins
```

**2 · Make your diary** — open a new, empty folder and run:

```text
/life-log:setup
```

**3 · Just talk.** Whatever you say in that folder gets sorted, dated, filed, and answered. You never say "log this."

**4 · Look back** — anytime:

```text
/life-log:review
```

<sub>Needs Claude Code · <code>jq</code> optional (falls back to perl).</sub>

## 🗂️ What you get

<div align="center">

<img src="assets/files.svg" alt="Your diary is plain markdown files: work.md / health.md / mood.md hold your entries, one tidy line each; _inbox.md is a raw backup of every message so nothing gets lost; reviews/ holds your month and week look-backs; CLAUDE.md holds the rules you can edit to add a category or change the tone. All markdown, on your disk." width="100%">

<br><br>

<img src="assets/why.svg" alt="Why it's nice: talk instead of filling forms; entries are auto-sorted and dated into one clean line; it answers back with a gentle suggestion when it helps; it never loses a word because every message is backed up before it's filed; it's yours alone — local markdown, no cloud, no account, no tracking." width="100%">

</div>

## 🔧 How it works

<div align="center">

<img src="assets/flow.svg" alt="Two layers. A safety-net hook copies every raw message to _inbox.md and never fails. Smart filing sorts each message into the right note and replies. If the smart part ever slips, the safety net already has the original, so nothing is lost." width="100%">

</div>

## License

MIT — see [LICENSE](./LICENSE). Issues & PRs welcome at [`yuki4266/life-log`](https://github.com/yuki4266/life-log). 🌷
