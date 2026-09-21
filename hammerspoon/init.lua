-- =========================================================================
-- THEME AND VISUAL CONFIGURATION
-- =========================================================================

local color_border_blue = { hex = "#33CCFF", alpha = 1 }

local theme_popup = {
	background = { white = 1, alpha = 0.8 },
	border_color = color_border_blue,
	text_color = { hex = "#001F3F", alpha = 1 },
	text_size = 18,
	rounding = 8,
}

local theme_chooser = {
	row_text = { hex = "#FF6699", alpha = 1 },
	row_subtext = { hex = "#FFCC33", alpha = 1 },
}

-- =========================================================================
-- SYSTEM LOGIC
-- =========================================================================

require("hs.ipc")

local workspaceAlertCanvas = nil
local workspaceAlertTimer = nil
local workspaceChooser = nil

function showWorkspaceAlert(workspaceName)
	if workspaceAlertCanvas then
		workspaceAlertCanvas:delete()
	end
	if workspaceAlertTimer then
		workspaceAlertTimer:stop()
	end

	local screen = hs.screen.mainScreen()
	local frame = screen:frame()

	local width = 240
	local height = 50
	local padding = 20

	local x = frame.x + frame.w - width - padding
	local y = frame.y + frame.h - height - padding

	workspaceAlertCanvas = hs.canvas.new({ x = x, y = y, w = width, h = height })

	-- Background rectangle
	workspaceAlertCanvas:insertElement({
		type = "rectangle",
		action = "fill",
		fillColor = theme_popup.background,
		roundedRectRadii = { xRadius = theme_popup.rounding, yRadius = theme_popup.rounding },
	})

	-- Border rectangle
	workspaceAlertCanvas:insertElement({
		type = "rectangle",
		action = "stroke",
		strokeColor = theme_popup.border_color,
		strokeWidth = 2,
		roundedRectRadii = { xRadius = theme_popup.rounding, yRadius = theme_popup.rounding },
	})

	-- Text element
	workspaceAlertCanvas:insertElement({
		type = "text",
		text = workspaceName,
		textColor = theme_popup.text_color,
		textSize = theme_popup.text_size,
		textAlignment = "center",
		frame = { x = "0%", y = "20%", w = "100%", h = "100%" },
	})

	workspaceAlertCanvas:show()

	workspaceAlertTimer = hs.timer.doAfter(0.8, function()
		if workspaceAlertCanvas then
			workspaceAlertCanvas:delete()
			workspaceAlertCanvas = nil
		end
	end)
end

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
