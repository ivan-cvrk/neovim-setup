if _G.LUASNIP_LOAD_DOC then
  _G.LUASNIP_LOAD_DOC()
end


local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt


local ts_query = [[
(for_statement
    initializer: (declaration
        declarator: (init_declarator
            declarator: (identifier) @id)))
]]

-- Get the Tree-sitter parser for the C language
local function get_next_var_name()
  -- Get the current node at cursor
  local for_node = vim.treesitter.get_node()

  -- Traverse up to find the nearest for_statement
  while for_node do
    if for_node:type() == 'for_statement' then
      break
    end
    for_node = for_node:parent()
  end

  -- Return default 'i' if no for_statement found
  if not for_node then
    return sn(1, t('i'))
  end

  -- Parse the query for C language
  local query = vim.treesitter.query.parse('c', ts_query)

  -- Iterate over captures to find the identifier
  for _, node, _ in query:iter_captures(for_node, 0) do
    if node then
      -- Get node text using built-in API
      local node_text = vim.treesitter.get_node_text(node, 0)

      if not node_text or #node_text ~= 1 then
        return sn(1, t('i'))
      end

      -- Increment the character to get the next variable name
      local next_char = string.char(node_text:byte() + 1)
      return sn(1, t(next_char))
    end
  end

  -- Return default 'i' if no valid identifier found
  return sn(1, t('i'))
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
