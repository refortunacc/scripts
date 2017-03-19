#!/bin/sh
GITREPOS=~/gitrepos

# TODO: dircolors solarized, zsh configuration
sudo apt-get install git vim zsh tmux -y

# Installing Vundle - Vim plugin manager tool
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Creating vim backup directory
mkdir -p ~/.tmp
echo "Writing ~/.vimrc"
cat << EOF > ~/.vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" let Vundle manage Vundle, required

Plugin 'gmarik/Vundle.vim'
" All plugins go here!
" Best tab plugins ever
Plugin 'godlygeek/tabular'
" Handle markdown well
Plugin 'plasticboy/vim-markdown'
" Status line at bottom
Plugin 'bling/vim-airline'
" Fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'
" Adds context-aware commenting
Plugin 'tpope/vim-commentary' " gcc to comment a line
" Syntax highlighting
Plugin 'scrooloose/syntastic'
" Git wrapper
Plugin 'tpope/vim-fugitive'
" Rails plugin for Vim
Plugin 'tpope/vim-rails'
" Sensible nocompat default settings
Plugin 'tpope/vim-sensible'
" Gutter that shows changed lines/etc.
Plugin 'airblade/vim-gitgutter'
" Shows list of buffers in command line
Plugin 'bling/vim-bufferline'
" Solarized colorset
Plugin 'altercation/vim-colors-solarized'
" Improved incremental searching
Plugin 'haya14busa/incsearch.vim'
" Helps create tags with definitions for quick jump-to using Ctags
Plugin 'xolox/vim-easytags'
" Lets you bring up a tagbar with :TagbarToggle
Plugin 'majutsushi/tagbar'
" Better whitespace highlighting
Plugin 'ntpeters/vim-better-whitespace'
" Maps . to repeat plugin commands, not just native commands
Plugin 'tpope/vim-repeat'
" Required by other plugins
Plugin 'xolox/vim-misc'
" Tmux / Airline integration
Plugin 'edkolev/tmuxline.vim'
" Make navigating tmux like vim splits
Plugin 'christoomey/vim-tmux-navigator'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Disable folding in Vim Markdown syntax
let g:vim_markdown_folding_disabled=1
EOF

# Run Vim to install plugins from Vundle
vim +PluginInstall +qall

# Then append the rest of the config file so we don't get the colorscheme error
cat << EOF >> ~/.vimrc
" Fix paste stuff?
set clipboard=unnamed

" enables syntax highlighting
syntax on

" Turns on line numbers
set number

" Set mouse to always available
set mouse=a

" Set the paste option to 'on'
set paste

" Set tabs to 2 spaces and automatic
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2

let g:solarized_termcolors=256
colorscheme solarized
if has('gui_running')
  set background=dark
else
  set background=dark
endif
"set t_Co=16 " Set term colors to 16 instead of 8

" Set automatic filetype detection on
filetype on

" Keep 500 lines of command history
set history=500

" Set the statusline to always be shown
set laststatus=2

" Show the cursor position at all times
set ruler

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Write backup files to a specific directory
set backup
set backupdir=~/.tmp

" Because I use .md for Markdown files
au BufRead,BufNewFile *.md set filetype=markdown
" Because I use .rc for Metasploit ruby scripts
au BufRead,BufNewFile *.rc set filetype=ruby
autocmd BufEnter Makefile setlocal noexpandtab

" Multi-line navigation:
nnoremap k gk
nnoremap <Up> gk
nnoremap j gj
nnoremap <Down> gj

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.markdown setlocal spell

"execute pathogen#infect()

" Timestamp TODO: Fix the format to something else
" Fri 15 Aug 2014 10:45:11 AM EDT (current)
" 2014-08-15_10-45-11 would be ideal
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" CtrlP config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" IncSearch configuration
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

set guifont=Inconsolata\ for\ Powerline:h14
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

" FZF configuration
set rtp+=/usr/local/opt/fzf

" This is supposed to fix the issue of Vim colors being broken in Tmux,
" but doesn't appear to be working
if exists('')
set term=screen-256color
endif
EOF

echo "Writing ~/.tmux.conf"
cat > ~/.tmux.conf << EOF

# Make it use C-a, similar to screen..
unbind C-b
unbind l
set -g prefix C-a
bind-key C-a last-window

# use good colors
set -g default-terminal xterm-256color

# toggle status line
bind T set-option -g status


# act like vim
setw -g mode-keys vi

# Reload key
bind r source-file ~/.tmux.conf

set -g history-limit 5000


# Start numbering at 1 (easier to switch between a few screens)
set -g base-index 1
setw -g pane-base-index 1

# toggle status line
bind T set-option -g status

# put statusline on top
set-option -g status-position top

# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

# tmuxline integration
if-shell "test -f ~/.tmuxline" "source ~/.tmuxline"

set-option -g default-shell /usr/local/bin/zsh
EOF

# Installing Solarized for XFCE Terminal
sudo apt-get install dconf-cli -y
git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git $GITREPOS/xfce4-solarized
cd $GITREPOS/xfce4-solarized
mkdir -p ~/.config/Terminal/
mkdir -p ~/.config/xfce4/terminal/
# Instructions say two different ways. I think only the 2nd is needed, TODO: Test further
cp dark/terminalrc ~/.config/Terminal/terminalrc
cp dark/terminalrc ~/.config/xfce4/terminal/terminalrc

# Installing zsh, antigen, and configuring a few basic things
mkdir -p ~/.zsh && cd ~/.zsh && git clone https://github.com/zsh-users/antigen.git &&
git clone https://github.com/supercrabtree/k.git

cat > ~/.zshrc << EOF
[ -e "\${HOME}/.zsh_aliases" ] && source "\${HOME}/.zsh_aliases"
[ -e "\${HOME}/.zshrc_local" ] && source "\${HOME}/.zshrc_local"

# You have to use npm to install npm, and that will give you the
# completion.sh file you need.
#source /usr/local/lib/node_modules/npm/lib/utils/completion.sh

source "\$HOME/.zsh/antigen/antigen.zsh"
source "\$HOME/.zsh/k/k.sh"

# We use primarily oh-my-zsh plugins
antigen use oh-my-zsh

# Set the familiar blinks theme
antigen theme evan

antigen bundle git 
antigen bundle ruby 
antigen bundle debian 
antigen bundle tmux 
antigen bundle encode64 
antigen bundle gem 
antigen bundle gpg-agent 
antigen bundle gitfast 
antigen bundle vi-mode
antigen bundle rake
antigen bundle rvm
antigen bundle bundler
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle command-not-found
antigen bundle history
antigen bundle tmux
antigen bundle vundle

antigen-apply

export PATH=\$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bro/bin

EOF
#zsh -l
