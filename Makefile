all: symlinks

install: update-local setup-nvm setup-rbenv symlinks
update: update-local update-nvm  update-rbenv symlinks

# Dotfiles

DOTFILES = \
	gitconfig \
	githelpers \
	gitignore \
	irbrc \
	rspec \
	zshenv \
	zshrc
SYMLINKS = $(addprefix $(HOME)/., $(DOTFILES))
$(SYMLINKS):
	@for dotfile in $(DOTFILES); \
	do \
		if test -d $$dotfile; \
		then \
			ln -Fhfsv $(PWD)/$$dotfile/ $(HOME)/.$$dotfile; \
		elif test -f $$dotfile; \
		then \
			ln -hfsv $(PWD)/$$dotfile $(HOME)/.$$dotfile; \
		fi; \
	done

symlinks: $(SYMLINKS)

# Local

update-local:
	git pull --rebase || (git stash && git pull --rebase && git stash pop)

# nvm
#
# https://github.com/creationix/nvm

setup-nvm:
	install-nvm
install-nvm:
	git clone -- git://github.com/creationix/nvm.git $(HOME)/.nvm
update-nvm:
	cd $(HOME)/.nvm && git pull origin master
uninstall-nvm:
	rm -fR $(HOME)/.nvm

# rbenv
#
# https://github.com/sstephenson/rbenv

setup-rbenv:
	install-rbenv \
	install-rbenv-plugins
install-rbenv:
	git clone -- git://github.com/sstephenson/rbenv.git $(HOME)/.rbenv
install-rbenv-plugins:
	mkdir -p $(HOME)/.rbenv/plugins
	git clone -- git://github.com/sstephenson/ruby-build.git \
		$(HOME)/.rbenv/plugins/ruby-build
	git clone -- git://github.com/carsomyr/rbenv-bundler.git \
		$(HOME)/.rbenv/plugins/bundler
update-rbenv:
	cd $(HOME)/.rbenv \
		&& git pull origin master
	cd $(HOME)/.rbenv/plugins/ruby-build \
		&& git pull origin master
	cd $(HOME)/.rbenv/plugins/bundler \
		&& git pull origin master
uninstall-rbenv:
	rm -fR $(HOME)/.rbenv

# Homebrew
#
# https://github.com/mxcl/homebrew

setup-brew:
	install-brew \
	install-brew-formulae
install-brew:
	/usr/bin/ruby -e "$(/usr/bin/curl -fsSL \
		https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
homebrew_formulae = \
	wget \
	git \
	hub \
	memcached \
	mongodb \
	mysql \
	postgres \
	redis \
	yajl \
	daemonize
install-brew-formulae:
	brew install $(homebrew_formulae)

# Uninstall

clean: uninstall
uninstall: uninstall-nvm uninstall-rbenv
