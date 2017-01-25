#!/usr/bin/env bash

shopt -s expand_aliases

export PATH=$HOME/bin:$HOME/lib/dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/lib/Go

alias g='git'
alias pj='python -m json.tool'
alias pbc='pbcopy'
alias pbp='pbpaste'
alias o='open'
alias oo='open .'


