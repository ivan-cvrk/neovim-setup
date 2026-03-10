return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "cpp", "lua", "python", "go", "vimdoc" },
        sync_install = false,
        auto_install = true,
      })

      -- Enable Tree-sitter highlighting for these filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "lua", "python", "go", "vim", "help", "markdown" },
        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype) or vim.bo[buf].filetype

          if lang == "html" then
            return
          end

          local max_filesize = 100 * 1024 -- 100 KB
          local name = vim.api.nvim_buf_get_name(buf)
          local ok, stats = pcall(vim.uv.fs_stat, name)
          if ok and stats and stats.size > max_filesize then
            vim.notify(
              "File larger than 100KB, Tree-sitter disabled for performance",
              vim.log.levels.WARN,
              { title = "Treesitter" }
            )
            return
          end

          pcall(vim.treesitter.start, buf)
        end,
      })

      -- Keep Vim regex highlighting for markdown too
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          vim.bo.syntax = "on"
        end,
      })
    end,
  },
}
