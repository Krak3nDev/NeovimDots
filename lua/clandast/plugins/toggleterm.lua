return {
	"akinsho/toggleterm.nvim",
	version = "*",
	dependencies = { "catppuccin" }, -- чтобы палитра catppuccin была доступна
	opts = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		return {
			open_mapping = [[<c-\>]],
			shade_terminals = false, -- не затемнять буфер терминала
			highlights = {
				Normal = {
					guibg = mocha.base, -- фон основного «окна» терминала
					guifg = mocha.text, -- цвет текста
				},
				NormalFloat = {
					guibg = mocha.mantle, -- фон всплывающих окон (если потребуется)
				},
				FloatBorder = {
					guifg = mocha.text, -- цвет обводки
					guibg = mocha.mantle, -- фон под обводкой
				},
			},
		}
	end,

}
