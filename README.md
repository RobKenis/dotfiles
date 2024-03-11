# .files

## Before you use

```shell
pacman -S git stow
```

## Using

```shell
stow -t ~/ .
```

## Fonts

I am using the Jetbrains Mono Nerd font. Install using `pacman -S ttf-jetbrains-mono-nerd`

## Stuff I dont want to lose

This isn't really important, but it's stuff I've gathered over the years that I found funny.

```shell
export PROMPT_COMMAND='[ $? -eq 0 ] || printf "(╯°□ °）╯︵ ┻━┻\n"'
precmd() { eval "$PROMPT_COMMAND" }
```

## Wallpapers

- https://github.com/Gingeh/wallpapers
