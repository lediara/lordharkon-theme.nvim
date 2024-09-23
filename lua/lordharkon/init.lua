local util = require 'lordharkon.utils'
local config = require 'lordharkon.config'

local M = {}

-- Internal function to load the theme with a specific style
function M._load(style)
    -- Load the theme with default background if style is not provided
    M.load({ style = style or "default", use_background = style == nil })
end

-- Main load function for setting up the theme
function M.load(opts)
    -- Extend options if provided
    if opts then
        config.extend(opts)
    end

    -- Ensure the theme is loaded correctly from config
    local theme = config.get_theme() -- Make sure get_theme() returns the correct theme object
    if theme and theme.setup then
        util.load(theme.setup()) -- Call the theme's setup function
    else
        error("Theme not found or theme setup function missing! Check your configuration.")
    end
end

-- Setup function to initialize configuration
M.setup = config.setup

-- Alias for the load function to make it easier to load the colorscheme
M.colorscheme = M.load

return M
