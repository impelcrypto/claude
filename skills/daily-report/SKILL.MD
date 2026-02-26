---
name: daily-report
description: Generate daily report report from GitHub Commits, PRs, and Reviews
---

# Daily Report Generation

When asked to generate a daily report, follow these steps:

1. Fetch all my merged and open PRs from the past 24 hours, by using `gh`.
2. Fetch all my commits from the past 24 hours, by using `gh` and `git`.
3. Fetch all PRs I reviewed in the past 24 hours, by using `gh`.
4. Group them by repository/project

5. Generate report in this format in simple English, listing ALL PRs from the past 24 hours:

**Daily Report:**

**[Project Name]:**

**1. [Feature/Task]:** [PR Title] ([PR URL])
* [What was accomplished]

**2. [Feature/Task]:** [PR Title] ([PR URL])
* [What was accomplished]

*(list all PRs, not limited to a fixed number)*

**Reviews:**
* Reviewed [PR Title] ([PR URL]) - [brief comment if notable]

## Guidelines:
- Use simple, clear English
- Focus on business value, not technical implementation details
- Keep descriptions concise (1-2 sentences)
- Group related PRs together
- Always include the PR Title and PR URL for each item
- List ALL PRs from the past 24 hours, do not limit or truncate
- If there are reviews, list them in a separate "Reviews" section
- If there's something worth team leaders to know, suggest "Anything else" section
