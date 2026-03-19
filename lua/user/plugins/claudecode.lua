return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      provider = "external",
      provider_opts = {
        external_terminal_cmd = "ghostty --window-save-state=never -e %s",
      },
    },
  },
  keys = {
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       desc = "Send to Claude", mode = "v" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}
