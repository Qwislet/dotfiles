return { {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
        require("nvim-surround").setup()
    end
}, {
    "bennypowers/splitjoin.nvim",
    keys = { {
        "gJ",
        function()
            require("splitjoin").join()
        end,
        desc = "Join the object under cursor"
    }, {
        "gS",
        function()
            require("splitjoin").split()
        end,
        desc = "Split the object under cursor"
    } }
}, {
    "phaazon/hop.nvim",
    branch = 'v2', -- optional but strongly recommended
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection
        hop.setup {}
        vim.keymap.set('', 'f', function()
            hop.hint_char1({
                direction = directions.AFTER_CURSOR,
                current_line_only = true
            })
        end, {
            remap = true
        })
        vim.keymap.set('', 'F', function()
            hop.hint_char1({
                direction = directions.BEFORE_CURSOR,
                current_line_only = true
            })
        end, {
            remap = true
        })
        vim.keymap.set('', 't', function()
            hop.hint_char1({
                direction = directions.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
            })
        end, {
            remap = true
        })
        vim.keymap.set('', 'T', function()
            hop.hint_char1({
                direction = directions.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
            })
        end, {
            remap = true
        })
    end
} }
