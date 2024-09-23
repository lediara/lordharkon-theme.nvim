local hsl = require('lordhakon.hsl')

local M = {}

---@class Palette
M.default {
    none = "NONE",

    base04 = hsl(50, 55, 18),
    base03 = hsl(50, 55, 15),
    base02 = hsl(54, 55, 13),
    base01 = hsl(54, 55, 11),
    base00 = hsl(57, 53, 8),
}

---@class ColorScheme: Palette
function M.setup(opts)
    opts = opts or {}

    local style = "default"
    local palette = M[style] or {}
    if type(palette) == "function" then
        palette = palette()
    end

    ---@class ColorScheme: Palette
    local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

    return colors
end

return M
