local status_ok_dap, dap = pcall(require, 'dap')
if not status_ok_dap then
    return
end



local status_ok_ui, neodev = pcall(require, 'neodev')
if not status_ok_ui then
    return
end

neodev.setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local status_ok_tel, telescope = pcall(require, 'telescope')
if not status_ok_tel then
    return
end

local status_ok_vt, nvim_dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not status_ok_vt then
    return
end


