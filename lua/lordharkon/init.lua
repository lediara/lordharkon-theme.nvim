local util = require("lordharkon.util")
local colors = require("lordharkon.colors")

local M = {}

function M.load()
    util.load(colors.setup())
end

-- keep for backward compatibility
M.colorscheme = M.load

return M
