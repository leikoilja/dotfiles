local M = {}

-- map(). It accepts four parameters namely:
-- mode (as in Vim modes like Normal/Insert mode)
-- lhs (the custom keybinds you need)
-- rhs (the commands or existing keybinds to customise)
-- opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
-- Source: https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.JBLRunCurrentTest()
    -- tests.test_api_v1.RejectionReasonTests.test_delete_another_user
    -- Extract test method name
    local method_line = vim.fn.search('def test_', 'bn')
    local method_name = vim.fn.getline(method_line):match("def%s+([%w_]+)")

    if method_name == "" then
        print("Unable to find & process any method for test")
        return
    end    

    -- Extract test class name
    local class_line = vim.fn.search('^class ', 'bn')
    local class_name = vim.fn.getline(class_line):match("class%s+([%w_]+)%s*%(")

    if class_name == "" then
        print("Unable to find & process any class for test")
        return
    end    
    
    -- Extracting file path as tests.test_api_v1
    local filename = vim.fn.expand('%:p')
    local pattern = "jbl_web/(.*)%.py"

    local filepath

    local success, error = pcall(function()
        local match = string.match(filename, pattern)
        filepath = string.gsub(match, "/", ".")
    end)

    if not success then
        print("Unable to process the file path " .. error)
        return
    end

    local j_test_path = filepath .. '.' .. class_name .. '.' .. method_name

    -- Note this command uses bash alias for 'jtest'
    local command = 'T ' .. 'jtest ' .. j_test_path

    print('Running test for ' .. j_test_path)

    -- Try to execute the command and catch any errors
    local success, error = pcall(vim.cmd, command)
    if not success then
        print('Failed to run test. Check current directory with :pwd. Error: '.. error)
    end
end

return M
