-- VapeUI Lib (V4 Style UI)
local VapeUI = {}
VapeUI.__index = VapeUI

local function CreateInstance(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		inst[k] = v
	end
	return inst
end

function VapeUI:CreateTopbar(options)
	local topbar = {}

	local screenGui = CreateInstance("ScreenGui", {
		Name = "VapeUILib",
		Parent = game.CoreGui,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	})

	local main = CreateInstance("Frame", {
		Name = options.Name or "Topbar",
		Parent = screenGui,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		Position = UDim2.new(0.3, 0, 0.2, 0),
		Size = UDim2.new(0, 400, 0, 300),
		Draggable = true,
		Active = true
	})

	CreateInstance("UICorner", {Parent = main})

	local topFrame = CreateInstance("Frame", {
		Parent = main,
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		Size = UDim2.new(1, 0, 0, 10)
	})

	CreateInstance("TextLabel", {
		Parent = topFrame,
		Text = options.Name or "Tab",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.Gotham,
		TextSize = 14,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0)
	})

	local contentFrame = CreateInstance("Frame", {
		Parent = main,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 35),
		Size = UDim2.new(1, 0, 1, -35)
	})

	CreateInstance("UIListLayout", {
		Parent = contentFrame,
		Padding = UDim.new(0, 6)
	})

	-- Add Toggle
	function topbar:AddToggle(data)
		local button = CreateInstance("TextButton", {
			Parent = contentFrame,
			Text = data.Name .. " [OFF]",
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Font = Enum.Font.Gotham,
			TextSize = 12,
			Size = UDim2.new(1, -20, 0, 30)
		})

		local toggled = false
		button.MouseButton1Click:Connect(function()
			toggled = not toggled
			button.Text = data.Name .. (toggled and " [ON]" or " [OFF]")
			if data.Callback then data.Callback(toggled) end
		end)
	end

	-- Add Slider
	function topbar:AddSlider(data)
		local val = data.Default or data.Min or 0
		local button = CreateInstance("TextButton", {
			Parent = contentFrame,
			Text = data.Name .. ": " .. val,
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Font = Enum.Font.Gotham,
			TextSize = 12,
			Size = UDim2.new(1, -20, 0, 30)
		})

		button.MouseButton1Click:Connect(function()
			val = val + 1
			if val > data.Max then val = data.Min end
			button.Text = data.Name .. ": " .. val
			if data.Callback then data.Callback(val) end
		end)
	end

	-- ✅ Add Button
	function topbar:AddButton(data)
		local button = CreateInstance("TextButton", {
			Parent = contentFrame,
			Text = data.Name or "Button",
			BackgroundColor3 = Color3.fromRGB(70, 70, 70),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Font = Enum.Font.Gotham,
			TextSize = 12,
			Size = UDim2.new(1, -20, 0, 30)
		})

		button.MouseButton1Click:Connect(function()
			if data.Callback then data.Callback() end
		end)
	end

	return topbar
end

return setmetatable({}, VapeUI)
