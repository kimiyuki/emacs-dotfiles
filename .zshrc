##どこからのコピペの集合体で、よく分かってない。

export LANG=ja_JP.UTF-8
#export LC_MESSAGES=us_EN.UTF-8
#export RUBYOPT=-Ku
export RSENSE_HOME=/usr/lib/rsense-0.2
export PYTHONSTARTUP=~/.pythonstartup.py
#export VISUAL=emacsclient
export TERM="xterm-256color"
export PATH=/var/lib/gems/1.8/gems/rcodetools-0.8.5.0/bin:/usr/local/bin:$PATH:~/src/phantomjs/bin
export RUBYLIB=/usr/bin/ruby:~/src/emacs-evernote-mode-read-only/ruby/
export IRB_HISTORY_SIZE=1000000
export IRBRC=~/.irbrc
#export R_HOME=/usr/lib/R
#export R_HOME=/home/shirai/R/i686-pc-linux-gnu-library/2.11
export R_HISFILE=/home/shirai/.Rhistory
export R_HISTSIZE=1000000
export GEM_HOME=/var/lib/gems/1.8
export JAVA_HOME=/usr/lib/jvm/java-6-sun
export LD_LIBRARY_PATH=/usr/lib/graphviz
HISTFILE=~/.zsh_history
HISTSIZE=12000000
SAVEHIST=12000000
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks

export WORKON_HOME=$HOME/.virtualenvs

# case "${TERM}" in
# kterm*|xterm)
#     precmd() {
#         echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#     }
#     ;;
# esac
case ${UID} in
0)
    RPROMPT="%B%{[31m%}%/#%{[m%}"
    PROMPT2="%B%{[31m%}%_#%{[m%}"
    PROMPT="%[31m%}%m:%n "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    RPROMPT="%{[32m%}%/%%%{[m%}"
    PROMPT2="%{[32m%}%_%%%{[m%}"
    PROMPT="%{[32m%}%m:%n%% "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac
#if [[ $EMACS = t ]]; then
#    PROMPT='$HOST:%5~,%-2~/../%2~,%~)$ '
#else
#autoload -U colors
#colors
#    #PROMPT='$HOST:%(5~,%-2~/../%2~,%~)$ '
#PROMPT="%{${fg[cyan]}%}%m:%{${fg[green]}%}%# %{${fg[white]}%}"
#RPROMPT='%/'
#fi
#SPROMPT='zsh: replace '\''%R'\'' to '\''%r'\'' ? [Yes/No/Abort/Edit] '
autoload -U compinit
#compinit
compinit -u

autoload -U url-quote-magic
zle -N self-insert url-quote-magic


setopt no_always_last_prompt

# 8ビット文字の表示
setopt print_eightbit

# コマンド訂正
setopt correct

# ディレクトリ名で CD
setopt auto_cd


# 自動的に pushd する
setopt auto_pushd

# リダイレクトの際に上書き確認
setopt no_clobber

# コマンド打ち間違い時の beep を消す
setopt no_beep

# ファイル名生成の特殊文字を増やす
setopt extended_glob
# 重複してディレクトリスタックに積まない

setopt list_packed
# 補完候補を詰めて表示

setopt pushd_ignore_dups

# pushd popd を実行する際にディレクトリスタックの内容を表示しない
setopt pushd_silent

# 履歴ファイルを共有
setopt share_history

#履歴を順に取り出す
setopt incappendhistory

# 履歴ファイルに時刻を記録
setopt extended_history

# PROMPT を使うのに必要
setopt prompt_subst

# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt no_hup

# 履歴に重複がある場合は古い方を削除
setopt hist_expire_dups_first

# 重複履歴を保存しない
setopt hist_ignore_all_dups hist_save_nodups

# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
#setopt hist_ignore_space

setopt complete_in_word

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

#シングルクォ－トの中に、シングルクォ－トを入れる
setopt rc_quotes

##########################
# unset
#

# 改行のない出力を上書きしない
unsetopt promptcr

# メニュー補完をしない
unsetopt auto_menu

eval `dircolors -b`
#エイリアスの記述
if [[ $EMACS = t ]]; then
 alias ls='ls -F'
else
    function cd(){builtin cd $@ && ls -AFB --color=auto;}
    alias ls='ls -AFB --color=auto'
fi
alias ctags="ctags\-exuberant"
alias grep='egrep --color -i'
alias rm='rm -i'
alias mv='mv -i'
alias -g G='|rgrep --color'
alias -g L='|lv'
alias spec='spec -c'
alias du='du -h'
alias df='du -h'
alias where='command -v'
alias ll='ls -lAFBtr'
alias l.='ls -d .*'
alias h='history -dn'
alias lv='lv -Ou8 -c'
alias gem='sudo gem'

bindkey -e
#for history search conf
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 


# ワイルドカードの展開を確認
bindkey "^X" expand-word

# ヘルプの表示
bindkey "^q" run-help
# run-help が呼ばれた時、zsh の内部コマンドの場合は該当する zsh のマニュアル表示
[ -n "`alias run-help`" ] && unalias run-help
autoload run-help
