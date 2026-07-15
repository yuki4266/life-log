# Category reference

The default life-log categories. A message may belong to more than one — record
it in each relevant file. When nothing fits, use `life.md`.

| File | What goes here |
|------|----------------|
| `work.md` | Work, career, projects, deadlines, meetings, wins and blockers |
| `health.md` | Body, weight, fitness, symptoms, sleep, food, medical notes |
| `mood.md` | Feelings, emotions, how the day felt, stress, energy |
| `people.md` | Relationships, family, friends, conversations, social plans |
| `learning.md` | Study, courses, reading, skills, growth, insights |
| `money.md` | Spending, income, budgets, investing, purchases |
| `ideas.md` | Ideas, inspiration, plans, things to try, projects to start |
| `life.md` | Everyday miscellany and anything that doesn't fit above (catch-all) |

## Adding your own category

1. Create a new file, e.g. `travel.md`, with a one-line header.
2. Add a row for it in this table **and** in the category list inside your
   folder's `CLAUDE.md`, so Claude knows to file into it.

## Entry format

Every entry, in every file, is one line:

```
- [YYYY-MM-DD HH:MM] content
```

Always fetch the real timestamp with `date '+%Y-%m-%d %H:%M'`.
