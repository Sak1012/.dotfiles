return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "RchrdAriza/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local time = os.date("%H:%M")
		local date = os.date("%a %d %b")
		local v = time .. "                                                 " .. date

		-- Set header
		dashboard.section.header.val = {
			"     z$$$$$. $$                                        ",
			"    $$$$$$$$$$$                                        ",
			"   $$$$$$**$$$$             eeeeer					    ",
			"  $$$$$%   '$$$             $$$$$$                     ",
			" 4$$$$P     *$$             *$$$$F                     ",
			" $$$$$      '$$    .ee.      ^$$$F            ..e.     ",
			" $$$$$           .$$$$$$b     $$$F 4$$$$$$   $$$$$$c   ",
			"4$$$$F          4$$$  $$$$    $$$F  *$$$$*  $$$P $$$L  ",
			"4$$$$F         .$$$F  ^$$$b   $$$F  J$$$   $$$$  ^$$$. ",
			"4$$$$F         d$$$    $$$$   $$$F J$$P   .$$$F   $$$$ ",
			"4$$$$F         $$$$    3$$$F  $$$FJ$$P    4$$$$   $$$$ ",
			"4$$$$F        4$$$$    4$$$$  $$$$$$$r    $$$$$$$$$$$$ ",
			"4$$$$$        4$$$$    4$$$$  $$$$$$$$    $$$$******** ",
			" $$$$$        4$$$$    4$$$F  $$$F4$$$b   *$$$r	    ",
			" 3$$$$F       d$$$$    $$$$$  $$$F *$$$F  4$$$L     .. ",
			"  $$$$$.     d$$$$$.   $$$$   $$$F  $$$$.  $$$$    z$P ",
			"   $$$$$e..d$$$^$$$b  4$$$$  J$$$L  ^$$$$  ^$$$b..d$$  ",
			"    *$$$$$$$$$  ^$$$be$$$^  $$$$$$$  3$$$$F ^$$$$$$$^ 	",
			"     ^*$$$$P$     *$$$$*    $$$$$$$   $$$$F  ^*$$$$    ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰮗   Find file", ":cd $HOME | Telescope find_files<CR>"),
			dashboard.button("e", "   File Explorer", ":cd $HOME | NvimTreeToggle <CR>"),
			dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("c", "   Configuration", ":e ~/.config/nvim/<CR>"),
			dashboard.button("R", "󱘞   Ripgrep", ":Telescope live_grep<CR>"),
			dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
		}

		function centerText(text, width)
			local totalPadding = width - #text
			local leftPadding = math.floor(totalPadding / 2)
			local rightPadding = totalPadding - leftPadding
			return string.rep(" ", leftPadding) .. text .. string.rep(" ", rightPadding)
		end

		dashboard.section.footer.val = {
			centerText("What Kind of Fuckery is This ?", 50),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
