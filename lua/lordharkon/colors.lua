local M = {}

M.default = {}

function M.setup(opts)
    opts = opts or {}

    local style = "default"
    local palette = M[style] or {}
    if type(palette) == "function" then
        palette = palette()
    end

    -- Color Palette
    local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)
    return colors
end

return M
