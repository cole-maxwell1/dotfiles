# Cole's Dotfiles

Personal dotfiles for zsh, Neovim, and opencode, plus a few shell scripts. The setup is managed with [GNU `stow`](https://www.gnu.org/software/stow/), a symlink manager that links the files in this repo to their corresponding locations under the home directory.

The zsh theme and plugins are installed manually rather than through a plugin manager. The `~/.zsh` directory is used to hold the git repos of any shell dependencies.

## Repository layout

```text
.
├── .zshrc                  # zsh config: PATH, history, completions, prompt, aliases
├── .config/
│   ├── nvim/               # Neovim config (init.lua, lua/, after/, queries/)
│   └── opencode/           # opencode config (commands, plugins, MCP tools, rules)
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

## Secrets

If `~/.secrets` exists, `.zshrc` sources it near the top of the file so environment variables (API keys, tokens, etc.) are exported into the shell. This file is intentionally **not** part of the repo — create it locally and keep it out of version control.
