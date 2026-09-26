-- =========================================================================
-- THEME AND VISUAL CONFIGURATION
-- =========================================================================

local theme_chooser = {
	row_text = { hex = "#FF6699", alpha = 1 },
	row_subtext = { hex = "#FFCC33", alpha = 1 },
}

-- =========================================================================
-- SYSTEM LOGIC
-- =========================================================================

require("hs.ipc")

local workspaceChooser = nil

local function getWorkspacesFromConfig()
	local aerospaceConfigPath = os.getenv("HOME") .. "/setup-config/dotfiles_macos/aerospace/.aerospace.toml"
	local file = io.open(aerospaceConfigPath, "r")

	local choices = {}

	if not file then
		print("Could not open aerospace config file.")
		return choices
	end

	local content = file:read("*all")
	file:close()

	local workspacesStr = string.match(content, "persistent%-workspaces%s*=%s*%[(.-)%]")

	if workspacesStr then
		local id_counter = 1
		for workspaceName in string.gmatch(workspacesStr, '"([^"]+)"') do
			-- Apply hs.styledtext to support custom colors within the chooser list
			local styledText = hs.styledtext.new(workspaceName, {
				color = theme_chooser.row_text,
				font = { size = 18 },
			})
			local styledSubText = hs.styledtext.new("Workspace " .. tostring(id_counter), {
				color = theme_chooser.row_subtext,
				font = { size = 12 },
			})

			table.insert(choices, {
				text = styledText,
				subText = styledSubText,
				id = tostring(id_counter),
				rawText = workspaceName, -- Storing raw string for safe command execution
			})
			id_counter = id_counter + 1
		end
	end

	return choices
end

function selectWorkspace()
	if workspaceChooser then
		workspaceChooser:delete()
	end

	workspaceChooser = hs.chooser.new(function(choice)
		if not choice then
			return
		end

		local homeDir = os.getenv("HOME")
		local scriptPath = homeDir .. "/setup-config/dotfiles_macos/aerospace/scripts/change-aerospace-workspace.sh"

		-- Utilizing choice.rawText to pass plain strings to the bash task
		local task = hs.task.new("/bin/bash", nil, { scriptPath, choice.id, choice.rawText })
		task:start()
	end)

	local dynamicChoices = getWorkspacesFromConfig()
	workspaceChooser:choices(dynamicChoices)

	-- Valid API UI settings for hs.chooser
	workspaceChooser:bgDark(true)
	workspaceChooser:width(20)

	workspaceChooser:show()
end
