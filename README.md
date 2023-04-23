# My 💤 LazyVim IDE config for Neovim

[![IT Man - Talk #33 NeoVim as IDE [Vietnamese]](https://i.ytimg.com/vi/dFi8CzvqkNE/hqdefault.jpg)](https://www.youtube.com/watch?v=dFi8CzvqkNE)

[![IT Man - Talk #35 #Neovim IDE for Web Developer](https://i.ytimg.com/vi/3EbgMJ-RcWY/hqdefault.jpg)](https://www.youtube.com/watch?v=3EbgMJ-RcWY)

## Install Neovim

The easy way is using [MordechaiHadad/bob: A version manager for neovim](https://github.com/MordechaiHadad/bob).

```sh
bob install stable
bob use stable
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/jellydn/lazy-nvim-ide.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Try with Docker

```
docker run -w /root -it --rm alpine:latest sh -uelic '
  apk add git nodejs npm neovim ripgrep build-base make musl-dev go --update
  go install github.com/jesseduffield/lazygit@latest
  git clone https://github.com/jellydn/lazy-nvim-ide ~/.config/nvim
  nvim
  '
```

## Uninstall

```sh
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.cache/nvim
  rm -rf ~/.local/state/nvim
```

## Screenshots

<img width="1792" alt="image" src="https://user-images.githubusercontent.com/870029/228557089-0faaa49f-5dab-4704-a919-04decfc781ac.png">

## Tips

- Improve key repeat on Mac OSX, need to restart
```sh 
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12
```
