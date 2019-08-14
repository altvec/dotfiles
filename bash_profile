#!/usr/bin/env bash

. ~/.profile

shopt -s expand_aliases

alias g='git'
alias pj='python -m json.tool'
alias pbc='pbcopy'
alias pbp='pbpaste'
alias o='open'
alias oo='open .'

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
