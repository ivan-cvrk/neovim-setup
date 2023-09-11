local folderOfThisFile = (...):match("(.-)[^%.]+$")

return {
    setup = function(bufnr)
        local pylint = require(folderOfThisFile .. 'pyright.lint')
        local pyformat = require(folderOfThisFile .. 'pyright.format')
        pylint.attachlinting(bufnr)
        pyformat.attachformat(bufnr)
    end
}
