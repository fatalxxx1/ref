local VapeLite = loadstring(game:HttpGet("YOUR_SCRIPT_URL"))()
local Window = VapeLite:CreateWindow("MY HACKS")

local Aim = Window:CreateTab("Aim Assist")
local Visuals = Window:CreateTab("Visuals")
local Misc = Window:CreateTab("Misc")

-- Aim Assist tab
local aimToggle = Aim:CreateToggle("Aim Assist", false, function(state)
    if state then
        -- Enable aim assist
        _G.AimAssistEnabled = true
        coroutine.wrap(function()
            while _G.AimAssistEnabled and wait() do
                -- Aim assist logic
            end
        end)()
    else
        _G.AimAssistEnabled = false
    end
end)

local fovSlider = Aim:CreateSlider("FOV", 1, 360, 90, "°", function(value)
    _G.AimFOV = value
end)

-- Visuals tab
local espToggle = Visuals:CreateToggle("ESP", false, function(state)
    _G.ESPEnabled = state
    if state then
        CreateESP()
    else
        RemoveESP()
    end
end)

local espColor = Visuals:CreateDropdown("ESP Color", {"Red", "Blue", "Green", "Yellow"}, "Blue", function(color)
    _G.ESPColor = color
    UpdateESPColor()
end)

-- Misc tab
Misc:CreateLabel("Player Modifications")
local speedSlider = Misc:CreateSlider("Speed", 16, 100, 16, " studs/s", function(value)
    if Player.Character then
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = value
        end
    end
end)

local jumpSlider = Misc:CreateSlider("Jump Power", 50, 200, 50, " power", function(value)
    if Player.Character then
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = value
        end
    end
end)

Misc:CreateButton("Reset Character", function()
    Player.Character:BreakJoints()
end)

Misc:CreateButton("Copy Discord", function()
    setclipboard("https://discord.gg/myserver")
    print("Discord link copied!")
end)
