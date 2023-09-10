return {
    s('main',
        fmt(
            [[
            #include <stdio.h>

            int main() {{
                {}

                return 0;
            }}
            ]],
            { i(0) }
    )),
}
