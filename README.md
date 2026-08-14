# Cole's Dotfiles

Personal dotfiles for zsh, Neovim, and opencode, plus a few shell scripts. The setup is managed with [GNU `stow`](https://www.gnu.org/software/stow/), a symlink manager that links the files in this repo to their corresponding locations under the home directory.

The zsh theme and plugins are installed manually rather than through a plugin manager. The `~/.zsh` directory is used to hold the git repos of any shell dependencies.

## Repository layout

```text
.
├── .zshrc                  # zsh config: PATH, history, completions, prompt, aliases
├── .config/
│   ├── nvim/               # Neovim config (init.lua, lua/, after/, queries/)
│   └── opencode/           # opencode config (commands, plugins, skills, MCP tools, rules)
└── .scripts/               # Standalone shell scripts (on $PATH)
    └── hello.sh
```

Everything above is relative to the home directory, which is exactly what `stow .` expects.

## Prerequisites

### Required

- **GNU `stow`** — install with the system package manager (`brew install stow`, `apt install stow`, etc.).
- **A Nerd Font** — [install](https://github.com/ryanoasis/nerd-fonts) one and [configure](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k) it in the terminal, editor, and IDE of choice. Required for icons in the prompt and `lsd`.

### Shell theme and plugins

Clone into `~/.zsh/` so `.zshrc` picks them up automatically:

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

### Optional

- **`lsd`** — drives the `ls`/`ll`/`lt` aliases in `.zshrc`. Without it, the aliases fall back to the system `ls`. ([github.com/lsd-rs/lsd](https://github.com/lsd-rs/lsd))

## Configure a new machine

1. Clone into the home directory:
   ```sh
   git clone https://github.com/cole-maxwell1/dotfiles.git ~/dotfiles
   ```
2. Symlink the dotfiles into place with stow:
   ```sh
   cd ~/dotfiles && stow .
   ```
3. Make the scripts executable:
   ```sh
   chmod -R u+x ~/dotfiles/.scripts/
   ```
4. If this is the first run with Powerlevel10k, generate the prompt config:
   ```sh
   p10k configure
   ```
5. Restart the shell (or `exec zsh`) to load the new config.

## Unlink or uninstall

To remove the symlinks without deleting the repo:

```sh
cd ~/dotfiles && stow -D .
```

Running `stow .` again re-creates them.

## Add new files or directories

Add each item to the repository at the same path it should have under the home directory. For example, opencode skills belong under `~/dotfiles/.config/opencode/skills/`. Then refresh the links:

```sh
cd ~/dotfiles
stow .
```

If the corresponding target does not exist, Stow creates the symlink. This applies to an entire new directory such as `skills` and to files added inside an already-stowed directory.

If Stow reports that an existing target is neither a link nor a directory, the target is a real file that Stow will not overwrite. When the repository copy is authoritative, back up the target and rerun Stow:

```sh
mv ~/.config/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc.pre-stow-backup
cd ~/dotfiles
stow .
```

Repeat the backup step for every conflicting target listed by Stow. Review and remove backups only after confirming the linked configuration works.

Do not use `stow --adopt` for this workflow. `--adopt` copies the existing target into the repository, replacing the repository version, which is the opposite of making the repository authoritative.

## Secrets

If `~/.secrets` exists, `.zshrc` sources it near the top of the file so environment variables (API keys, tokens, etc.) are exported into the shell. This file is intentionally **not** part of the repo — create it locally and keep it out of version control.
