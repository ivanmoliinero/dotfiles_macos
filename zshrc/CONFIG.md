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
```
Right now, only two external utils used: syntax highlighting (for correct commands, etc.) and autosuggestion (similar to the Warp terminal).
Finally, replace (via hard link or as desired) the original config script in ~/.zshrc with the one located inside this repository.
