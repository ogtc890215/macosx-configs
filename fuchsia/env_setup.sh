export PATH=/Volumes/freedom/fuchsia/.jiri_root/bin:$PATH
source scripts/fx-env.sh
fpath+=(/Volumes/freedom/fuchsia/scripts/zsh-completion)

function jiri_update() {
    jiri update -gc -hook-timeout=300 -vv
}

if [ ! -z $ZSH ]; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=($POWERLEVEL9K_LEFT_PROMPT_ELEMENTS custom_fuchsia)
    POWERLEVEL9K_CUSTOM_FUCHSIA="echo Fuchsia"
    POWERLEVEL9K_CUSTOM_FUCHSIA_BACKGROUND="magenta"
    POWERLEVEL9K_CUSTOM_FUCHSIA_FOREGROUND="black"
fi
