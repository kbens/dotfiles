
dotfiles=~/.dotfiles

BASH_FILES := $(shell cd $(dotfiles)/bash; ls)
GIT_FILES := $(shell cd $(dotfiles)/git; ls)

all: help

link: link-vim link-git link-bash   ## Link all dotfiles to their respective locations

link-vim:
	@cd ~ && ln -nfs $(dotfiles)/vim/ .vim; \
				ln -nfs $(dotfiles)/vim/vimrc .vimrc; \
				ln -nfs $(dotfiles)/vim/gvimrc .gvimrc

link-git:
	@cd ~ && for file in $(GIT_FILES); do ln -nfs .dotfiles/git/$$file .$$file; done

link-bash:
	@cd ~ && for file in $(BASH_FILES); do ln -nfs .dotfiles/bash/$$file .$$file; done

check-dead:  ## Check for dead symlinks
	@find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

clean-dead:  ## Cleanup dead symlinks
	@find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

clean:  ## Remove all temporary and backup files
	@git clean -dfx

submodules:  ## Update all submodule references
	@git submodule foreach 'git fetch origin; \
			git checkout master; \
			git reset --hard origin/master; \
			git submodule update --recursive; \
			git clean -dfx'

update:  ## Pull updates from remote
	@git pull --rebase

help:  ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: link-vim link-nvim link-git link-bash check-dead clean-dead submodules update help

