return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>Di", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)
      opts.desc = "Prev diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      opts.desc = "Next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      opts.desc = "Show documentation"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Helper for new-style server startup
    local function setup(server, config)
      vim.lsp.config(server, vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach,
      }, config or {}))

      vim.lsp.enable(server)
    end

    -- Language servers
    setup("html")
    setup("ts_ls")
    setup("pylsp", {
	  filetypes = { "python" },
	})
    setup("ruff", {
	  filetypes = { "python" },
	})
    setup("cssls")
    setup("tailwindcss")
    setup("prismals")
    setup("svelte")
    setup("clangd")
	setup("lua_ls", {
	  filetypes = { "lua" },
	})

    setup("emmet_ls", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    })
  end,
}
