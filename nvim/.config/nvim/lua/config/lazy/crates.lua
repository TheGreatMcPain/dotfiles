return {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
        require('crates').setup({
            lsp = {
                enable = true,
                actions = true,
                completion = true,
                hover = true,
            }
        })
    end,
}
