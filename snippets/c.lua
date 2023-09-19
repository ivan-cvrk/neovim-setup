if _G.LUASNIP_LOAD_DOC then
    _G.LUASNIP_LOAD_DOC()
end

local ts_utils = require('nvim-treesitter.ts_utils')

local ts_query = [[
(for_statement
    initializer: (declaration
        declarator: (init_declarator
            declarator: (identifier) @id)))
]]

vim.treesitter.query.set('c', 'ForVar', ts_query)

local function get_next_var_name()
    local for_node = ts_utils.get_node_at_cursor()
    while (for_node ~= nil) do
        if for_node:type() == 'for_statement' then
            break
        end
        for_node = for_node:parent()
    end

    if for_node == nil then
        return sn(1, t('i'))
    end

    local query = vim.treesitter.query.get('c', 'ForVar')
    local _, node = query:iter_captures(for_node, 0)()

    if node == nil then
        return sn(1, t('i'))
    end

    local node_text = vim.treesitter.get_node_text(node, 0)

    if node_text:len() ~= 1 then
        return sn(1, t('i'))
    end

    local next_char = string.char(node_text:byte() + 1)
    return sn(1, t(next_char))
end

return {
    s({ trig = 'main', dscr = 'main boilerplate' }, fmt(
        [[
        #include <stdio.h>

        int main() {{
            {}

            return 0;
        }}
        ]],
        { i(0) }
    )),
    s({ trig = 'for', dscr = 'for loop' }, fmt(
        [[
        for (int {} = {}; {} < {}; {}++) {{
            {}
        }}
        ]],
        { d(1, get_next_var_name), i(2, '0'), rep(1), i(3), rep(1), i(0) }
    )),
}
