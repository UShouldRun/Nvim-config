function ColorScheme(color)
	color = color or 'everblush'
	vim.cmd.colorscheme(color)
	
	-- List of highlight groups to make transparent
	local groups = {
		"Normal", "NormalFloat", "LineNr", "SignColumn", "LineNrAbove", "LineNrBelow",
		"CursorLine", "CursorLineNr", "FoldColumn", "Folded", "StatusLine", "StatusLineNC",
		"TabLine", "TabLineFill", "TabLineSel", "VertSplit", "WinSeparator", "EndOfBuffer",
		"Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb", "WildMenu", "Question", "MoreMsg",
		"MsgArea", "MsgSeparator", "NormalNC", "FloatBorder", "FloatTitle", "FloatFooter",
    -- Telescope specific groups
		"TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal", "TelescopePromptBorder",
		"TelescopeResultsNormal", "TelescopeResultsBorder", "TelescopePreviewNormal", "TelescopePreviewBorder",
		"TelescopePromptTitle", "TelescopeResultsTitle", "TelescopePreviewTitle"
	}
	
	-- Remove background from all specified groups
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end

ColorScheme()
