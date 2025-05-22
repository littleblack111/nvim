local cmp = require "cmp"
local luasnip = require "luasnip"

local icons = {}
do
  local status_ok, icons_module = pcall(require, "configs.icons")
  if status_ok and icons_module and type(icons_module) == "table" and icons_module.kinds then
    icons = icons_module.kinds
  else
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

local function has_copilot_suggestion()
  local exists = vim.fn.exists "*copilot#GetDisplayedSuggestion" == 1
  if not exists then
    return false
  end

  local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()

  return suggestion and suggestion.text and suggestion.text ~= ""
end

local M = {}

M.cmp = {

  sources = cmp.config.sources {
    {
      name = "nvim_lsp",
      priority = 1000,
      entry_filter = function()
        return true -- Always show LSP suggestions regardless of other plugins
      end,
      group_index = 1,
    },
    { name = "luasnip", priority = 750, group_index = 1 },
    { name = "buffer", priority = 500, group_index = 2 },
    { name = "path", priority = 250, group_index = 2 },
  },

  formatting = {
    format = function(entry, vim_item)
      if icons[vim_item.kind] then
        vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      end

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]

      return vim_item
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },

    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),

    ["<C-l>"] = cmp.mapping(function()
      cmp.complete {
        config = {
          sources = {
            { name = "nvim_lsp" },
          },
        },
      }
    end),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),

    ["<C-f>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),
  },

  window = {
    completion = cmp.config.window.bordered {
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
    },
    documentation = cmp.config.window.bordered {
      winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:CmpDocSel,Search:None",
    },
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  experimental = {
    ghost_text = false,
  },
}

M.cmp.mapping["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }
M.cmp.mapping["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }

return M
