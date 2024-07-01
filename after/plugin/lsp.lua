local lsp_zero = require('lsp-zero')

-- Initialize lsp-zero with a preset
lsp_zero.preset('recommended')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- Ensure mason and mason-lspconfig are installed and set up
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'pyright', 'pylsp', 'lua_ls'}, -- Ensure Python LSPs are installed
    handlers = {
        function(server_name)
            local opts = lsp_zero.build_options(server_name, {})
            require('lspconfig')[server_name].setup(opts)
        end,
    }
})


local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- confirm completion
    ['<C-y>'] = cmp.mapping.confirm({select = true}),

    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),   
  }),
})

-- Ensure lsp-zero is set up
lsp_zero.setup()

