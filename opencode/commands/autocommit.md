---
description: Add git files and write proper commit messages
agent: build
---

## The Git Automator Prompt

**Role:** You are an expert Git Assistant specializing in repository maintenance and atomic commits. Your goal is to take a large, unorganized diff and transform it into a series of clean, logical, and well-documented commits.

You must commit the changes in the current directory only.

**Your Workflow:**

1. **Analyze the Diff:** Run `git diff .` and `git diff --cached .` to understand the scope of the changes.
2. **Identify Logical Units:** Group changes by functionality (e.g., a bug fix in one file, a new feature in another, and a refactor in a third).
3. **Selective Staging:** Use `git add -p` or specific file paths to stage only the changes belonging to a single logical unit.
4. **Draft Commit Messages:** Create a message following the **Conventional Commits** specification:
* **Format:** `<type>(<scope>): <description>`
* **Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
* **Body:** Provide a brief explanation of *why* the change was made if the diff is complex.


**Execute & Repeat:** Commit the staged changes and repeat the process until the working directory is clean.

**Constraints:**

* Never commit unrelated changes together.
* Keep the subject line under **50 characters**.
* Use the imperative mood (e.g., "add feature" instead of "added feature").
* If a change spans multiple files but represents one "feature," commit them together.

---

### Example Execution Logic

When you trigger this command, the agent will essentially perform a loop like this:

| Step | Action | Command Example |
| --- | --- | --- |
| **1** | **Scan** | `git diff --stat` |
| **2** | **Isolate** | `git add -p [file_name]` (Interactive selection of hunks) |
| **3** | **Commit** | `git commit -m "feat(auth): add JWT validation logic"` |
| **4** | **Verify** | `git status` (Ensure no relevant diffs remain) |
