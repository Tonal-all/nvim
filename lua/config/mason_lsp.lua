vim.keymap.set("n", "<Space>f", function()
    vim.lsp.buf.format({ async = true })
end)

local opts = { noremap = true, silent = true }
local navic = require("nvim-navic")

local function on_attach(client, bufnr)
    navic.attach(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    function(server_name)       -- default handler (optional)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities, --cmpを連携⇐ココ！
            on_attach = on_attach,
        })
    end,
    -- ["rust_analyzer"] = function()
    -- end,
    ["clangd"] = function()
        capabilities.offsetEncoding = { "utf-16" }
        require("lspconfig").clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
    ["pyright"] = function()
        require("lspconfig").pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pyright = { autoImportCompletion = true },
                python = {
                    venvPath = ".",
                    -- pythonPath = "./.venv/bin/python",
                    analysis = {
                        extraPaths = { "." },
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "off",
                    },
                },
            },
        })
    end,
})
require("lspconfig").scheme_langserver.setup({
    cmd = { "/root/.local/opt/scheme-langserver/run", "/root/.local/opt/scheme-langserver/run.log", "enable" },
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.cmd([[ au BufRead,BufNewFile *.sls set filetype=scheme ]])
