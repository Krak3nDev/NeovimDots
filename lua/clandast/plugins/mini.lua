return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- Example: automatic pairs of brackets/quotes
		require("mini.pairs").setup()

		-- Example: extended text objects (a{..}, i{..}, etc.)
		require("mini.ai").setup()

		-- Example: easy commenting of lines and blocks
		require("mini.comment").setup()

		-- Example: move (drag & drop) any selection in all directions
		require("mini.move").setup()

		-- Example: surround (add/remove/replace surrounding brackets, quotes, etc.)
		require("mini.surround").setup()

		-- Example: a set of extra operators (like trimming whitespace, duplicating lines, etc.)
		require("mini.operators").setup()

		-- Example: icons (an alternative to nvim-web-devicons)
		require("mini.icons").setup()

		-- Example: basic Neovim presets (smart indent, common keybindings, etc.)
		require("mini.basics").setup()

		-- Example: improved navigation with [ ] (for quickfix, diffs, diagnostics, etc.)
		require("mini.bracketed").setup()

		-- Example: show hints for next possible keypresses (like which-key)
		require("mini.clue").setup()

		-- Example: tools for working with diffs (e.g., applying hunks)
		require("mini.diff").setup()

		-- Example: automatically highlight the word under the cursor
		require("mini.cursorword").setup()
	end,
}
