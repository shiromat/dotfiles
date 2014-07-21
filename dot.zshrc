################################################################
#  PJE-0.1 ユーザ設定ファイルサンプル for zsh
#  Original made by MATSUMOTO Shoji (shom@i.h.kyoto-u.ac.jp)
#
#  zshell ユーザ設定ファイル for Plamo2.0
#  made by KATOU Takayuki
#  Time-stamp: <2000-08-15 04:02:45 rrr> , last edited.

#export NNTPSERVER=news.osn.u-ryukyu.ac.jp
export LANG="ja_JP.UTF-8"
export SVN_EDITOR="/usr/bin/vim"

# ログイン時以外 (ログインシェルでない場合) で、
# 対話シェルの場合に実行されます。

PATH=/usr/local/bin:$PATH:/usr/sbin:/sbin:/usr/texbin

# zsh option
setopt correct autolist autocd auto_pushd pushd_ignore_dups listtypes
setopt extended_history hist_ignore_all_dups hist_ignore_space share_history
# hist_ignore_dups

##################################################
# stty (tty type の設定)
##################################################
stty erase ^H
stty intr ^C
stty susp ^Z
stty start undef
stty stop undef

#bindkey '^?' delete-char   # Del で文字を消す

##################################################
# color-ls
# 色設定等は ~/.dir_colors
##################################################
#if which dircolors >& /dev/null; then
#	eval `dircolors -z ~/.dir_colors`
#else
  #export LS_OPTIONS='-F -T 0 ';
  #alias ls='/bin/ls $LS_OPTIONS';
#fi
# export LS_OPTIONS="$LS_OPTIONS -N "
#if [ "$TERM" = "dumb" ] ; then LS_OPTIONS="$LS_OPTIONS --color=no " ; fi

####################################################
#コマンドエイリアスの設定
####################################################
#alias cd='cd $@ ; ls'
alias ls='ls -F'
alias ll='ls -l'
alias la='ls -a'
alias sl='ls'
alias rm='rm -i'
# ghostview の代わりに gv を使う
alias ghostview='gv'
alias cls='clear'
#alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
alias lv='less'

# global alias
alias -g L='|lv'
alias -g G='|grep'

function cd(){
	    builtin cd "$@" && ls;
}
alias sc='screen -U -D -RR'
if [ $TERM = "screen" ]; then
        function ssh() {
                echo -n "\e]2;($@)\a"
                command ssh "$@"
                echo -n "\e]2;\a"
        }
fi


####################################################
# コマンドライン補完機能
####################################################

compctl -g '*(/) *.tex' platex
compctl -g '*(/) *.mp3 *.m3u *.MP3 *.M3U' mpg123
compctl -g '*(/) *.dvi' dvi2ps
compctl -g '*(/) *.dvi' xdvi
compctl -g '*(/) *.ps *.eps *.epsi' gv
compctl -j kill
compctl -g '.*(/) *(/) *(@)' cd
compctl -g '* .*' lv
compctl -g '* .*' less
#compctl -c man
compctl -c man jman

# tar の補完
compctl -f -x \
        's[--]' -k "(atime-preserve remove-files checkpoint \
                force-local ignore-failed-read preserve same-owner \
                null totals exclude use-compress-program block-compress \
                unlink help)" -X 'available options are:' - \
        'C[-1,*z*] p[2]' -g "*.tar.(Z|z|gz) *.taz *.tgz (|.)*(-/)" - \
        'C[-1,*f*] p[2]' -g "*.tar (|.)*(-/)" + -g '*' - \
        'W[1,*x*][1,*t*] p[3, -1]' -K getfilenames  -- tar gtar
# get files' name in tar file
function getfilenames () {
    local a
    read -cA a
    if [ "$curfile" != "$a[3]" ] ; then
        if [ -f $a[3] ]; then
          if [ $a[3]:e = gz -o $a[3]:e = tgz -o $a[3]:e = Z ]; then
            reply=(`tar ztf $a[3]`)
          else
            reply=(`tar tf $a[3]`)
          fi
        else
          reply=()
        fi
        curfile=$a[3]
    fi
}


# ftp siteの補完
#ftpsites=(ftp.iij.ad.jp upload.pluto.dti.ne.jp akegaras aotokage kawatonbo)
compctl -k ftpsites ftp

# urlの補完
#urls=( \
#     `grep \<A ~/.netscape/bookmarks.html |\
#     sed -e 's/.*HREF\=\"//' -e 's/\".*//'`\
#     )
#html=('*.(html)')
#compctl -k urls wget
#compctl -k urls + -k html w3m

# xrdb (PJE の .Xdefaults では #ifdef XIM や #include を使っている)
#alias xrdb='xrdb -DXIM=$XIM -I$HOME/.xres'

# prompt の設定
#PS1="%Bwarning! %n@%m%b:%2c%(#.#.$) "
#
PROMPT='[%n@%m:%.]%# '
RPROMPT='[%~]'

# kterm,xterm のタイトルに prompt を表示する
case $TERM in
kterm|xterm|screen)
    HN=`hostname`
    function termtitle () { echo -n "]0;$*" ; }
    termtitle "($HN)"
#    function cd () { builtin cd $* ; termtitle $HN:$PWD ; }
#    function popd () { builtin popd $* ; termtitle $HN:$PWD ; }
#    function pushd () { builtin pushd $* ; termtitle $HN:$PWD ; }
    function pwd () { builtin pwd ; termtitle $HN:$PWD ; }
    function su () { termtitle $HN":su "$* ;
        if [ "$[1]" = "-c" ] ; then command su -c "$[2]";
        elif [ "$[2]" = "-c" ] ; then command su $[1] -c "$[3]" 
        elif [ "$[3]" = "-c" ] ; then command su - $[2] -c "$[4]"
        else command su $* ; fi
        termtitle $HN:$PWD ; }
    function screen () {
	command screen $*
	termtitle $HN:$PWD
    }
    function ssh() {
        command ssh "$@"
        termtitle "($HN)"
    }
;;
esac

# key の設定 (Emacs)
bindkey -e
bindkey '\C-u' backward-kill-line
#bindkey '\C-w' kill-region
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

# complete
#_cache_hosts=(`perl -ne  'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`)
_cache_hosts=(`cat ~/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1`)
zstyle ':completion:*:default' menu select=1
autoload -U compinit
compinit

# stty (tty type の設定)
#stty erase ^H
#stty intr ^C
#stty susp ^Z
#stty start undef
#stty stop undef

# C-w
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

