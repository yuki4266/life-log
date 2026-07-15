---
name: setup
description: Scaffolds the current folder into a life-log project. Use when the user wants to start a life log, set up life-log, or initialize a new/empty folder for logging. Runs an idempotent script that creates the category notes (work, health, mood, people, learning, money, ideas, life), a CLAUDE.md carrying the always-on recording rules, a README, and a .life-log marker that scopes the safety-net hook to this folder. Never overwrites existing files.
allowed-tools: Read, Write, Bash
---

# Life-log setup

Scaffold the current folder into a life-log project by running the bundled,
idempotent scaffold script. It creates the `.life-log` marker, the 8 category
files, a `CLAUDE.md` with the always-on recording rules, and a starter README —
and it **never overwrites files that already exist**, so it's safe to re-run.

## Steps

1. Run the scaffold script:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/skills/setup/scaffold.sh"
   ```
   If `$CLAUDE_PLUGIN_ROOT` isn't set in the shell, find this skill's directory
   (it holds this `SKILL.md`) and run `scaffold.sh` from there.
2. Read the script's output and tell the user exactly what was created (or that
   the folder was already set up).
3. Show them how to start — for example:
   > Done! Your life log is ready. Just talk to me — try:
   > - "ran 5k this morning" → filed to health.md
   > - "had a rough day at work" → filed to work.md + mood.md
   >
   > Every message you send here gets classified, timestamped, and saved.
   > Nothing is ever lost.

After setup, the recording rules in the new `CLAUDE.md` take over automatically —
see the `log` skill for the recording behavior itself.
