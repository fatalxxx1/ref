-- VAPE LITE UI LIBRARY - EXACT REPLICATION
-- Pure Local Script

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Create ScreenGui
local VapeGUI = Instance.new("ScreenGui")
VapeGUI.Name = "VapeLiteUI"
VapeGUI.Parent = Player:WaitForChild("PlayerGui")
VapeGUI.ResetOnSpawn = false
VapeGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Container with exact Vape styling
local MainFrame = Instance.new("Frame")
MainFrame.Name = "VapeMain"
MainFrame.Parent = VapeGUI
MainFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.ClipsDescendants = true

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)

-- Vape Logo/Title
local VapeTitle = Instance.new("TextLabel")
VapeTitle.Name = "Title"
VapeTitle.Parent = TopBar
VapeTitle.BackgroundTransparency = 1
VapeTitle.Position = UDim2.new(0, 10, 0, 0)
VapeTitle.Size = UDim2.new(0, 100, 1, 0)
VapeTitle.Font = Enum.Font.GothamSemibold
VapeTitle.Text = "VAPE"
VapeTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
VapeTitle.TextSize = 14
VapeTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Version
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Name = "Version"
VersionLabel.Parent = TopBar
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(0, 120, 0, 0)
VersionLabel.Size = UDim2.new(0, 50, 1, 0)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "Lite"
VersionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
VersionLabel.TextSize = 12
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Close/Minimize Buttons
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -60, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "-"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.TextSize = 16

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "×"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 16

-- Tab Buttons Container (Left Sidebar)
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.Size = UDim2.new(0, 80, 1, -30)

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 80, 0, 30)
ContentFrame.Size = UDim2.new(1, -80, 1, -30)

-- Scrolling Container for Modules
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Name = "ModuleContainer"
ScrollContainer.Parent = ContentFrame
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.Size = UDim2.new(1, 0, 1, 0)
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.ScrollBarThickness = 3
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
ScrollContainer.ScrollBarImageTransparency = 0.5

local ModuleLayout = Instance.new("UIListLayout")
ModuleLayout.Parent = ScrollContainer
ModuleLayout.SortOrder = Enum.SortOrder.LayoutOrder
ModuleLayout.Padding = UDim.new(0, 5)

-- Make frame draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- UI Toggle with F8 key
UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.F8 then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Close/Minimize functionality
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    VapeGUI:Destroy()
end)

-- Module system
local Modules = {}
local CurrentTab = nil
local Settings = {}

-- Color scheme matching Vape Lite
local Colors = {
    Background = Color3.fromRGB(26, 26, 26),
    Sidebar = Color3.fromRGB(22, 22, 22),
    TopBar = Color3.fromRGB(20, 20, 20),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(240, 240, 240),
    TextSecondary = Color3.fromRGB(170, 170, 170),
    ElementBG = Color3.fromRGB(35, 35, 35),
    ToggleOff = Color3.fromRGB(60, 60, 60),
    ToggleOn = Color3.fromRGB(0, 170, 255)
}

-- Create module function
local function CreateModule(name, icon)
    local ModuleButton = Instance.new("TextButton")
    ModuleButton.Name = name .. "Tab"
    ModuleButton.Parent = TabContainer
    ModuleButton.BackgroundColor3 = Colors.Sidebar
    ModuleButton.BorderSizePixel = 0
    ModuleButton.Size = UDim2.new(1, 0, 0, 40)
    ModuleButton.Position = UDim2.new(0, 0, 0, (#TabContainer:GetChildren() - 1) * 40)
    ModuleButton.Font = Enum.Font.Gotham
    ModuleButton.Text = name
    ModuleButton.TextColor3 = Colors.TextSecondary
    ModuleButton.TextSize = 12
    ModuleButton.AutoButtonColor = false
    
    -- Underline indicator
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Parent = ModuleButton
    Indicator.BackgroundColor3 = Colors.Accent
    Indicator.BorderSizePixel = 0
    Indicator.Size = UDim2.new(0, 3, 0.6, 0)
    Indicator.Position = UDim2.new(0, 0, 0.2, 0)
    Indicator.Visible = false
    
    local ModuleContent = Instance.new("Frame")
    ModuleContent.Name = name .. "Content"
    ModuleContent.Parent = ContentFrame
    ModuleContent.BackgroundTransparency = 1
    ModuleContent.Size = UDim2.new(1, 0, 1, 0)
    ModuleContent.Visible = false
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Parent = ModuleContent
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = Colors.Accent
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ScrollFrame
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)
    
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    ModuleButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Button.TextColor3 = Colors.TextSecondary
            CurrentTab.Indicator.Visible = false
            CurrentTab.Content.Visible = false
        end
        
        ModuleButton.TextColor3 = Colors.Text
        Indicator.Visible = true
        ModuleContent.Visible = true
        CurrentTab = {
            Button = ModuleButton,
            Indicator = Indicator,
            Content = ModuleContent
        }
    end)
    
    -- Auto-select first module
    if #TabContainer:GetChildren() == 1 then
        ModuleButton.TextColor3 = Colors.Text
        Indicator.Visible = true
        ModuleContent.Visible = true
        CurrentTab = {
            Button = ModuleButton,
            Indicator = Indicator,
            Content = ModuleContent
        }
    end
    
    return ScrollFrame
end

-- Create toggle with Vape Lite exact styling
local function CreateToggle(name, default, callback, parent)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = name .. "Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Colors.ElementBG
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, -16, 0, 28)
    ToggleFrame.LayoutOrder = #parent:GetChildren()
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
    ToggleLabel.Size = UDim2.new(0.7, -12, 1, 0)
    ToggleLabel.Font = Enum.Font.GothamSemibold
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Colors.Text
    ToggleLabel.TextSize = 12
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Colors.ToggleOff
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -44, 0.5, -9)
    ToggleButton.Size = UDim2.new(0, 34, 0, 18)
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "ToggleCircle"
    ToggleCircle.Parent = ToggleButton
    ToggleCircle.BackgroundColor3 = Colors.Text
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Position = UDim2.new(0, 2, 0.5, -7)
    ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = ToggleCircle
    
    local state = default or false
    
    local function UpdateToggle()
        if state then
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ToggleOn}):Play()
            TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, -7)}):Play()
        else
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ToggleOff}):Play()
            TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -7)}):Play()
        end
        if callback then callback(state) end
    end
    
    UpdateToggle()
    
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            UpdateToggle()
        end
    end)
    
    local ToggleObject = {}
    ToggleObject.Value = state
    
    function ToggleObject:Set(value)
        state = value
        UpdateToggle()
    end
    
    function ToggleObject:Get()
        return state
    end
    
    function ToggleObject:Toggle()
        state = not state
        UpdateToggle()
    end
    
    return ToggleObject
end

-- Create slider with Vape styling
local function CreateSlider(name, min, max, default, suffix, callback, parent)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = name .. "Slider"
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Colors.ElementBG
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Size = UDim2.new(1, -16, 0, 60)
    SliderFrame.LayoutOrder = #parent:GetChildren()
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = SliderFrame
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.Parent = SliderFrame
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 12, 0, 8)
    SliderLabel.Size = UDim2.new(1, -24, 0, 16)
    SliderLabel.Font = Enum.Font.GothamSemibold
    SliderLabel.Text = name
    SliderLabel.TextColor3 = Colors.Text
    SliderLabel.TextSize = 12
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Name = "Value"
    ValueLabel.Parent = SliderFrame
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(1, -100, 0, 8)
    ValueLabel.Size = UDim2.new(0, 88, 0, 16)
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.Text = tostring(default) .. (suffix or "")
    ValueLabel.TextColor3 = Colors.TextSecondary
    ValueLabel.TextSize = 12
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "Track"
    SliderTrack.Parent = SliderFrame
    SliderTrack.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 12, 0, 32)
    SliderTrack.Size = UDim2.new(1, -24, 0, 4)
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderTrack
    SliderFill.BackgroundColor3 = Colors.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "Button"
    SliderButton.Parent = SliderTrack
    SliderButton.BackgroundColor3 = Colors.Text
    SliderButton.BorderSizePixel = 0
    SliderButton.Size = UDim2.new(0, 12, 0, 12)
    SliderButton.Position = UDim2.new(0.5, -6, 0.5, -6)
    SliderButton.Text = ""
    SliderButton.AutoButtonColor = false
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = SliderButton
    
    local value = default or min
    local dragging = false
    
    local function UpdateSlider(val)
        value = math.clamp(math.floor(val * 100) / 100, min, max)
        local percent = (value - min) / (max - min)
        
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderButton.Position = UDim2.new(percent, -6, 0.5, -6)
        ValueLabel.Text = tostring(value) .. (suffix or "")
        
        if callback then callback(value) end
    end
    
    UpdateSlider(value)
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local pos = Vector2.new(input.Position.X, input.Position.Y)
            local relative = SliderTrack.AbsolutePosition
            local percent = math.clamp((pos.X - relative.X) / SliderTrack.AbsoluteSize.X, 0, 1)
            UpdateSlider(min + (max - min) * percent)
        end
    end)
    
    Mouse.Move:Connect(function()
        if dragging then
            local pos = Vector2.new(Mouse.X, Mouse.Y)
            local relative = SliderTrack.AbsolutePosition
            local percent = math.clamp((pos.X - relative.X) / SliderTrack.AbsoluteSize.X, 0, 1)
            UpdateSlider(min + (max - min) * percent)
        end
    end)
    
    local SliderObject = {}
    SliderObject.Value = value
    
    function SliderObject:Set(val)
        UpdateSlider(val)
    end
    
    function SliderObject:Get()
        return value
    end
    
    return SliderObject
end

-- Create dropdown
local function CreateDropdown(name, options, default, callback, parent)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Parent = parent
    DropdownFrame.BackgroundColor3 = Colors.ElementBG
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Size = UDim2.new(1, -16, 0, 28)
    DropdownFrame.LayoutOrder = #parent:GetChildren()
    DropdownFrame.ClipsDescendants = true
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = DropdownFrame
    
    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Name = "Label"
    DropdownLabel.Parent = DropdownFrame
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Position = UDim2.new(0, 12, 0, 0)
    DropdownLabel.Size = UDim2.new(0.7, -12, 1, 0)
    DropdownLabel.Font = Enum.Font.GothamSemibold
    DropdownLabel.Text = name
    DropdownLabel.TextColor3 = Colors.Text
    DropdownLabel.TextSize = 12
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SelectedLabel = Instance.new("TextLabel")
    SelectedLabel.Name = "Selected"
    SelectedLabel.Parent = DropdownFrame
    SelectedLabel.BackgroundTransparency = 1
    SelectedLabel.Position = UDim2.new(0.7, 0, 0, 0)
    SelectedLabel.Size = UDim2.new(0.3, -30, 1, 0)
    SelectedLabel.Font = Enum.Font.Gotham
    SelectedLabel.Text = default or options[1]
    SelectedLabel.TextColor3 = Colors.TextSecondary
    SelectedLabel.TextSize = 12
    SelectedLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local Arrow = Instance.new("TextLabel")
    Arrow.Parent = DropdownFrame
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -20, 0, 0)
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Text = "▼"
    Arrow.TextColor3 = Colors.TextSecondary
    Arrow.TextSize = 12
    
    local DropdownList = Instance.new("Frame")
    DropdownList.Name = "List"
    DropdownList.Parent = DropdownFrame
    DropdownList.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    DropdownList.BorderSizePixel = 0
    DropdownList.Position = UDim2.new(0, 0, 1, 2)
    DropdownList.Size = UDim2.new(1, 0, 0, 0)
    DropdownList.Visible = false
    DropdownList.ZIndex = 2
    
    local ListCorner = Instance.new("UICorner")
    ListCorner.CornerRadius = UDim.new(0, 4)
    ListCorner.Parent = DropdownList
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = DropdownList
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local selected = default or options[1]
    local open = false
    
    local function UpdateDropdown()
        SelectedLabel.Text = selected
        if callback then callback(selected) end
    end
    
    local function ToggleDropdown()
        open = not open
        if open then
            DropdownList.Visible = true
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(1, 0, 0, math.min(#options * 28, 140))
            }):Play()
            TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {
                Size = UDim2.new(1, -16, 0, 30 + math.min(#options * 28, 140))
            }):Play()
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
        else
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -16, 0, 28)}):Play()
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            task.wait(0.2)
            DropdownList.Visible = false
        end
    end
    
    DropdownFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            ToggleDropdown()
        end
    end)
    
    for i, option in pairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Name = option
        OptionButton.Parent = DropdownList
        OptionButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        OptionButton.BorderSizePixel = 0
        OptionButton.Size = UDim2.new(1, 0, 0, 28)
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.Text = option
        OptionButton.TextColor3 = Colors.TextSecondary
        OptionButton.TextSize = 12
        OptionButton.AutoButtonColor = false
        
        OptionButton.MouseEnter:Connect(function()
            TweenService:Create(OptionButton, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                TextColor3 = Colors.Text
            }):Play()
        end)
        
        OptionButton.MouseLeave:Connect(function()
            TweenService:Create(OptionButton, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(32, 32, 32),
                TextColor3 = Colors.TextSecondary
            }):Play()
        end)
        
        OptionButton.MouseButton1Click:Connect(function()
            selected = option
            UpdateDropdown()
            ToggleDropdown()
        end)
    end
    
    UpdateDropdown()
    
    local DropdownObject = {}
    DropdownObject.Value = selected
    
    function DropdownObject:Set(val)
        if table.find(options, val) then
            selected = val
            UpdateDropdown()
        end
    end
    
    function DropdownObject:Get()
        return selected
    end
    
    return DropdownObject
end

-- Create button
local function CreateButton(name, callback, parent)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Name = name .. "Button"
    ButtonFrame.Parent = parent
    ButtonFrame.BackgroundColor3 = Colors.ElementBG
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Size = UDim2.new(1, -16, 0, 28)
    ButtonFrame.LayoutOrder = #parent:GetChildren()
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = ButtonFrame
    
    local Button = Instance.new("TextButton")
    Button.Name = "Button"
    Button.Parent = ButtonFrame
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = name
    Button.TextColor3 = Colors.Text
    Button.TextSize = 12
    
    Button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Colors.ElementBG
        }):Play()
    end)
    
    return Button
end

-- Create label
local function CreateLabel(text, parent)
    local LabelFrame = Instance.new("Frame")
    LabelFrame.Name = "LabelFrame"
    LabelFrame.Parent = parent
    LabelFrame.BackgroundTransparency = 1
    LabelFrame.Size = UDim2.new(1, -16, 0, 20)
    LabelFrame.LayoutOrder = #parent:GetChildren()
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Parent = LabelFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Colors.Accent
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    return Label
end

-- Main UI Library Object
local VapeLite = {}

function VapeLite:CreateWindow(name)
    VapeTitle.Text = name:upper()
    return VapeLite
end

function VapeLite:CreateTab(name, icon)
    local TabContent = CreateModule(name, icon)
    
    local TabFunctions = {}
    
    function TabFunctions:CreateToggle(name, default, callback)
        return CreateToggle(name, default, callback, TabContent)
    end
    
    function TabFunctions:CreateSlider(name, min, max, default, suffix, callback)
        return CreateSlider(name, min, max, default, suffix, callback, TabContent)
    end
    
    function TabFunctions:CreateDropdown(name, options, default, callback)
        return CreateDropdown(name, options, default, callback, TabContent)
    end
    
    function TabFunctions:CreateButton(name, callback)
        return CreateButton(name, callback, TabContent)
    end
    
    function TabFunctions:CreateLabel(text)
        return CreateLabel(text, TabContent)
    end
    
    return TabFunctions
end

-- Create example modules based on Vape Lite image
local Home = VapeLite:CreateTab("Home")
local Combat = VapeLite:CreateTab("Combat")
local Visual = VapeLite:CreateTab("Visual")
local Utility = VapeLite:CreateTab("Utility")

-- Home Tab (example content)
Home:CreateLabel("General Settings")
Home:CreateToggle("Fullbright", false, function(state)
    if state then
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = false
    else
        game.Lighting.Brightness = 1
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = true
    end
end)

Home:CreateToggle("Favorites", false, function(state)
    print("Favorites:", state)
end)

-- Combat Tab
Combat:CreateLabel("Combat Modules")
local KillAura = Combat:CreateToggle("Kill Aura", false, function(state)
    print("Kill Aura:", state)
end)

local ReachToggle = Combat:CreateToggle("Reach", false, function(state)
    print("Reach enabled:", state)
end)

local ReachSlider = Combat:CreateSlider("Reach", 3, 6, 3.2, " blocks", function(value)
    print("Reach distance:", value)
end)

-- Visual Tab
Visual:CreateLabel("Visual Modules")
Visual:CreateToggle("ESP", false, function(state)
    print("ESP:", state)
end)

Visual:CreateToggle("Tracers", false, function(state)
    print("Tracers:", state)
end)

Visual:CreateToggle("Chams", false, function(state)
    print("Chams:", state)
end)

Visual:CreateDropdown("Theme", {"Dark", "Light", "Blue", "Red"}, "Dark", function(selected)
    print("Theme selected:", selected)
end)

-- Utility Tab
Utility:CreateLabel("Utility Modules")
Utility:CreateToggle("Throw Pot", false, function(state)
    print("Throw Pot:", state)
end)

Utility:CreateToggle("Blink", false, function(state)
    print("Blink:", state)
end)

local VelocityToggle = Utility:CreateToggle("Velocity", false, function(state)
    print("Velocity:", state)
end)

Utility:CreateSlider("Velocity", 0, 100, 50, "%", function(value)
    print("Velocity amount:", value)
end)

Utility:CreateButton("Copy Discord", function()
    setclipboard("https://discord.gg/vape")
    print("Discord link copied!")
end)

Utility:CreateButton("Unload", function()
    VapeGUI:Destroy()
    print("Vape Lite unloaded")
end)

-- Initialize window
VapeLite:CreateWindow("VAPE")

return VapeLite
