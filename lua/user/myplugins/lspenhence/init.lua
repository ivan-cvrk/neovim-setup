local folderOfThisFile = (...):match("(.-)[^%.]+$")

local lang_server_enhancers = {
    pyright = function(bufnr)
        require(folderOfThisFile .. 'lspenhence.pyright').setup(bufnr)
    end
}

local function enhence(client_name, bufnr)
    local enhencer = lang_server_enhancers[client_name]
    if enhencer ~= nil then
        enhencer(bufnr)
    end
end

return { enhence = enhence }
