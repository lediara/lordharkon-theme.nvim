local M = {}

-- Default color palette
M.default = {
  base03 = "#002b36",
  base02 = "#073642",
  base01 = "#586e75",
  base00 = "#657b83",
  base0  = "#839496",
  base1  = "#93a1a1",
  base2  = "#eee8d5",
  base3  = "#fdf6e3",
  yellow = "#b58900",
  orange = "#cb4b16",
  red    = "#dc322f",
  magenta= "#d33682",
  violet = "#6c71c4",
  blue   = "#268bd2",
  cyan   = "#2aa198",
  green  = "#859900",
}

-- Setup function for applying or extending color palettes
function M.setup(opts)
    opts = opts or {}

    -- Style option allows for multiple predefined palettes
    local style = opts.style or "default"
    
    -- Fetch the chosen palette or default to empty if not found
    local palette = M[style] or {}
    
    -- If the palette is a function (for dynamic themes), evaluate it
    if type(palette) == "function" then
        palette = palette()
    end

    -- Deep merge the default colors with the chosen palette (style)
    local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)
    
    -- Optional: Allow overriding individual colors via `opts.overrides`
    if opts.overrides then
        colors = vim.tbl_deep_extend("force", colors, opts.overrides)
    end

    -- Return the final merged color palette
    return colors
end

return M
