require("full-border"):setup()
require("git"):setup()

-- ~/.config/yazi/init.lua
require("bookmarks"):setup({
	persist = "vim",
	desc_format = "full",
	file_pick_mode = "hover",
	custom_desc_input = false,
	notify = {
		enable = true,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})