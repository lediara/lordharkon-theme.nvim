local util = require 'lordharkon.utils'
local config = require 'lordharkon.config'


local M = {}

function M._load(style)
    M.load({ style = style, use_background = style == nil })
end

function M.load(opts)
  if opts then
    require("lordharkon.config").extend(opts)
  end
  util.load(config.setup())
end

M.setup = config.setup
M.colorscheme = M.load

return M
