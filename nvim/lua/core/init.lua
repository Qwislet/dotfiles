local global = require("core.global")

-- Create cache dir and data dirs
local createdir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
		global.cache_dir .. "undo",
	}
	-- Only check whether cache_dir exists, this would be enough.
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local disable_distribution_plugins = function()
	-- disable menu loading
	vim.g.did_install_default_menus = 1
	vim.g.did_install_syntax_menu = 1

	-- Uncomment this if define own filetypes in `after/ftplugin`
	-- vim.g.did_load_filetypes = 1

	-- Do not load native syntax completion
	vim.g.loaded_syntax_completion = 1

	-- Do not load spell files
	vim.g.loaded_spellfile_plugin = 1

	-- Whether to load netrw by default
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwFileHandlers = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.loaded_netrwSettings = 1
	-- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
	vim.g.netrw_liststyle = 3

	-- Do not load tohtml.vim
	vim.g.loaded_2html_plugin = 1

	-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
	-- related to checking files inside compressed files)
	vim.g.loaded_gzip = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.loaded_zipPlugin = 1

	-- Do not use builtin matchit.vim and matchparen.vim since the use of vim-matchup
	vim.g.loaded_matchit = 1
	vim.g.loaded_matchparen = 1

	-- Disable sql omni completion.
	vim.g.loaded_sql_completion = 1

	-- Disable EditorConfig support
	vim.g.editorconfig = 1

	-- Disable remote plugins
	-- NOTE: Disabling rplugin.vim will show error for `wilder.nvim` in :checkhealth,
	-- NOTE:  but since it's config doesn't require python rtp, it's fine to ignore.
	-- vim.g.loaded_remote_plugins = 1
end

local leader_map = function()
	vim.g.mapleader = " "
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
	vim.o.guifont = "JetBrainsMono Nerd Font:h18"
	vim.opt.linespace = 10
	vim.keymap.set("c", "<D-v>", "<C-R>") -- Paste command mode
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_profiler = false
	vim.g.neovide_input_macos_alt_is_meta = false
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_unfocused_outline_width = 0.125
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

local clipboard_config = function()
	if global.is_mac then
		vim.g.clipboard = {
			name = "macOS-clipboard",
			copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
			paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
			cache_enabled = 0,
		}
	elseif global.is_wsl then
		vim.g.clipboard = {
			name = "win32yank-wsl",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
			cache_enabled = 0,
		}
	end
end

local load_core = function()
	createdir()
	disable_distribution_plugins()
	leader_map()

	neovide_config()
	clipboard_config()

	require("core.options")
	require("core.mapping")
	require("keymap")
	require("core.event")
	require("core.pack")

	local colorscheme = require("core.settings").colorscheme
	local background = require("core.settings").background
	vim.api.nvim_command("set background=" .. background)
	vim.api.nvim_command("colorscheme " .. colorscheme)
end

load_core()
