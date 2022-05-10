---
title: "Oh my zsh"
menu:
  notes:
    name: zsh
    identifier: notes-mac-zsh
    parent: notes-mac
    weight: 10
---

<!-- Oh my zsh -->
{{< note title="Oh my zsh" >}}
oh my zsh 설치
```bash
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"emulator -list-avds
```
---
Pure prompt를 설치
```bash
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
echo "\nfpath+=$HOME/.zsh/pure\nautoload -U promptinit; promptinit\nprompt pure" >> "$HOME/.zshrc"
exec $SHELL
```
---
Syntax Highlight
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
echo "\nsource $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
```
{{< /note >}}