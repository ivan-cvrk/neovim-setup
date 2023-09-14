if _G.LUASNIP_LOAD_DOC then
    _G.LUASNIP_LOAD_DOC()
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
        { i(1, 'i'), i(2, '0'), rep(1), i(3), rep(1), i(0) }
    )),
}
