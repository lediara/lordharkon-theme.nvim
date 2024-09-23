local M = {}

M.default = {}

---@return ColorScheme
function M.setup(opts)
    opts = opts or {}
    local config = require("lordharkon.config")

    -- local style = config.is_day() and config.options.light_style or config.options.style
    local style = "default"
    local palette = M[style] or {}
    if type(palette) == "function" then
        palette = palette()
    end

    -- Color Palette
    ---@class ColorScheme: Palette
    local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)
    return colors
end

return M
