local util = require("lordharkon.util")
local colors = require("lordharkon.colors")

local M = {}

-- Helper function to handle diagnostic highlights
local function set_diagnostic_highlights(theme)
    local severity_map = {
        Error = "Error",
        Warn = "Warning",
        Info = "Information",
        Hint = "Hint",
    }
    local types = { "Default", "VirtualText", "Underline" }

    for _, type in ipairs(types) do
        for snew, sold in pairs(severity_map) do
            theme.highlights["LspDiagnostics" .. type .. sold] = {
                link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
            }
        end
    end
end

-- Main theme setup function
function M.setup()
    local config = require("lordharkon.config")
    local options = config.options

    -- Build the theme structure
    local theme = {
        config = options,
        colors = colors.setup(), -- Setup colors
    }
    local c = theme.colors -- Color shortcut

    -- Initialize highlights
    theme.highlights = {}

    -- Handle LSP diagnostic highlights if `vim.diagnostic` does not exist
    if not vim.diagnostic then
        set_diagnostic_highlights(theme)
    end

    -- Handle inactive status line options
    if options.hide_inactive_statusline then
        local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

        -- StatusLineNC
        theme.highlights.StatusLineNC = inactive

        -- Defer inactive LuaLine sections
        theme.defer = {}
        for _, section in ipairs({ "a", "b", "c" }) do
            theme.defer["lualine_" .. section .. "_inactive"] = inactive
        end

        -- mini.statusline inactive
        theme.highlights.MiniStatuslineInactive = inactive
    end

    -- Call user-defined highlight customization (if exists)
    if options.on_highlights then
        options.on_highlights(theme.highlights, theme.colors)
    else
        error("Missing `on_highlights` in configuration options.")
    end

    -- Invert colors for day mode (if applicable)
    if config.is_day() then
        util.invert_colors(theme.colors)
        util.invert_highlights(theme.highlights)
    end

    return theme
end

return M
