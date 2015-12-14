# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt brew bundler command-not-found jira pip rails)

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

source $ZSH/oh-my-zsh.sh

unamestr=$(uname)

# User configuration.
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

# For jira zsh plugin.
export JIRA_URL="https://jira.mongodb.org"

# For all things installed via homebrew.
export PATH="/usr/local/bin:$PATH"

if [[ "$unamestr" == "Linux" ]]; then
  # For m binaries, which for some reason don't like Ubuntu. TODO: figure out a better way to deal
  # with this.
  export PATH="/usr/local/bin/bin:$PATH"
fi

# Enable more colors in vim.
export TERM=xterm-256color

# Get the number of cores.
if [ -f /proc/cpuinfo ]; then
  export NUM_CORES=$(grep -c ^processor /proc/cpuinfo)
else
  export NUM_CORES=$(sysctl -n hw.logicalcpu)
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export CC=$(which clang)
export CXX=$(which clang++)
export CMAKE_SYSTEM_LIBRARY_PATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include
if [[ "$unamestr" == "Darwin" ]]; then
  # OS X has its own crypto/TLS libraries, so we need some dependencies for linking against openssl.
  if ! [ -e "/usr/local/opt/openssl" ]; then
    echo "Missing requirement(s) for openssl. Some compilations which need to link against it may fail. Try 'brew install openssl'."
  fi
  export SSL_FLAGS="LINKFLAGS=-L/usr/local/opt/openssl/lib CCFLAGS=-I/usr/local/opt/openssl/include CXXFLAGS=-I/usr/local/opt/openssl/include"
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases related to developing MongoDB.
common_scons_flags="-j $NUM_CORES --mute --build-fast-and-loose=off"
scons_compiler_flags="CC=$(which clang) CXX=$(which clang++)"
alias scons-fast="scons $common_scons_flags $scons_compiler_flags --modules="
alias scons-ent="scons $common_scons_flags $scons_compiler_flags $SSL_FLAGS --ssl"
alias scons-fast-pre-32="scons $common_scons_flags --cc=$(which clang) --cxx=$(which clang++)"
alias scons-asan="scons-fast --config=force --dbg=on --opt=off --allocator=system --sanitize=address --llvm-symbolizer=$(which llvm-symbolizer)"
alias scons-asan-pre-32="scons-fast-pre-32 --config=force --dbg=on --opt=off --allocator=system --sanitize=address --llvm-symbolizer=$(which llvm-symbolizer)"

alias fm="ps -ef | grep mongo"
alias fmd="ps -ef | grep mongod"

alias cr="python ~/github/kernel-tools/codereview/upload.py --nojira --check-clang-format"
alias evergreen="~/github/evergreen"

# If grc is installed, then use it to colorize the output of resmoke.py.
type foo >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
  alias resmoke="grc -c ~/.grc/conf.resmoke --colour=auto python buildscripts/resmoke.py"
else
  alias resmoke="python buildscripts/resmoke.py"
fi

# On ubuntu systems, there is already a package for 'node', so node.js's 'node' is installed as
# 'nodejs'.
type node > /dev/null 2>&1
if [[ $? != 0 ]]; then
  alias node="nodejs"
fi
