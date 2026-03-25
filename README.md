# repo-link

Symlink shared config files into repo clones so settings persist across ephemeral directories.

Files are stored in a central location (`~/.config/repo-links/<repo-name>/`) mirroring each repo's directory structure. When you run `repo-link` in a repo, it creates symlinks from the repo into the shared store.

## Install

```bash
git clone https://github.com/caseycelestin/repo-link.git
cd repo-link
bash install.sh
```

Or manually:

```bash
curl -o ~/.local/bin/repo-link https://raw.githubusercontent.com/caseycelestin/repo-link/main/repo-link
chmod +x ~/.local/bin/repo-link
```

## Usage

```bash
repo-link              # Symlink all managed files into current repo
repo-link add <path>   # Register a file (copies to shared store, replaces with symlink)
repo-link status       # Show link state for current repo
repo-link init         # Create empty config dir for current repo name
```

## Configuration

The shared store defaults to `~/.config/repo-links`. Override with:

```bash
export REPO_LINK_DIR=/path/to/my/links  # add to .bashrc to persist
```

## How it works

1. `repo-link init` creates `~/.config/repo-links/<repo-name>/`
2. `repo-link add <file>` copies the file into the shared store and replaces it with a symlink
3. `repo-link` (no args) symlinks all managed files into the current directory
4. Repo name is derived from `basename "$PWD"`

This is useful when you frequently clone fresh copies of repos (e.g., in worktrees) and want config files like `.env`, editor settings, or local overrides to follow automatically.
