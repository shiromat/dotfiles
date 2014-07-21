all: tmux vim

tmux:
	ln -s -f ${PWD}/dot.tmux.conf ${HOME}/.tmux.conf

vim:
	ln -s -f ${PWD}/dot.vimrc ${HOME}/.vimrc

zsh:
	ln -s -f ${PWD}/dot.zshrc ${HOME}/.zshrc

