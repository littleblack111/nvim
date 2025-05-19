-- Icons for various UI elements including completion items

return {
  kinds = {
    -- Completion item kinds
    Text = "  ",
    Method = "  ",
    Function = "  ",
    Constructor = "  ",
    Field = "  ",
    Variable = "  ",
    Class = "  ",
    Interface = "  ",
    Module = "  ",
    Property = "  ",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
  },
  
  -- Git status icons
  git = {
    added = "✓",
    modified = "●",
    removed = "✗",
    renamed = "➜",
    untracked = "★",
    ignored = "◌",
    unstaged = "✹",
    staged = "✓",
    conflict = "✘",
  },
  
  -- Diagnostic icons  
  diagnostics = {
    error = " ",
    warn = " ", 
    info = " ",
    hint = " ",
  },
}