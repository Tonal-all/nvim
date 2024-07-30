require("cmp").setup.buffer({
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                buffer = "[Buffer]",
                -- formatting for other sources
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "copilot", group_index = 2 },
        { name = "omni" },
        { name = "buffer" },
        { name = "snippy" }, -- For snippy users.
        -- other sources
    },
})
