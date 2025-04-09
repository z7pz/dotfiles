# How to use
1. install zsh 
```
sudo apt install zsh
```
2. install oh-my-zsh 
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
3. clone the repo 
```
git clone https://github.com/z7pz/dotfiles
```
4. move `.zshrc` into `~` 
```
mv ./dotfiles/.zshrc ~/.zshrc
```
next step, installing the plugins
```
chmod +x ./dotfiles/install-plugins.sh
```
```
./install-plugins.sh
```
last step, reload your terminal
```
source ~/.zshrc
```
