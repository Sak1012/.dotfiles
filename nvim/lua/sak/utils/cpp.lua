local api = vim.api
local fn = vim.fn

-- Helper function to format the header for a new C++ file
local function create_cpp_header(filename)
	local date_time = os.date("%Y-%m-%d %H:%M:%S")
	local header = string.format(
		[[
/*
    File: %s
    Date and Time Created: %s
    Author: Srivatsav Auswin
*/
]],
		filename,
		date_time
	)
	return header
end

-- Helper function to run tmux commands
local function tmux(cmd)
	os.execute("tmux " .. cmd)
end

-- Command to create a new C++ file
api.nvim_create_user_command("C", function(opts)
	local filename = opts.args

	if filename == "" then
		print("Error: Please provide a filename.")
		return
	end

	local filepath = fn.getcwd() .. "/" .. filename
	local main_cpp_path = fn.getcwd() .. "/main.cpp"

	-- Check if the file already exists
	if fn.filereadable(filepath) == 1 then
		print("Error: File already exists.")
		return
	end

	-- Check if main.cpp exists
	if fn.filereadable(main_cpp_path) == 0 then
		print("Error: main.cpp not found in the current directory.")
		return
	end

	-- Read the content of main.cpp
	local main_cpp_content = ""
	local main_file = io.open(main_cpp_path, "r")
	if main_file then
		main_cpp_content = main_file:read("*a")
		main_file:close()
	end

	-- Create and write the header + main.cpp content to the new file
	local header = create_cpp_header(filename)
	local new_file = io.open(filepath, "w")
	if new_file then
		new_file:write(header .. "\n" .. main_cpp_content)
		new_file:close()
	end

	vim.cmd("edit " .. filename)
	print("Created file and copied content from main.cpp.")
end, { nargs = 1 })

-- Command to compile and execute C++ code with timeout
api.nvim_create_user_command("Com", function()
	local current_file = fn.expand("%:p")
	local output_file = fn.getcwd() .. "/op.txt"
	local timeout_seconds = 2

	-- Compile the C++ file with timeout
	local compile_cmd =
		string.format("timeout %d g++ -std=c++17 -o temp.out %s && ./temp.out", timeout_seconds, current_file)
	local compile_result = os.execute(compile_cmd)

	-- Check if compilation succeeded
	if compile_result ~= 0 or fn.filereadable("temp.out") == 0 then
		-- Write TLE to op.txt if compilation times out
		local file = io.open(output_file, "w")
		if file then
			file:write("TLE\n")
			file:close()
		end
		print("Compilation timed out or failed. Check op.txt for details.")
		return
	end

	-- Run the executable with a timeout
	local run_cmd = string.format("timeout 5 ./temp.out")
	local run_result = os.execute(run_cmd)

	if run_result ~= 0 then
		-- Handle timeout or runtime errors
		local file = io.open(output_file, "w")
		if file then
			file:write("TLE\n")
			file:close()
		end
	end

	-- Switch to the tmux pane with op.txt
	tmux("select-pane -t :.2") -- Adjust index to match the correct pane for op.txt

	print("Execution completed. Check op.txt for the output.")
end, {})
