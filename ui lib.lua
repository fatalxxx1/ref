-- UILib (with createTab and createButton)
local UILib = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Function to create the main frame for the UI
local function createVapeFrame(gui, name, position)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 250, 0, 300)
    frame.Position = position or UDim2.new(0, 100, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Name = name

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(60, 60, 60)
    stroke.Thickness = 1.5

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18

    return frame
end

-- Function to create a dynamic button with a callback
function UILib:createButton(parent, buttonName, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = buttonName
    btn.Name = buttonName
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        callback() -- Call the function passed as a callback when the button is clicked
    end)

    return btn
end

-- Function to create a tab inside the main UI
function UILib:createTab(parent, tabName, buttonData)
    -- Create a new Frame for the tab
    local tabFrame = Instance.new("Frame", parent)
    tabFrame.Size = UDim2.new(1, 0, 1, -40)
    tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabFrame.BorderSizePixel = 0
    tabFrame.Position = UDim2.new(0, 0, 0, 40)
    tabFrame.Visible = false -- Initially, hide the tab

    -- Add title for the tab
    local tabTitle = Instance.new("TextLabel", tabFrame)
    tabTitle.Size = UDim2.new(1, 0, 0, 30)
    tabTitle.BackgroundTransparency = 1
    tabTitle.Text = tabName
    tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabTitle.Font = Enum.Font.GothamBold
    tabTitle.TextSize = 18

    -- Create a ScrollingFrame inside the tab for buttons
    local scroll = Instance.new("ScrollingFrame", tabFrame)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 4
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local padding = Instance.new("UIPadding", scroll)
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)

    -- Create buttons inside the tab
    for _, button in ipairs(buttonData) do
        UILib:createButton(scroll, button.name, button.callback)
    end

    return tabFrame
end

-- Function to create the main UI
function UILib:CreateUI()
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "VapeUI"
    gui.ResetOnSpawn = false

    local mainFrame = createVapeFrame(gui, "Vape V4 UI", UDim2.new(0, 100, 0, 100))

    -- Tab Buttons
    local tabButtonsFrame = Instance.new("Frame", mainFrame)
    tabButtonsFrame.Size = UDim2.new(1, 0, 0, 30)
    tabButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
    tabButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

    local blatantButton = UILib:createButton(tabButtonsFrame, "Blatant", function()
        print("Blatant tab selected!")
        -- Show Blatant tab
        if blatantTabFrame.Visible then
            blatantTabFrame.Visible = false
        else
            blatantTabFrame.Visible = true
            speedTabFrame.Visible = false -- Hide other tabs when this one is selected
        end
    end)

    local speedButton = UILib:createButton(tabButtonsFrame, "Speed", function()
        print("Speed tab selected!")
        -- Show Speed tab
        if speedTabFrame.Visible then
            speedTabFrame.Visible = false
        else
            speedTabFrame.Visible = true
            blatantTabFrame.Visible = false -- Hide other tabs when this one is selected
        end
    end)

    -- Create the Blatant tab with buttons
    local blatantTabFrame = UILib:createTab(mainFrame, "Blatant", {
        {name = "Fly", callback = function() print("Fly button pressed!") end},
        {name = "Speed", callback = function() print("Speed button pressed!") end},
        {name = "Teleport", callback = function() print("Teleport button pressed!") end}
    })

    -- Create the Speed tab with buttons
    local speedTabFrame = UILib:createTab(mainFrame, "Speed", {
        {name = "Boost", callback = function() print("Boost button pressed!") end},
        {name = "Slow", callback = function() print("Slow button pressed!") end}
    })

    -- Return the main frame
    return mainFrame
end

return UILib
