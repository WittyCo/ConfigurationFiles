# Created by newuser for 5.8.1
bindkey -v # CLI可使用vim模式
export KEYTIMEOUT=1
# Emacs
bindkey '^F' forward-char
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey '^y' yank
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^q' push-line-or-edit
bindkey '^k' kill-line
bindkey '\eb' backward-word
bindkey '^b' backward-char
bindkey '\ef' forward-word

# 根据不同的 vi 模式更改光标形状
function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]] || [[ $1 == 'block' ]]; then
        echo -ne '\e[1 q'  # 使用 Filled box 形状
    elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP == '' ]] || [[ $1 == 'beam' ]]; then
        echo -ne '\e[5 q'  # 使用 bar 形状
    fi
}
zle -N zle-keymap-select
# 在启动时使用 bar 形状的光标
echo -ne '\e[5 q'

setopt prompt_subst histignorealldups sharehistory HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

source $XDG_CONFIG_HOME/.aliases

autoload -U compinit; compinit  # 加载zsh的compinit函数；调用compinit函数以初始化补全系统
zmodload zsh/complist           # 加载complist模块以提供不全列表的管理和显示功能
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
# [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
# [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh" # 加载zinit的初始化脚本
autoload -Uz _zinit # 在用户区域加载_zinit函数,且忽略任何现有定义
(( ${+_comps} )) && _comps[zinit]=_zinit  # 检查数组_comps是否定义(是否有任何补全函数注册)以添加进去

zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions

zinit ice lucid wait='0' atinit='zpcompinit'
zinit load zdharma/fast-syntax-highlighting

zinit ice lucid wait='0'
zinit load zsh-users/zsh-completions

# 加载OMZ部分插件
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
# zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
# zinit snippet OMZT::steeef
zinit snippet OMZT::robbyrussell

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

# OMZ的sudo代码段生效快捷键
bindkey -M emacs '^o' sudo-command-line
bindkey -M vicmd '^o' sudo-command-line
bindkey -M viins '^o' sudo-command-line

[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh

[ -f $XDG_CONFIG_HOME/.fzf.zsh ] && source $XDG_CONFIG_HOME/.fzf.zsh
for index ({1..9}) alias "$index"="cd +${index}"; unset index
