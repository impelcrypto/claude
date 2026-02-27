---
name: weekly-report
description: Generate weekly Top 3 Things report from GitHub PRs
---

# Weekly Report Generation

When asked to generate a weekly report, follow these steps:

1. Fetch all my merged and open PRs from the past 7 days, by using `gh`.
2. Group them by repository/project
3. Identify the 3 most important accomplishments based on:
   - Feature importance
   - Project priority

4. Generate report in this format in simple English
5. Save the report to `./report/weekly-report-YYYY-MM-DD.md` (using today's date, e.g., `weekly-report-2026-02-27.md`)
   - Create the `./report` directory if it doesn't exist

## Report Format:

**Top 3 Things:**

**[Project Name]:**

**1. [Feature/Task]:**
* [What was accomplished]

**2. [Feature/Task]:**
* [What was accomplished]

**3. [Feature/Task]:**
* [What was accomplished]

## Guidelines:
- Use simple, clear English
- Focus on business value, not technical implementation details
- Keep descriptions concise (1-2 sentences)
- Do NOT include code change statistics (e.g. lines added, files changed)
- Group related PRs together
- If more than 3 items, suggest "Other PRs" section
- If there's something worth team leaders to know, suggest "Anything else" section
- If the claude-mem MCP plugin is available, use it to supplement your report with additional context about past work, decisions, and accomplishments from the relevant period