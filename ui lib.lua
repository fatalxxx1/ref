local UILib = {}

local TweenService = game:GetService("TweenService")

function UILib:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomUILib_" .. title
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 350, 0, 400)
    main.Position = UDim2.new(0.5, -175, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BorderSizePixel = 0
    main.Parent = screenGui

    -- Draggable
    local dragging, dragInput, dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Title
    local titleBar = Instance.new("TextLabel")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.Text = title
    titleBar.Font = Enum.Font.SourceSansBold
    titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.TextSize = 22
    titleBar.Parent = main

    -- Scrolling container
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, -40)
    scroll.Position = UDim2.new(0, 0, 0, 40)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 4
    scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    scroll.BorderSizePixel = 0
    scroll.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    UILib.Container = scroll
    UILib.Layout = layout
    return UILib
end

function UILib:AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 20
    btn.Parent = self.Container

    btn.MouseButton1Click:Connect(callback)

    self:UpdateCanvas()
end

function UILib:AddToggle(text, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text .. " [" .. (default and "ON" or "OFF") .. "]"
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 20
    btn.Parent = self.Container

    local state = default

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)

    self:UpdateCanvas()
end

function UILib:UpdateCanvas()
    task.wait()
    self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 10)
end

return UILib
