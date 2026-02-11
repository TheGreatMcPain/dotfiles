return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "uga-rosa/cmp-dictionary",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "vtsls",
                "ty",
                "ruff",
            }
        })

        vim.lsp.config('zls', {
            settings = {
                zls = {
                    enable_inlay_hints = true,
                    enable_snippets = true,
                    warn_style = true,
                }
            }
        })
        vim.g.zig_fmt_parse_errors = 0
        vim.g.zig_fmt_autosave = 0
        vim.lsp.enable('zls')

        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    format = {
                        enable = true,
                        -- Put format options here
                        -- NOTE: the value should be STRING!!
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        }
                    },
                }
            }
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('ty', {
            settings = {
                ty = {
                    diagnosticMode = "off",
                    inlayHints = {
                        variableTypes = false,
                        callArgumentNames = false,
                    }
                }
            }
        })
        vim.lsp.enable('ty')

        vim.lsp.config('ruff', {
            init_options = {
                settings = {
                    lineLength = 100,
                    showSyntaxErrors = true,
                }
            }
        })

        vim.lsp.config('ccls', {
            init_options = {
                index = {
                    threads = 0,
                }
            }
        })
        vim.lsp.enable('ccls')

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                {
                    name = 'dictionary',
                    keyword_length = 2,
                },
            }, {
                { name = 'buffer' },
            })
        })

        require("cmp_dictionary").setup({
            paths = { "/usr/share/dict/words" },
            exact_length = 2,
        })

        vim.diagnostic.config({
            update_in_insert = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })
    end
}
