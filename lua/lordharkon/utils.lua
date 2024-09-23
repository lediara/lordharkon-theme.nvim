local M = {}

-- Function to apply the theme and handle syntax highlighting
function M.load(theme)
    -- Clear any existing highlights if a colorscheme is already active
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    -- Enable true colors and set the theme name
    vim.o.termguicolors = true
    vim.g.colors_name = "lordharkon"

    -- Apply Treesitter styles if available
    M.apply_treesitter(theme)

    -- Apply syntax highlights
    M.syntax(theme.highlights)

    -- Apply terminal colors if enabled in the config
    if theme.config.terminal_colors then
        M.terminal(theme.colors)
    end

    -- Set any autocommands related to the theme
    M.autocmds(theme.config)

    -- Defer additional syntax highlighting to allow the editor to load
    vim.defer_fn(function()
        M.syntax(theme.defer)
    end, 100)
end

-- Function to handle Treesitter-specific styles
function M.apply_treesitter(theme)
    if ts and ts.new_style then
        -- Apply default Treesitter styles if no specific highlight is provided
        for group, colors in pairs(ts.defaults) do
            if not theme.highlights[group] then
                M.highlight(group, colors)
            end
        end
    else
        vim.notify("Treesitter not found or new_style method is missing", vim.log.levels.WARN)
    end
end

-- Function to handle terminal color setup
function M.terminal(colors)
    -- Set terminal colors based on the theme
    for i = 0, 15 do
        vim.g["terminal_color_" .. i] = colors[i] or colors.default[i]
    end
end

-- Function to apply autocommands for the theme
function M.autocmds(config)
    -- Set autocommands related to the theme here
    vim.cmd([[
        augroup MyColorscheme
            autocmd!
            autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
        augroup END
    ]])
    -- Add more custom autocommands based on config if needed
end

-- Function to apply syntax highlighting groups
function M.syntax(highlights)
    for group, colors in pairs(highlights) do
        M.highlight(group, colors)
    end
end

-- Helper function to set highlight groups
function M.highlight(group, colors)
    local cmd = 'highlight ' .. group
    if colors.fg then
        cmd = cmd .. ' guifg=' .. colors.fg
    end
    if colors.bg then
        cmd = cmd .. ' guibg=' .. colors.bg
    end
    if colors.style then
        cmd = cmd .. ' gui=' .. colors.style
    end
    vim.cmd(cmd)
end

return M
