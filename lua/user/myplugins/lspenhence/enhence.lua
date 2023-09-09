local folderOfThisFile = (...):match("(.-)[^%.]+$")

local lang_server_enhancers = {
    pyright = function(bufnr)
        local pylint = require(folderOfThisFile .. 'pyright.lint')
        local pyformat = require(folderOfThisFile .. 'pyright.format')
        pylint.attachlinting(bufnr)
        pyformat.attachformat(bufnr)
    end
}

local function enhence(client_name, bufnr)
    local enhencer = lang_server_enhancers[client_name]
    if enhencer ~= nil then
        enhencer(bufnr)
    end
end

return enhence
