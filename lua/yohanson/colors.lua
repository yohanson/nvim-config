vim.o.termguicolors = true
-- Two colorschemes intentionally, result differs from single.
vim.cmd.colorscheme("habamax")
vim.cmd.colorscheme("PaperColor")
-- vim.api.nvim_set_hl(0, "Normal", { ctermbg=235 }) -- a little lighter background
-- vim.api.nvim_set_hl(0, "Visual", { ctermbg=103, ctermfg=16 })

vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultError", { fg='Red', bg='none' })
-- vim.cmd([[highlight LspSignatureActiveParameter ctermbg=darkgrey]])
-- vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultWarning", { bold=true, ctermfg=208, ctermbg='none' })
vim.api.nvim_set_hl(0, "DiagnosticsVirtualLinesWarn", { bold=false, fg=208, bg='none', link='NONE' })
vim.api.nvim_set_hl(0, "@type.builtin", { link = '@type' })

-- vim.cmd([[highlight markdownError guifg=None guibg=None]])
-- vim.cmd([[highlight htmlError guifg=None guibg=None]])

-- vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
