local UILib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VapeUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
ScreenGui.Parent = game:GetService("CoreGui")

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

function UILib:CreateWindow(title)
	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 0, 0, 0)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Main.BorderSizePixel = 0
	Main.BackgroundTransparency = 1
	Main.Visible = true
	Main.Parent = ScreenGui

	makeDraggable(Main)

	-- Animate open
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 500, 0, 300),
		Position = UDim2.new(0.5, -250, 0.5, -150),
		BackgroundTransparency = 0
	}):Play()

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, 0, 0, 30)
	Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextTransparency = 1
	Title.Text = title or "Vape UI"
	Title.Font = Enum.Font.Gotham
	Title.TextSize = 16
	Title.Parent = Main
	TweenService:Create(Title, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

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

		local tabFrame = Instance.new("ScrollingFrame")
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.Visible = false
		tabFrame.BorderSizePixel = 0
		tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabFrame.ScrollBarThickness = 4
		tabFrame.Parent = ContentHolder

		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 5)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = tabFrame

		button.MouseButton1Click:Connect(function()
			for _, v in pairs(ContentHolder:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			tabFrame.Visible = true
		end)

		local elements = {}

		function elements:AddToggle(text, default, callback)
			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(1, -10, 0, 30)
			toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			toggle.Text = "[OFF] " .. text
			toggle.Font = Enum.Font.Gotham
			toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
			toggle.TextSize = 14
			toggle.Parent = tabFrame

			tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)

			local state = default or false
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.Text = (state and "[ON] " or "[OFF] ") .. text
				if callback then callback(state) end
			end)
		end

		return elements
	end

	return tabs
end

return UILib
