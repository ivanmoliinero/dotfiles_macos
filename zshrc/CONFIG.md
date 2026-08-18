# Terminal Config
## Oh My Zsh
In order to install the plugin, you will need to first run this command:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
After that, you will need to clone the repositories of external dependencies:
```bash
# Clone the zsh-autosuggestions repository into the custom plugins directory
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Clone the zsh-syntax-highlighting repository into the custom plugins directory
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Clone the zsh-shift-select repository into the Oh My Zsh custom plugins directory
git clone https://github.com/jirutka/zsh-shift-select.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-shift-select

# Clone the Powerlevel10k repository with depth 1 for a faster download
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
Finally, replace (via hard link or as desired) the original config script in ~/.zshrc with the one located inside this repository.

### Additional: theme Powerlevel10k
This is the main theme used for the terminal looks. It requires some configuration apart from the initial `git clone`.
This configuration is manual at the time of the first activation, automatically detected by the theme. If you want to modify it afterwards, please run:
```bash
p10k configure
```
Apart from visual features, this theme introduces `Instant Prompt`. This functionality loads the UI of the terminal first and delegates other utils that may take more time to the background.
That way the loading of all the utils takes a little bit more but the terminal is presented to the user for basic usability nearly instantaneously. The creator of the theme refers as this as the main mechanism used in browsers.
Prefetching things is a really extended trick for improving UX. I have seen lately that they pretend to integrate prefetching in web when hovering a link, which can impact UX a lot as said.

## FZF
Fuzzy Search used by Zoxide and CTRL+R shortcut for better command search:
```bash
# 1. Install fzf via Homebrew
brew install fzf

# 2. Run the fzf installer to generate the machine-specific ~/.fzf.zsh file
$(brew --prefix)/opt/fzf/install --all
```

## Zoxide
Zoxide is a useful utility to change between directories without having to traverse all the directory structure to reach one specific directory.
It has two commands, `z` and `zi`. `zi` is the interactive version of `z`. It depends on FZF to work.
```bash
brew install zoxide
```
