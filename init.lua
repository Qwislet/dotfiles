-- Import core of nvim config
require "core.settings"

------ Keymaps

-- Keymap function
local function map(mode, lhs, rhs, opts)
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Keymaps
map("n", "<space>", '<cmd>lua require("vscode-neovim").notify("whichkey.show")<CR>', {
    noremap = true,
    silent = true
})
map("v", "<space>", '<cmd>lua require("vscode-neovim").notify("whichkey.show")<CR>', {
    noremap = true,
    silent = true
})
map("n", "ga", '<cmd>lua require("vscode-neovim").notify("editor.action.quickFix")<CR>', {
    noremap = true,
    silent = true
})

-------------------------------------- Options ------------------------------------------

------ Global Values
local opt = vim.opt
local g = vim.g

------ Numbers Line & Etc

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 8

-- Minimal number of screen lines to keep left and right of the cursor
opt.sidescrolloff = 8

-- Allow commands moves the cursor to the first non-blank of the line
opt.startofline = true

------ Backup & Swap

-- Don't create a backup file
opt.backup = false

-- If a file is being edited by another program
-- (or was written to file while editing with another program),
-- it is not allowed to be edited
opt.writebackup = false

-- Disable swap files
opt.swapfile = false

-- Interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 100

-- Saves undo history to an undo file
-- and restores undo history from the same file on buffer read
opt.undofile = true

-- A history of ":" commands, and a history of previous search patterns
opt.history = 1000

------ Display

-- Wrap lines if lines longer than the width of the window
opt.wrap = false
opt.list = true

-- Disable Insert, Replace or Visual Mode messages on the last line
opt.showmode = false

-- Allow virtual editing in Visual block mode
opt.virtualedit = "block"

-- Shorter messages
opt.shortmess:append "c"

-- This is a sequence of letters
-- which describes how automatic formatting is to be done
-- Q - Comment formatting;
-- N - Numbered lists;
-- J - Remove comment when joining lines;
-- 1 - Don't break after one-letter word
opt.formatoptions = "qnj1"

-- Disable semantic tokens highlights!
vim.highlight.priorities.semantic_tokens = 95

---- Search

-- Make search act like search in modern browsers
opt.incsearch = true

-- Highlight all matches on previous search pattern
opt.hlsearch = true

-- Ignore case in search patterns
opt.ignorecase = true

-- Override the 'ignorecase' option if the search contains upper case characters (Used for: "/", "?", "n", "N", ":g" and ":s)
opt.smartcase = true

------ Terminal

-- Allow nvim access to system clipboard
opt.clipboard = "unnamedplus"

-- A list of file patterns which will be ignored when expanding wildcards (wildmenu)
vim.opt.wildignore =
"deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc"

-- Shell PATH
opt.shell = "/bin/zsh"

-- Home PATH
HOME = os.getenv "HOME"

------ Keymaps related settings

-- Backspace works on every char in insert mode
opt.backspace = "indent,eol,start"

-- Enable mouse
opt.mouse = "a"

-- Map space to <leader>
g.mapleader = " "
g.maplocalleader = " "

-- Go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<,>,[,],h,l"

------ Other Options

-- Disable nvim intro
opt.shortmess:append "sI"

-- Time in milliseconds to wait for a mapped sequence to complete
opt.timeoutlen = 300
