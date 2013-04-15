# Path

PATH="$PATH:/usr/local/git/bin"
export PATH

# MacVim

EDITOR=$(command -v {~,}/Applications/MacVim.app/Contents/MacOS/Vim | head -1)
EDITOR=${EDITOR:=vim}
export EDITOR
export VISUAL=$EDITOR
alias vim=$EDITOR

# Ruby

export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
if command -v rbenv >/dev/null
then
  eval "$(rbenv init - --no-rehash zsh)"

  if command -v daemonize >/dev/null
  then
    daemonize $HOME/.rbenv/bin/rbenv rehash
  else
    nohup rbenv rehash >/dev/null 1>&2 &
  fi
fi

export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=100000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_HEAP_FREE_MIN=50000

# node version manager
. ~/.nvm/nvm.sh
