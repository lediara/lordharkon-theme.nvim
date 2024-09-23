local M = {}

function M.load(theme)
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "lordharkon"

    if ts.new_style() then
        for group, colors in pairs(ts.defaults) do
            if not theme.highlights[group] then
                M.highlight(group, colors)
            end
        end
    end
    M.syntax(theme.highlights)

    -- vim.api.nvim_set_hl_ns(M.ns)
    if theme.config.terminal_colors then
        M.terminal(theme.colors)
    end

    M.autocmds(theme.config)

    vim.defer_fn(function()
        M.syntax(theme.defer)
    end, 100)
end

return M
