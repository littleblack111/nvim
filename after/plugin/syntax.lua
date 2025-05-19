
-- Set up additional highlights for better identification of variables and functions

-- Function to define custom highlights
local function enhance_syntax_highlighting()
  -- Define highlight groups for better visibility
  local highlight_groups = {
    -- Function names (various languages)
    { group = "Function", fg = "#88c0d0", bold = true },
    -- Variable names 
    { group = "Identifier", fg = "#81a1c1" },
    -- Method names
    { group = "Method", fg = "#88c0d0", italic = true },
    -- Parameters in function calls
    { group = "Parameter", fg = "#8fbcbb", italic = true },
    -- Structure and class names
    { group = "Structure", fg = "#a3be8c", bold = true },
    -- Property and object fields
    { group = "Property", fg = "#b48ead" },
  }

  -- Apply the highlights
  for _, hl in ipairs(highlight_groups) do
    local cmd = "highlight! " .. hl.group
    if hl.fg then cmd = cmd .. " guifg=" .. hl.fg end
    if hl.bg then cmd = cmd .. " guibg=" .. hl.bg end
    
    local style = ""
    if hl.bold then style = style .. "bold," end
    if hl.italic then style = style .. "italic," end
    if hl.underline then style = style .. "underline," end
    if style ~= "" then
      -- Remove trailing comma
      style = style:sub(1, -2)
      cmd = cmd .. " gui=" .. style
    end
    
    vim.cmd(cmd)
  end
  
  -- Link Treesitter captures to our enhanced highlight groups
  local ts_links = {
    ["@variable"] = "Identifier",
    ["@variable.builtin"] = "Special",
    ["@parameter"] = "Parameter",
    ["@field"] = "Property",
    ["@property"] = "Property",
    ["@function"] = "Function",
    ["@function.call"] = "Function",
    ["@function.builtin"] = "Special",
    ["@method"] = "Method",
    ["@method.call"] = "Method",
    ["@constructor"] = "Special",
    ["@class"] = "Structure",
  }
  
  for capture, link in pairs(ts_links) do
    vim.cmd("highlight! link " .. capture .. " " .. link)
  end
end

-- Apply enhanced syntax highlighting
enhance_syntax_highlighting()

-- Reapply highlighting when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    enhance_syntax_highlighting()
  end,
})
