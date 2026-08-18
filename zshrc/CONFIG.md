# Oh My Zsh Config
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
```
Finally, replace (via hard link or as desired) the original config script in ~/.zshrc with the one located inside this repository.
