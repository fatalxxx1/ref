local RS = game:GetService("RunService")
	local plr = game.Players.LocalPlayer
local TaskFlags = {}
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


function StartTask(name, func)
	if TaskFlags[name] then return end 
	TaskFlags[name] = true

	task.spawn(function()
		while TaskFlags[name] do
			func()
			task.wait()
					end
	end)
end


function StopTask(name)
	TaskFlags[name] = false
end

local Mutation = {
	Shiny = "Shiny"
}


local CD = 0.55
_G.to1 = false
_G.to2 = false
_G.Shovel = false
_G.Mut = false


local function EShovel()
	if _G.Shovel then
	StartTask("Equip",function()
		local char = plr.Character

		for _, a in pairs(plr.backpack:GetDescendants()) do
			if a:IsA("Tool") and string.match(a.Name," Shovel") then
				a.Parent = char
			end
		end
	end)
	
	else
		local backpack1 = plr.backpack
		for _, a in pairs(backpack1:GetDescendants()) do
			if a:IsA("Tool") and string.match(a.Name," Shovel") then
				a.Parent = backpack1
			end
		end
	StopTask()
	end
end

local function fastdig()
	local plr = game.Players.LocalPlayer
	local char = plr.character.HumanoidRootPart
	local args = {
	0,
	{
		{
			Orientation = vector.zero,
			Transparency = 1,
			Name = "PositionPart",
			Position = vector.create(0,0,0),
			Color = Color3.new(0,0,0),
			Material = Enum.Material.Plastic,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(0, 0,0),
			Transparency = 1,
			Name = "CenterCylinder",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.529411792755127, 0.4470588266849518, 0.3333333432674408),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Cylinder,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(0,0, 0),
			Transparency = 1,
			Name = "Rock/1",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-17, 81, 0),
			Transparency = 1,
			Name = "Rock/2",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-15, 116.99800109863281, 0),
			Transparency = 1,
			Name = "Rock/3",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-17, 152.9980010986328, 0),
			Transparency = 1,
			Name = "Rock/4",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-24, -170.9949951171875, 0),
			Transparency = 1,
			Name = "Rock/5",
			Position = vector.create(0,0,0),
			Color = Color3.new(0,0,0),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-30, -134.99600219726562, 0),
			Transparency = 1,
			Name = "Rock/6",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-25, -99, 0),
			Transparency = 1,
			Name = "Rock/7",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-19, -63.00199890136719, 0),
			Transparency = 1,
			Name = "Rock/8",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(-15, -27.00200080871582, 0),
			Transparency = 1,
			Name = "Rock/9",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		},
		{
			Orientation = vector.create(0,0,0),
			Transparency = 0,
			Name = "Rock/10",
			Position = vector.create(0,0,0),
			Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
			Material = Enum.Material.Pebble,
			Shape = Enum.PartType.Block,
			Size = vector.create(0,0,0)
		}
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Dig_Finished"):FireServer(unpack(args))
end

local function Mut()
	if _G.Mut then
		
		StartTask("Mutate V",function()

	local lo = workspace.Active.Debris
	
	for _, p in pairs(lo:GetDescendants()) do
	
	if p:IsA("Model") and string.match(p.Name, plr.Name) then
		for _, e in pairs(p:GetDescendants()) do
			if (e:IsA("Model") or e:IsA("Part")) and Mutation[e.Name] then
			
			task.wait(1.1)
			end
		end
	end
	end
		end)
	else
		StopTask("Mutate V")
	end
end

local function to1()
    if _G.to1 then
	StartTask("Dig", function()
	
        local plr = game.Players.LocalPlayer
        local gui = plr.PlayerGui

        for _,v in pairs(gui:GetDescendants()) do
            if v:IsA("ScreenGui") and v.Name == "Dig" then
                    for _, k in pairs(v:GetDescendants()) do
                        if k:IsA("Frame") and k.Name == "Holder" then
                        local bar = k.PlayerBar
                        local hit = k.Area_Strong
                        bar.Position = hit.Position
                        game:GetService"VirtualUser":Button1Down(Vector2.new(0.9, 0.9))
                        game:GetService"VirtualUser":Button1Up(Vector2.new(0.9, 0.9))
                        	if _G.to2 then
                        	local R = math.random(1,100)
		if R == 100 then
			wait(3)
			fastdig()
		end
                        		
                        	end
                        end
                    end

            end
        end

    
	task.wait(CD) 
end)
    		
else
StopTask("Dig")
    	
end

	
end







local Window = Rayfield:CreateWindow({
   Name = "DIG",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "FREE SCRIPT NOT PAID",
   LoadingSubtitle = "by POSEIDON",
   ShowText = "", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "Z", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "NoSoi Virus"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local abt = Window:CreateTab("About", 4483362458)
local Tab = Window:CreateTab("Main", 4483362458)
local Misc = Window:CreateTab("Misc", 4483362458)

local Paragraph = abt:CreateParagraph({Title = "Info", Content = "Our Script made by No life Group(Discord) \nThis Script Is 100% No Ban and anticheat dectect only remote hooker"})

local Paragraph = abt:CreateParagraph({Title = "Map", Content = "DIG"})

local Paragraph = abt:CreateParagraph({Title = "Warning", Content = "THIS SCRIPT IS FREE IF BUT THIS SCRIPT WITH SOMEONE U GOT SCAMMED"})

local Section = Tab:CreateSection("Config")

--[[local Slider = Tab:CreateSlider({
   Name = "Dig Speed",
   Range = {0.3, 5},
   Increment = 0.1,
   Suffix = "speed",
   CurrentValue = 0.3,
   Flag = "S1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
 CD = Value
 end,
})]]

local Dropdown = Tab:CreateDropdown({
   Name = "Mode",
   Options = {"Slow","Normal","Fast","burst"},
   CurrentOption = {"Normal"},
   MultipleOptions = false,
   Flag = "d1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
   local selected = Options
   if selected == "Slow" then
 	CD = 1.5
   elseif selected == "Normal" then
	CD = 0.55
	elseif selected == "Fast" then
	CD = 0.2
	elseif selected == "burst" then
	CD = 0
	end
	end
   end
   end
   end,
})

local Toggle = Tab:CreateToggle({
   Name = "start Dig",
   CurrentValue = false,
   Flag = "t1", 
   Callback = function(Value)
    _G.to1 = Value
    to1()
end,
})


local Toggle = Tab:CreateToggle({
   Name = "Semi Fast(start dig must on) ",
   CurrentValue = false,
   Flag = "t3", 
   Callback = function(Value)
    _G.to2 = Value
end,
})

local Section = Tab:CreateSection("Shovel")
local Toggle = Tab:CreateToggle({
   Name = "Auto Equipe Shovel",
   CurrentValue = false,
   Flag = "t4", 
   Callback = function(Value)
  	_G.Shovel = Value
	EShovel()
end,
})

local Button = Misc:CreateButton({
   Name = "Delete Hitbox",
   Callback = function()
	workspace.World.Zones._NoDig:Destroy()
   end,
})

local Paragraph = Misc:CreateParagraph({Title = "Delete Hitbox", Content = "it just delete old dig hitbox. \n that hitbox prevent you to dig old position"})

--[[local Toggle = Misc:CreateToggle({
   Name = "Mutation Viewer",
   CurrentValue = false,
   Flag = "t2", 
   Callback = function(Value)
    _G.Mut = Value
    Mut()
end,
})]]

