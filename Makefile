.DEFAULT_GOAL := install

backup:
	@echo "Backing up VSCode extensions"
	code --list-extensions > extensions.txt

install:
	cat extensions.txt | xargs -L 1 code --install-extension
