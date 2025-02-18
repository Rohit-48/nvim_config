-- Import lsp-zero and apply the recommended preset
local lsp = require("lsp-zero")
lsp.preset("recommended")

-- Ensure the following LSP servers are installed:
lsp.ensure_installed({
  "clangd",         -- C/C++
  "ts_ls",          -- JavaScript/TypeScript (updated)
  "rust_analyzer",  -- Rust
  "pyright",        -- Python
  "lua_ls"          -- Lua (for Neovim configuration)
})

-- Define common keybindings when an LSP attaches to a buffer
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
end)

-- Configure nvim-cmp for autocompletion
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>']  = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- Finalize LSP setup
lsp.setup()

-- Optional: Configure diagnostics to show virtual text
vim.diagnostic.config({
  virtual_text = true,
})

