local M = {}

-- Default options
local defaults = {
    style = "default",
    terminal_colors = true,
}

-- Holds the merged options
M.options = {}

-- Utility function to merge options
local function merge_options(base, new_options)
    return vim.tbl_deep_extend("force", {}, base, new_options or {})
end

-- Setup function to initialize options with defaults
function M.setup(options)
    M.options = merge_options(defaults, options)
end

-- Extend function to modify or override existing options
function M.extend(options)
    if not options or type(options) ~= "table" then
        error("Invalid options passed to extend. Must be a table.")
    end
    M.options = merge_options(M.options, options)
end

return M
