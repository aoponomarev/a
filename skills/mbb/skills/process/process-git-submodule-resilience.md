# Git Submodule Resilience Protocol (v1.0)

> **Goal**: Maintain stability and synchronization of `skills-core` across environments.
> **Skill Anchor**: `d:\Clouds\AO\OneDrive\Portfolio-CV\Refactoring\ToDo\Statistics\MBB`

## 🛠️ RECOVERY (С2)

If submodules are in a "detached HEAD" or "dirty" state:

1.  **Hard Reset**:
    ```bash
    git submodule foreach --recursive git reset --hard
    git submodule update --init --recursive
    ```
2.  **Sync with Remote**:
    ```bash
    git submodule update --remote --merge
    ```

## 🔄 CROSS-PC SYNC

- **OneDrive Conflict**: If `.git` folders in submodules conflict due to OneDrive sync, use `git submodule deinit -f .` and then `git submodule update --init`.
- **Commit Order**: ALWAYS commit and push changes in `skills-core` BEFORE committing the pointer update in the parent `MBB` repo.

## 🛡️ SAFETY GATES

- **No Nested Commits**: Avoid making changes directly in `skills-core` from the `MBB` context unless necessary. Use the dedicated `skills-core` workspace for editing.
- **Verification**: Run `npm run index:gen` after any submodule update to ensure the manifest is still valid.
