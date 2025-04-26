-- UILib
local UILib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create base GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VapeUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game:GetService("CoreGui")

-- Helper function for dragging
local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
									   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Main window creation
function UILib:CreateWindow(title)
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Size = UDim2.new(0, 500, 0, 300)
	Main.Position = UDim2.new(0.5, -250, 0.5, -150)
	Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Main.BorderSizePixel = 0
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Parent = ScreenGui

	makeDraggable(Main)

	local Title = Instance.new("TextLabel")
	Title.Text = title or "Vape UI"
	Title.Size = UDim2.new(1, 0, 0, 30)
	Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.Gotham
	Title.TextSize = 16
	Title.Parent = Main

	local TabHolder = Instance.new("Frame")
	TabHolder.Size = UDim2.new(0, 100, 1, -30)
	TabHolder.Position = UDim2.new(0, 0, 0, 30)
	TabHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TabHolder.Parent = Main

	local ContentHolder = Instance.new("Frame")
	ContentHolder.Size = UDim2.new(1, -100, 1, -30)
	ContentHolder.Position = UDim2.new(0, 100, 0, 30)
	ContentHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	ContentHolder.ClipsDescendants = true
	ContentHolder.Parent = Main

	local tabs = {}

	function tabs:CreateTab(name)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 0, 30)
		button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		button.Text = name
		button.Font = Enum.Font.Gotham
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextSize = 14
		button.Parent = TabHolder

		local tabFrame = Instance.new("Frame")
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.Visible = false
		tabFrame.Parent = ContentHolder

		button.MouseButton1Click:Connect(function()
			for _, v in pairs(ContentHolder:GetChildren()) do
				v.Visible = false
			end
			tabFrame.Visible = true
		end)

		local function addToggle(text, default, callback)
			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(1, -10, 0, 30)
			toggle.Position = UDim2.new(0, 5, 0, #tabFrame:GetChildren() * 35)
			toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			toggle.Text = "[OFF] " .. text
			toggle.Font = Enum.Font.Gotham
			toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
			toggle.TextSize = 14
			toggle.Parent = tabFrame

			local state = default or false
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.Text = (state and "[ON] " or "[OFF] ") .. text
				if callback then
					callback(state)
				end
			end)
		end

		tabFrame.addToggle = addToggle

		return tabFrame
	end

	return tabs
end

return UILib
