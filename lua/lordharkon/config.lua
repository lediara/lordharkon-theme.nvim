local M = {}

M.options = {
    style = "dark",
    use_background = true,
}

function M.get_theme()
    local theme = require('lordharkon.theme') -- Assuming your theme logic is in 'theme.lua'
    return theme
end

function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

function M.extend(opts)
    M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
