vim.cmd([[ au BufRead,BufNewFile *.sls set filetype=scheme ]])
require("lspconfig").scheme_langserver.setup({
    cmd = { "/root/.local/opt/scheme-langserver/run" },
})
