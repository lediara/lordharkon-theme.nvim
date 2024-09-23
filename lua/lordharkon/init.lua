local util = require 'lordharkon.utils'
local config = require 'lordharkon.config'

local M = {}

-- Internal function to load the theme with a specific style
function M._load(style)
    -- Load the theme, use default background if style is not provided
    M.load({ style = style, use_background = style == nil })
end

-- Main load function for setting up the theme
function M.load(opts)
  -- Extend options if provided
  if opts then
    config.extend(opts)
  end

  -- Ensure the theme is loaded correctly
  local theme = config.get_theme() -- Assuming you have a function to get the theme
  if theme then
    util.load(theme.setup()) -- Load the theme setup using utilities
  else
    error("No theme found! Check your configuration.")
  end
end

-- Setup function to initialize configuration
M.setup = config.setup

-- Alias for load function to make it easier to load the colorscheme
M.colorscheme = M.load

return M
