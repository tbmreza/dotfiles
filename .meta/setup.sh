function assert_installed()
{
	if ! command -v $1 &> /dev/null ; then
		sudo apt-get install $2
	fi
}

assert_installed tmux tmux
assert_installed git git
assert_installed nvim neovim
assert_installed stow stow
assert_installed lua lua5.4

if ! [ -d .config ] ; then
	cd dotfiles
	folders_in_dotfiles=(nvim)
	for folder in ${folders_in_dotfiles[@]} ; do
		stow $folder
	done
	cd ~
fi

packer_dir=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if ! [ -d $packer_dir ] ; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
fi
