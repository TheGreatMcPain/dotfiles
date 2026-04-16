vim.pack.add({
    "https://github.com/f4z3r/gruvbox-material.nvim",
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    {
        src = "https://github.com/mrcjkb/rustaceanvim",
    },
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/brenoprata10/nvim-highlight-colors",
})

vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.colorcolumn = "100"
--vim.opt.signcolumn = "yes:1"
vim.opt.textwidth = 100
vim.opt.wrap = false

vim.opt.complete = ".,o,w,b,u"
vim.opt.completeopt = "fuzzy,menuone,popup,noselect"
vim.opt.autocomplete = true
vim.opt.pumheight = 10 -- Don't make the autocomplete window so huge.

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.showtabline = 2

require("gruvbox-material").setup({
    require("gruvbox-material").setup({
        italics = true, -- enable italics in general
        contrast = "soft", -- set contrast, can be any of "hard", "medium", "soft"
        comments = {
            italics = true, -- enable italic comments
        },
        background = {
            transparent = true, -- set the background to be transparent
        },
        float = {
            force_background = true,
        },
    }),
})

-- Only use treesitter
--vim.cmd("syntax off")

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "bashls",
        "stylua",
        "ty",
        "ruff",
        "jsonls",
    },
})

require("fidget").setup({})

require("nvim-highlight-colors").setup({
    render = "virtual",
    virtual_symbol = "⚫︎",
    virtual_symbol_suffix = "",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.o.signcolumn = "yes:1"
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- Enable completion for LSPs
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true,
            })
        end

        -- Enable formatting on save.
        if
            not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.lsp.enable({
    "lua_ls",
    "bashls",
    "ty",
    "ruff",
    "ccls",
    "jsonls",
})
