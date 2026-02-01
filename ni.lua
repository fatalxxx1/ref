-- Vape Lite Inspired UI Library
-- Pure Local Script

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VapeLiteUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main Variables
local UILib = {}
local CurrentTab = nil
local Settings = {
    Theme = {
        Primary = Color3.fromRGB(45, 45, 45),
        Secondary = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(0, 170, 255),
        Text = Color3.fromRGB(240, 240, 240),
        TextSecondary = Color3.fromRGB(180, 180, 180)
    },
    Keybind = Enum.KeyCode.RightShift
}

-- Utility Functions
local function Create(class, props)
    local obj = Instance.new(class)
    for prop, val in pairs(props) do
        if prop == "Parent" then
            obj.Parent = val
        else
            obj[prop] = val
        end
    end
    return obj
end

local function Tween(obj, props, duration, style)
    local tweenInfo = TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad)
    local tween = game:GetService("TweenService"):Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- Main Container
local MainFrame = Create("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    BackgroundColor3 = Settings.Theme.Primary,
    Position = UDim2.new(0.5, -200, 0.5, -150),
    Size = UDim2.new(0, 400, 0, 300),
    Active = true,
    Draggable = true,
    ClipsDescendants = true
})

-- Top Bar
local TopBar = Create("Frame", {
    Name = "TopBar",
    Parent = MainFrame,
    BackgroundColor3 = Settings.Theme.Secondary,
    Size = UDim2.new(1, 0, 0, 30),
    BorderSizePixel = 0
})

local TitleLabel = Create("TextLabel", {
    Name = "Title",
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 0),
    Size = UDim2.new(0, 100, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "VAPE LITE",
    TextColor3 = Settings.Theme.Accent,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

local CloseButton = Create("TextButton", {
    Name = "CloseButton",
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -30, 0, 0),
    Size = UDim2.new(0, 30, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "×",
    TextColor3 = Settings.Theme.Text,
    TextSize = 20
})

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Tabs Container
local TabsContainer = Create("Frame", {
    Name = "TabsContainer",
    Parent = MainFrame,
    BackgroundColor3 = Settings.Theme.Secondary,
    Position = UDim2.new(0, 0, 0, 30),
    Size = UDim2.new(0, 100, 1, -30),
    BorderSizePixel = 0
})

-- Content Container
local ContentContainer = Create("Frame", {
    Name = "ContentContainer",
    Parent = MainFrame,
    BackgroundColor3 = Settings.Theme.Primary,
    Position = UDim2.new(0, 100, 0, 30),
    Size = UDim2.new(1, -100, 1, -30),
    BorderSizePixel = 0,
    ClipsDescendants = true
})

-- UI Library Functions
function UILib:Tab(name, icon)
    local TabButton = Create("TextButton", {
        Name = name .. "Tab",
        Parent = TabsContainer,
        BackgroundColor3 = Settings.Theme.Secondary,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, (#TabsContainer:GetChildren() - 1) * 40),
        Font = Enum.Font.Gotham,
        Text = "  " .. name,
        TextColor3 = Settings.Theme.TextSecondary,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local TabContent = Create("Frame", {
        Name = name .. "Content",
        Parent = ContentContainer,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Visible = false
    })
    
    local ScrollingFrame = Create("ScrollingFrame", {
        Name = "Scroller",
        Parent = TabContent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Settings.Theme.Accent
    })
    
    local UIListLayout = Create("UIListLayout", {
        Parent = ScrollingFrame,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Button.BackgroundColor3 = Settings.Theme.Secondary
            CurrentTab.Button.TextColor3 = Settings.Theme.TextSecondary
            CurrentTab.Content.Visible = false
        end
        
        Tween(TabButton, {
            BackgroundColor3 = Settings.Theme.Accent,
            TextColor3 = Settings.Theme.Text
        }, 0.2)
        
        TabContent.Visible = true
        CurrentTab = {
            Button = TabButton,
            Content = TabContent
        }
    end)
    
    local TabFunctions = {}
    
    function TabFunctions:Toggle(name, default, callback)
        local ToggleFrame = Create("Frame", {
            Name = name .. "Toggle",
            Parent = ScrollingFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -20, 0, 30),
            LayoutOrder = #ScrollingFrame:GetChildren(),
            BackgroundColor3 = Settings.Theme.Secondary
        })
        
        local ToggleLabel = Create("TextLabel", {
            Name = "Label",
            Parent = ToggleFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 0),
            Size = UDim2.new(0.7, -10, 1, 0),
            Font = Enum.Font.Gotham,
            Text = name,
            TextColor3 = Settings.Theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        local ToggleButton = Create("Frame", {
            Name = "ToggleButton",
            Parent = ToggleFrame,
            BackgroundColor3 = Settings.Theme.Secondary,
            BorderColor3 = Settings.Theme.Accent,
            BorderSizePixel = 1,
            Position = UDim2.new(1, -40, 0.5, -10),
            Size = UDim2.new(0, 30, 0, 20)
        })
        
        local ToggleCircle = Create("Frame", {
            Name = "ToggleCircle",
            Parent = ToggleButton,
            BackgroundColor3 = Settings.Theme.TextSecondary,
            Position = UDim2.new(0, 2, 0.5, -6),
            Size = UDim2.new(0, 12, 0, 12)
        })
        
        local state = default or false
        
        local function UpdateToggle()
            if state then
                Tween(ToggleCircle, {
                    Position = UDim2.new(1, -14, 0.5, -6),
                    BackgroundColor3 = Settings.Theme.Accent
                })
                Tween(ToggleButton, {
                    BackgroundColor3 = Settings.Theme.Accent
                })
            else
                Tween(ToggleCircle, {
                    Position = UDim2.new(0, 2, 0.5, -6),
                    BackgroundColor3 = Settings.Theme.TextSecondary
                })
                Tween(ToggleButton, {
                    BackgroundColor3 = Settings.Theme.Secondary
                })
            end
        end
        
        UpdateToggle()
        
        ToggleButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                state = not state
                UpdateToggle()
                if callback then
                    callback(state)
                end
            end
        end)
        
        local ToggleObject = {}
        
        function ToggleObject:Set(value)
            state = value
            UpdateToggle()
            if callback then
                callback(state)
            end
        end
        
        function ToggleObject:Get()
            return state
        end
        
        return ToggleObject
    end
    
    function TabFunctions:Slider(name, min, max, default, callback)
        local SliderFrame = Create("Frame", {
            Name = name .. "Slider",
            Parent = ScrollingFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -20, 0, 50),
            LayoutOrder = #ScrollingFrame:GetChildren()
        })
        
        local SliderLabel = Create("TextLabel", {
            Name = "Label",
            Parent = SliderFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 0),
            Size = UDim2.new(1, -20, 0, 20),
            Font = Enum.Font.Gotham,
            Text = name .. ": " .. tostring(default or min),
            TextColor3 = Settings.Theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        local SliderTrack = Create("Frame", {
            Name = "Track",
            Parent = SliderFrame,
            BackgroundColor3 = Settings.Theme.Secondary,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 30),
            Size = UDim2.new(1, -20, 0, 4)
        })
        
        local SliderFill = Create("Frame", {
            Name = "Fill",
            Parent = SliderTrack,
            BackgroundColor3 = Settings.Theme.Accent,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 1, 0)
        })
        
        local SliderButton = Create("TextButton", {
            Name = "Button",
            Parent = SliderTrack,
            BackgroundColor3 = Settings.Theme.Text,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 10, 0, 10),
            Position = UDim2.new(0, -5, 0.5, -5),
            Text = "",
            AutoButtonColor = false
        })
        
        local value = default or min
        
        local function UpdateSlider(val)
            value = math.clamp(val, min, max)
            local percent = (value - min) / (max - min)
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderButton.Position = UDim2.new(percent, -5, 0.5, -5)
            SliderLabel.Text = name .. ": " .. string.format("%.2f", value)
            
            if callback then
                callback(value)
            end
        end
        
        UpdateSlider(value)
        
        local dragging = false
        
        SliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        SliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local pos = Vector2.new(input.Position.X, input.Position.Y)
                local relative = SliderTrack.AbsolutePosition
                local percent = (pos.X - relative.X) / SliderTrack.AbsoluteSize.X
                UpdateSlider(min + (max - min) * percent)
            end
        end)
        
        Mouse.Move:Connect(function()
            if dragging then
                local pos = Vector2.new(Mouse.X, Mouse.Y)
                local relative = SliderTrack.AbsolutePosition
                local percent = (pos.X - relative.X) / SliderTrack.AbsoluteSize.X
                UpdateSlider(min + (max - min) * percent)
            end
        end)
        
        local SliderObject = {}
        
        function SliderObject:Set(val)
            UpdateSlider(val)
        end
        
        function SliderObject:Get()
            return value
        end
        
        return SliderObject
    end
    
    function TabFunctions:Button(name, callback)
        local ButtonFrame = Create("Frame", {
            Name = name .. "Button",
            Parent = ScrollingFrame,
            BackgroundColor3 = Settings.Theme.Secondary,
            Size = UDim2.new(1, -20, 0, 30),
            LayoutOrder = #ScrollingFrame:GetChildren()
        })
        
        local Button = Create("TextButton", {
            Name = "Button",
            Parent = ButtonFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.Gotham,
            Text = name,
            TextColor3 = Settings.Theme.Text,
            TextSize = 14
        })
        
        Button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
        
        Button.MouseEnter:Connect(function()
            Tween(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
        end)
        
        Button.MouseLeave:Connect(function()
            Tween(ButtonFrame, {BackgroundColor3 = Settings.Theme.Secondary})
        end)
        
        return ButtonFrame
    end
    
    function TabFunctions:Dropdown(name, options, default, callback)
        local DropdownFrame = Create("Frame", {
            Name = name .. "Dropdown",
            Parent = ScrollingFrame,
            BackgroundColor3 = Settings.Theme.Secondary,
            Size = UDim2.new(1, -20, 0, 30),
            LayoutOrder = #ScrollingFrame:GetChildren(),
            ClipsDescendants = true
        })
        
        local DropdownButton = Create("TextButton", {
            Name = "Button",
            Parent = DropdownFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Enum.Font.Gotham,
            Text = name .. ": " .. (default or options[1]),
            TextColor3 = Settings.Theme.Text,
            TextSize = 14
        })
        
        local DropdownList = Create("Frame", {
            Name = "List",
            Parent = DropdownFrame,
            BackgroundColor3 = Settings.Theme.Primary,
            Position = UDim2.new(0, 0, 0, 30),
            Size = UDim2.new(1, 0, 0, 0),
            Visible = false
        })
        
        local ListLayout = Create("UIListLayout", {
            Parent = DropdownList,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        local selected = default or options[1]
        local open = false
        
        local function UpdateDropdown()
            DropdownButton.Text = name .. ": " .. selected
            if callback then
                callback(selected)
            end
        end
        
        local function ToggleDropdown()
            open = not open
            if open then
                DropdownList.Visible = true
                Tween(DropdownList, {Size = UDim2.new(1, 0, 0, math.min(#options * 30, 150))})
                Tween(DropdownFrame, {Size = UDim2.new(1, -20, 0, 30 + math.min(#options * 30, 150))})
            else
                Tween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)})
                Tween(DropdownFrame, {Size = UDim2.new(1, -20, 0, 30)})
                wait(0.2)
                DropdownList.Visible = false
            end
        end
        
        DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
        
        for i, option in pairs(options) do
            local OptionButton = Create("TextButton", {
                Name = option,
                Parent = DropdownList,
                BackgroundColor3 = Settings.Theme.Secondary,
                Size = UDim2.new(1, 0, 0, 30),
                Font = Enum.Font.Gotham,
                Text = option,
                TextColor3 = Settings.Theme.TextSecondary,
                TextSize = 14,
                AutoButtonColor = false
            })
            
            OptionButton.MouseEnter:Connect(function()
                Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
                Tween(OptionButton, {TextColor3 = Settings.Theme.Text})
            end)
            
            OptionButton.MouseLeave:Connect(function()
                Tween(OptionButton, {BackgroundColor3 = Settings.Theme.Secondary})
                Tween(OptionButton, {TextColor3 = Settings.Theme.TextSecondary})
            end)
            
            OptionButton.MouseButton1Click:Connect(function()
                selected = option
                UpdateDropdown()
                ToggleDropdown()
            end)
        end
        
        UpdateDropdown()
        
        local DropdownObject = {}
        
        function DropdownObject:Set(val)
            if table.find(options, val) then
                selected = val
                UpdateDropdown()
            end
        end
        
        function DropdownObject:Get()
            return selected
        end
        
        function DropdownObject:Refresh(newOptions)
            for _, child in pairs(DropdownList:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            options = newOptions
            selected = newOptions[1]
            UpdateDropdown()
            
            for i, option in pairs(newOptions) do
                local OptionButton = Create("TextButton", {
                    Name = option,
                    Parent = DropdownList,
                    BackgroundColor3 = Settings.Theme.Secondary,
                    Size = UDim2.new(1, 0, 0, 30),
                    Font = Enum.Font.Gotham,
                    Text = option,
                    TextColor3 = Settings.Theme.TextSecondary,
                    TextSize = 14,
                    AutoButtonColor = false
                })
                
                OptionButton.MouseButton1Click:Connect(function()
                    selected = option
                    UpdateDropdown()
                    ToggleDropdown()
                end)
            end
        end
        
        return DropdownObject
    end
    
    function TabFunctions:Label(text)
        local LabelFrame = Create("Frame", {
            Name = "LabelFrame",
            Parent = ScrollingFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -20, 0, 20),
            LayoutOrder = #ScrollingFrame:GetChildren()
        })
        
        Create("TextLabel", {
            Name = "Label",
            Parent = LabelFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.Gotham,
            Text = text,
            TextColor3 = Settings.Theme.TextSecondary,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        return LabelFrame
    end
    
    -- Auto-select first tab
    if #TabsContainer:GetChildren() == 1 then
        TabButton.BackgroundColor3 = Settings.Theme.Accent
        TabButton.TextColor3 = Settings.Theme.Text
        TabContent.Visible = true
        CurrentTab = {
            Button = TabButton,
            Content = TabContent
        }
    end
    
    return TabFunctions
end

-- Toggle UI with keybind
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Settings.Keybind then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Example usage (you can remove this part)
--[[
local Home = UILib:Tab("Home")
local Combat = UILib:Tab("Combat")
local Visual = UILib:Tab("Visual")
local Utility = UILib:Tab("Utility")

Home:Label("Welcome to Vape Lite")
Home:Toggle("Auto Sprint", false, function(state) print("Auto Sprint:", state) end)
Home:Slider("Speed", 1, 100, 16, function(value) print("Speed:", value) end)
Home:Button("Teleport to Spawn", function() print("Teleporting...") end)
Home:Dropdown("Theme", {"Dark", "Light", "Blue"}, "Dark", function(selected) print("Theme:", selected) end)

Combat:Toggle("Kill Aura", false, function(state) print("Kill Aura:", state) end)
Combat:Toggle("Reach", false, function(state) print("Reach:", state) end)
Combat:Slider("Reach Distance", 3, 6, 3.2, function(value) print("Reach:", value) end)

Visual:Toggle("ESP", true, function(state) print("ESP:", state) end)
Visual:Toggle("Tracers", false, function(state) print("Tracers:", state) end)
Visual:Toggle("Chams", false, function(state) print("Chams:", state) end)

Utility:Toggle("Auto Clicker", false, function(state) print("Auto Clicker:", state) end)
Utility:Toggle("Blink", false, function(state) print("Blink:", state) end)
Utility:Toggle("Throw Pot", false, function(state) print("Throw Pot:", state) end)
]]

return UILib
