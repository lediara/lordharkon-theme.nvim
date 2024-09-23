local M = {}

---@param theme Theme
function M.load(theme)
  -- only needed to clear when not the default colorscheme
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
end

return M
