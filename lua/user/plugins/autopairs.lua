-- Setup module
local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    return
end

npairs.setup {
    lheck_ts = true,
    ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
        java = false,
    },
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
}
