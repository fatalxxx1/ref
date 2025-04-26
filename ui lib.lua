-- BreezeUI Library
local BreezeUI = {}
BreezeUI.__index = BreezeUI

local function CreateInstance(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        inst[k] = v
    end
    return inst
end

function BreezeUI:CreateTopbar(options)
    local topbar = {}

    local screenGui = CreateInstance("ScreenGui", {
        Name = "BreezeUILib",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local main = CreateInstance("Frame", {
        Name = options.Name or "Topbar",
        Parent = screenGui,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Position = UDim2.new(0.3, 0, 0.2, 0),
        Size = UDim2.new(0, 400, 0, 250),
        Draggable = true,
        Active = true
    })
    CreateInstance("UICorner", { Parent = main, CornerRadius = UDim.new(0, 20) })

    local topFrame = CreateInstance("Frame", {
        Parent = main,
        BackgroundColor3 = Color3.fromRGB(17, 17, 17),
        Size = UDim2.new(1, 0, 0, 20)
    })
    CreateInstance("UICorner", { Parent = topFrame, CornerRadius = UDim.new(0, 20) })

    CreateInstance("TextLabel", {
        Parent = topFrame,
        Text = options.Name or "Tab",
        TextColor3 = Color3.fromRGB(245, 245, 245),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    })

    local contentFrame = CreateInstance("Frame", {
        Parent = main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(1, 0, 1, -25)
    })
    CreateInstance("UIListLayout", {
        Parent = contentFrame,
        Padding = UDim.new(0, 6)
    })

    function topbar:AddToggle(data)
        local button = CreateInstance("TextButton", {
            Parent = contentFrame,
            Text = data.Name .. " [OFF]",
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            TextColor3 = Color3.fromRGB(245, 245, 245),
            Font = Enum.Font.Gotham,
            TextSize = 12,
            Size = UDim2.new(1, -20, 0, 30)
        })
        CreateInstance("UICorner", { Parent = button, CornerRadius = UDim.new(0, 20) })

        local toggled = false
        button.MouseButton1Click:Connect(function()
            toggled = not toggled
            button.Text = data.Name .. (toggled and " [ON]" or " [OFF]")
            if data.Callback then data.Callback(toggled) end
        end)
    end

    function topbar:AddSlider(data)
        local val = data.Default or data.Min or 0
        local button = CreateInstance("TextButton", {
            Parent = contentFrame,
            Text = data.Name .. ": " .. val,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            TextColor3 = Color3.fromRGB(245, 245, 245),
            Font = Enum.Font.Gotham,
            TextSize = 12,
            Size = UDim2.new(1, -20, 0, 30)
        })
        CreateInstance("UICorner", { Parent = button, CornerRadius = UDim.new(0, 20) })

        button.MouseButton1Click:Connect(function()
            val = val + 1
            if val > data.Max then val = data.Min end
            button.Text = data.Name .. ": " .. val
            if data.Callback then data.Callback(val) end
        end)
    end

    function topbar:AddButton(data)
        local button = CreateInstance("TextButton", {
            Parent = contentFrame,
            Text = data.Name or "Button",
            BackgroundColor3 = Color3.fromRGB(70, 70, 70),
            TextColor3 = Color3.fromRGB(245, 245, 245),
            Font = Enum.Font.Gotham,
            TextSize = 12,
            Size = UDim2.new(1, -20, 0, 30)
        })
        CreateInstance("UICorner", { Parent = button, CornerRadius = UDim.new(0, 20) })

        button.MouseButton1Click:Connect(function()
            if data.Callback then data.Callback() end
        end)
    end

    function BreezeUI:SetWatermark(options)
        local screenGui = Instance.new("ScreenGui", game.CoreGui)
        screenGui.Name = "BreezeWatermark"
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local label = Instance.new("TextLabel", screenGui)
        label.BackgroundTransparency = 0.3
        label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        label.TextColor3 = Color3.fromRGB(245, 245, 245)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Size = UDim2.new(0, 200, 0, 25)
        label.Position = UDim2.new(0
::contentReference[oaicite:11]{index=11}
 
