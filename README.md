# vim-go-expr-completion

A Vim plugin to complete a left-hand side from given expression for Go.

![7e8541cf-ec02-4eae-8977-6780d7467fba](https://user-images.githubusercontent.com/2134196/89310112-3c72d180-d6af-11ea-98de-b4d47edc6175.gif)

## Installation

- Install [go-expr-completion](https://github.com/110y/go-expr-completion) first.
- Install this plugin (e.g. via [vim-plug](https://github.com/junegunn/vim-plug).

```vim
Plug '110y/vim-go-expr-completion', {'branch': 'master'}
```

## Usage

For example, set a nnoremap like below:

```vim
autocmd vimrc FileType go nnoremap <silent> ge :<C-u>silent call go#expr#complete()<CR>
```

And navigate your cursor to the arbitrary expression, type `ge` in normal mode, and then this plugin completes the left-hand side for given expression (and `if err...` if necessary).
