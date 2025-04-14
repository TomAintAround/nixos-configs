# Neovim configuration

This is my personal configuration for Neovim.

## Prerequisites

1. Ensure you have the following programs installed:
* neovim (obviously)
* git (also obviously)
* make
* curl
* gcc
* ripgrep
* fd
* man-pages

2. Ensure you have a nerd font installed ([check this website](https://www.nerdfonts.com/)).

## How to install

 I 100% recommend actually knowing how to setup a configuration yourself and use mine as a reference ([here's a great tutorial series](https://www.youtube.com/watch?v=TQn2hJeHQbM&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM)). But if you're crazy, just run the following command to install my configuration:
```sh
$ git clone https://github.com/TomAintAround/neovim-config ~/.config/nvim
```

## Recommendations

1. Again for the love of every superior entity make sure you know what you are doing. This won't directly destroy your computer, but it will be mentally painful for you if you don't even know what Vim is.

2. Run the following commands inside of Neovim to see if you're missing something: `:checkhealth` and `:checkhealth nvim-treesitter`.

3. Install LSPs, formatters and debuggers (check `lua/default/plugins/lsp.lua` and `lua/default/plugins/debugger.lua` to see which ones are configured).
