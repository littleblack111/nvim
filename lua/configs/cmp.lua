--
-- AstroNvim/LunarVim style CMP organization
-- This file handles all the nvim-cmp and LuaSnip configuration
--

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Safely require icons with better error handling
local icons = {}
do
  -- Use pcall to safely require the icons module
  local status_ok, icons_module = pcall(require, "configs.icons")
  if status_ok and icons_module and type(icons_module) == "table" and icons_module.kinds then
    icons = icons_module.kinds
  else
    -- Fallback icons if the module fails to load
    icons = {
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
    }
  end
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Utility Functions                                        │
-- ╰──────────────────────────────────────────────────────────╯

-- Check if we can jump in the snippet
local function jumpable(dir)
  local win_get_cursor = vim.api.nvim_win_get_cursor
  local get_current_buf = vim.api.nvim_get_current_buf

  local function jumpable_in_direction(dir)
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then
      return false
    end

    local win = vim.api.nvim_get_current_win()
    local cursor = win_get_cursor(win)
    local buf = get_current_buf()

    local node = luasnip.get_node_at_cursor()
    if not node then
      return false
    end

    local jump_direction
    if dir == 1 then
      jump_direction = luasnip.jumpable(1)
    else
      jump_direction = luasnip.jumpable(-1)
    end
    return jump_direction
  end

  if jumpable_in_direction(dir) then
    return true
  end
  return false
end

-- Check if Copilot has a suggestion
local function has_copilot_suggestion()
  -- Check if copilot.vim is loaded
  local exists = vim.fn.exists('*copilot#GetDisplayedSuggestion') == 1
  if not exists then return false end
  
  -- Get the displayed suggestion
  local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
  
  -- Check if there's actual suggestion text
  return suggestion and suggestion.text and suggestion.text ~= ""
end

local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Source Configuration                                     │
-- ╰──────────────────────────────────────────────────────────╯

M.cmp = {
  -- Prioritize sources: LSP first, then snippets, buffer, path
  sources = cmp.config.sources({
    { 
      name = "nvim_lsp", 
      priority = 1000,
      -- Filter to allow Copilot to take precedence if needed
      entry_filter = function(entry, ctx)
        if has_copilot_suggestion() then
          return false
        end
        return true
      end
    },
    { name = "luasnip", priority = 750 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
  }),
  
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Formatting                                               │
  -- ╰──────────────────────────────────────────────────────────╯
  formatting = {
    format = function(entry, vim_item)
      -- Set icons for completion items
      if icons[vim_item.kind] then
        vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
      end
      
      -- Show source name in completion menu
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      
      return vim_item
    end,
  },
  
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Key Mappings                                             │
  -- ╰──────────────────────────────────────────────────────────╯
  mapping = cmp.mapping.preset.insert({
    -- Accept suggestion with Ctrl-y
    ["<C-y>"] = cmp.mapping.confirm({ 
      behavior = cmp.ConfirmBehavior.Replace, -- Use Replace to keep original text
      select = false -- Only confirm if explicitly selected
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace, -- Use Replace to keep original text
      select = false -- Only confirm if explicitly selected
    }),
    
    -- Navigation
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    
    -- Control
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    
    -- Snippet navigation
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    
    -- Use Ctrl+f for next snippet placeholder as in LunarVim
    ["<C-f>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    
    -- Tab key behavior (for Copilot/AI integration)
    ["<Tab>"] = cmp.mapping(function(fallback)
      if has_copilot_suggestion() then
        -- Accept Copilot suggestion directly using the Accept function
        -- This is the correct way to accept Copilot suggestions
        vim.api.nvim_feedkeys(
          vim.fn['copilot#Accept'](''),
          'n', 
          true
        )
      elseif cmp.visible() then
        -- If completion menu is visible, select next item
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        -- If we're in a snippet, jump to next position
        luasnip.expand_or_jump()
      else
        -- Otherwise fall back to normal Tab behavior
        fallback()
      end
    end, { "i", "s" }),
  }),
  
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Window Appearance                                        │
  -- ╰──────────────────────────────────────────────────────────╯
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:CmpDocSel,Search:None",
    }),
  },
  
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Snippet Handling                                         │
  -- ╰──────────────────────────────────────────────────────────╯
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Completion Behavior                                      │
  -- ╰──────────────────────────────────────────────────────────╯
  completion = {
    completeopt = "menu,menuone,noinsert", -- Avoid replacing text on completion
  },
  
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Experimental Features                                    │
  -- ╰──────────────────────────────────────────────────────────╯
  experimental = {
    ghost_text = false, -- Disable ghost text as it can interfere with Copilot
  },
}

-- Disable up/down arrow keys to prevent breaking expected navigation behavior
M.cmp.mapping["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
M.cmp.mapping["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })

return M