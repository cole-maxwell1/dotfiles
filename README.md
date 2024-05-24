# ZSH Plugin and Theme
The key to this setup is [GNU `stow`](https://www.gnu.org/software/stow/) a symlink manager. `stow` allows you to easily link the files in the repo directly to where these files would be in your home directory originally.

I prefer to manually install the my zsh theme and plugins. I like to the `~/.zsh` directory to store the repos of any dependencies I bring into my config.

# Prerequisites

## GNU `stow`
Install `stow` with your system's package manager.

## Nerd Fonts
Make sure you get a nerd font [installed](https://github.com/ryanoasis/nerd-fonts) and [configured](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k) for your terminal emulators, text editors, and IDEs of choice.

## Powerlevel10k

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k 
```

## zsh-autosuggestions 

```sh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 
```

# Configure a New Machine
1. Clone this repository to your home directory
   ```sh
   git clone https://github.com/cole-maxwell1/dotfiles.git
   ```
2. Run GNU stow
   ```sh
   cd dotfiles && stow . 
   ```
3. Make scripts executable for current user
   ```sh
   chmod -R u+x ~/dotfiles/.scripts/
   ```