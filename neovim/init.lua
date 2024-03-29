-- set leader to <Space>
vim.api.nvim_set_keymap(
  "",
  "<Space>",
  "<Nop>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<C-S>",
  "<ESC>:w<cr>",
  { noremap = true, silent = true }
)


-- F1
vim.api.nvim_set_keymap(
  "i",
  "<F1>",
  "<ESC>:w<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<F1>",
  "<ESC>:w<cr>",
  { noremap = true, silent = true }
)


-- F2
vim.api.nvim_set_keymap(
  "",
  "<F2>",
  "<ESC>:w<cr>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<F2>",
  "<ESC>:w<cr>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<C-S>",
  ":w<cr>",
  { noremap = true, silent = true }
)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.interestingWordsGUIColors = { '#BCCBEA', '#FFB3FF', '#FF0000', '#00ffff', '#99ff66', '#ff99cc', '#cc0000', '#ffff99', '#660066', '#339966' }

local opt = vim.opt

opt.number = true -- show line numbers
opt.relativenumber = true -- show relative numbers by default

-- show absolute numbers in insert mode, relative in normal mode

vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END
]])

opt.showmatch = true -- show matching brackets
opt.foldmethod = "syntax"

opt.smartindent = true -- use c-like indents when no indentexpr is used
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- use 2 spaces when inserting tabs
opt.tabstop = 2 -- show tabs as 2 spaces

opt.splitright = true -- vsplit to right of current window
opt.splitbelow = true -- hsplit to bottom of current window

opt.hidden = true -- allow background buffers

opt.scrolloff = 2 -- include 2 rows of context above/below current line
opt.sidescrolloff = 5 -- include 5 colums of context to the left/right of current column

opt.ignorecase = true -- ignore case in searches...
opt.smartcase = true -- ...unless we use mixed case

opt.joinspaces = false -- join lines without two spaces

opt.termguicolors = true -- allow true colors

opt.inccommand = "nosplit" -- show effects of substitute incrementally

opt.mouse = "a" -- enable mouse mode

opt.updatetime = 400 -- decrease time for cursorhold event


local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Bootstrap Packer
if fn.empty(fn.glob(install_path)) > 0 then

  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- Run PackerCompile whenever we edit this file with `nvim`.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use("tpope/vim-commentary")


  -- Colorscheme
  use({
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    after = "tokyonight.nvim",
    config = function()
      local colors = require("tokyonight.colors").setup({})

      require("bufferline").setup({
        options = {
          separator_style = "slant",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "gn",
        ":BufferLineCycleNext<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gp",
        ":BufferLineCyclePrev<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gq",
        ":BufferLinePickClose<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gh",
        ":BufferLinePick<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gb",
        ":b#<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "g]",
        ":BufferLineMoveNext<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "g[",
        ":BufferLineMovePrev<CR>",
        { noremap = true, silent = true }
      )
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Allow multi select https://github.com/nvim-telescope/telescope.nvim/issues/1048
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local custom_actions = {}

      function custom_actions._multiopen(prompt_bufnr, open_cmd)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local num_selections = #picker:get_multi_selection()
        if num_selections > 1 then
          local cwd = picker.cwd
          if cwd == nil then
            cwd = ""
          else
            cwd = string.format("%s/", cwd)
          end
          vim.cmd("bw!") -- wipe the prompt buffer
          for _, entry in ipairs(picker:get_multi_selection()) do
            vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
          end
          vim.cmd("stopinsert")
        else
          if open_cmd == "vsplit" then
            actions.file_vsplit(prompt_bufnr)
          elseif open_cmd == "split" then
            actions.file_split(prompt_bufnr)
          elseif open_cmd == "tabe" then
            actions.file_tab(prompt_bufnr)
          else
            actions.select_default(prompt_bufnr)
          end
        end
      end
      function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "vsplit")
      end
      function custom_actions.multi_selection_open_split(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "split")
      end
      function custom_actions.multi_selection_open_tab(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "tabe")
      end
      function custom_actions.multi_selection_open(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "edit")
      end

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<tab>"] = actions.toggle_selection
                + actions.move_selection_next,
              ["<s-tab>"] = actions.toggle_selection
                + actions.move_selection_previous,
              ["<cr>"] = custom_actions.multi_selection_open,
              ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
              ["<c-s>"] = custom_actions.multi_selection_open_split,
              ["<c-t>"] = custom_actions.multi_selection_open_tab,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<tab>"] = actions.toggle_selection
                + actions.move_selection_next,
              ["<s-tab>"] = actions.toggle_selection
                + actions.move_selection_previous,
              ["<cr>"] = custom_actions.multi_selection_open,
              ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
              ["<c-s>"] = custom_actions.multi_selection_open_split,
              ["<c-t>"] = custom_actions.multi_selection_open_tab,
            },
          },
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<leader><space>",
        [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sf",
        [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sb",
        [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
        { noremap = true, silent = true }
      )
    end,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({})

      vim.api.nvim_set_keymap(
        "n",
        "<C-n>",
        ":NvimTreeToggle<CR>",
        { noremap = true, silent = true }
      )
    end, })


  use({"lfv89/vim-interestingwords"})

  use("L3MON4D3/LuaSnip")
  use({
    "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-buffer" },
    after = "LuaSnip",
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
          }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
      })
    end,
  })
  
  use({
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
  })

  use({
    "Pocco81/auto-save.nvim",
    require("auto-save").setup({
        enabled = true,
    })
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
