local configs = require("nvim-treesitter.configs")

configs.setup({
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { 'html' }
    },
    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = { "html", "xml" },
    },
    autopairs = {
        enable = true,
    },
})
