-- NOTE: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require("nixCatsUtils").setup({
	non_nix_value = true,
})

-- NOTE: You might want to move the lazy-lock.json file
local function getlockfilepath()
	if require("nixCatsUtils").isNixCats and type(nixCats.settings.unwrappedCfgPath) == "string" then
		return nixCats.settings.unwrappedCfgPath .. "/lazy-lock.json"
	else
		return vim.fn.stdpath("config") .. "/lazy-lock.json"
	end
end
local lazyOptions = {
	lockfile = getlockfilepath(),
}

-- NOTE: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require("nixCatsUtils.lazyCat").setup(nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }), {
	{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
	-- disable mason.nvim while using nix
	-- precompiled binaries do not agree with nixos, and we can just make nix install this stuff for us.
	{ "williamboman/mason-lspconfig.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },

	{ import = "lazyvim.plugins.extras.lang.git" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.nix" },
	{ import = "lazyvim.plugins.extras.lang.markdown" },
	{ import = "lazyvim.plugins.extras.lang.elixir" },
	{ import = "lazyvim.plugins.extras.lang.tailwind" },
	{ import = "lazyvim.plugins.extras.coding.mini-surround" },

	{ "williamboman/mason.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
	{
		"nvim-treesitter/nvim-treesitter",
		build = require("nixCatsUtils").lazyAdd(":TSUpdate"),
		opts_extend = require("nixCatsUtils").lazyAdd(nil, false),
		opts = {
			-- nix already ensured they were installed, and we would need to change the parser_install_dir if we wanted to use it instead.
			-- so we just disable install and do it via nix.

			ensure_installed = require("nixCatsUtils").lazyAdd({
				"elixir",
				"eex",
				"heex",
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
			}, false),

			auto_install = require("nixCatsUtils").lazyAdd(true, false),

			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = false,
			},

			incremental_selection = { enable = true },

			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"folke/lazydev.nvim",
		opts = {
			library = {
				{ path = (nixCats.nixCatsPath or "") .. "/lua", words = { "nixCats" } },
			},
		},
	},

	-- import/override with your plugins
	{ import = "plugins" },
}, lazyOptions)

vim.lsp.config["elixirls"] = {
	cmd = { "elixir-ls" },
	root_markers = { "mix.exs", ".git" },
}
