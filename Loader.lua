local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Build A Boat For Treasure | Sinestria Hub",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(610, 490),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.Home -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Genaral = Window:AddTab({ Title = "Genaral", Icon = "rbxassetid://11433532654" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Team = Window:AddTab({ Title = "Change Team", Icon = "flag" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "rbxassetid://11419702273" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "rbxassetid://11293977610" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Notification",
        Content = "Sinestria running in Script.",
        SubContent = "", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })
end


Tabs.Genaral:AddParagraph({
    Title = "AutoFarm",
    Content =  "💲💲"
})


--autoFarm

--slider speed
local Slider = Tabs.Genaral:AddSlider("Slider", {
    Title = "Speed Tween",
    Description = "",
    Default = 400,
    Min = 400,
    Max = 1000,
    Rounding = 0,
})

Slider:OnChanged(function(Value)
    -- Do nothing here since we are directly accessing the value when needed
end)

Slider:SetValue(400)

local Toggle = Tabs.Genaral:AddToggle("MyToggle", {Title = "AutoFarmGold [No Full Option]", Default = false })

Toggle:OnChanged(function(Value)
    _G.Farm = Value
    if _G.Farm then
        while _G.Farm do
            local targetPositions = {
                Vector3.new(-49.6203003, 52.1805964, 668.363831),
                Vector3.new(-49.0358887, 44.6002235, 1283.07361),
                Vector3.new(-54.21815872192383, 61.31955337524414, 1362.96435546875),
                Vector3.new(-51.05792999267578, 58.07366180419922, 2137.30810546875),
                Vector3.new(-56.77909469604492, 53.95687484741211, 2907.669921875),
                Vector3.new(-60.69740676879883, 57.617332458496094, 3674.162841796875),
                Vector3.new(-54.92622375488281, 55.52228546142578, 4441.00341796875),
                Vector3.new(-56.729576110839844, 55.55670928955078, 5212.1337890625),
                Vector3.new(-56.330936431884766, 67.23455810546875, 5981.82958984375),
                Vector3.new(-54.3404541015625, 44.643558502197266, 6759.51904296875),
                Vector3.new(-52.860652923583984, 40.938262939453125, 7537.98193359375),
                Vector3.new(-39.3001823425293, 62.53487014770508, 8301.2998046875),
                Vector3.new(-45.933799743652344, 67.70562744140625, 8816.8271484375)
                -- Add more target positions as needed
            }

            local currentTargetIndex = 1

            local function teleportToNextTarget()
                local targetPosition = targetPositions[currentTargetIndex]

                -- Validate target position
                if not targetPosition then
                    warn("Invalid target position at index", currentTargetIndex)
                    return
                end

                local distance = (targetPosition - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local speed = Slider.Value -- ดึงค่า speed จาก Slider
                local duration = distance / speed

                local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                local tween = game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    tweenInfo,
                    {CFrame = CFrame.new(targetPosition)}
                )
                tween:Play()

                tween.Completed:Connect(function()
                    currentTargetIndex += 1
                    if currentTargetIndex <= #targetPositions then
                        teleportToNextTarget()
                    else
                        print("Reached all target positions!")
                        -- Optional: Perform actions when all targets are reached
                    end
                end)
            end
            teleportToNextTarget()
            workspace:WaitForChild("ClaimRiverResultsGold"):FireServer()
            wait(25)
            local function forceResetAction(player)
               -- Check if player and Humanoid exist
               if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                 player.Character.Humanoid.Health = 0
               end
             end
             
             -- Example usage (call this function from another script)
             -- Replace "game.Players.LocalPlayer" with the target player object if needed
             forceResetAction(game.Players.LocalPlayer)
            wait(7)
        end
    end
end)

Options.MyToggle:SetValue(false)


--autoFarm money,gold



local Toggle = Tabs.Genaral:AddToggle("MyToggle", {Title = "AutoFarmGold[Full Option]", Default = false })

Toggle:OnChanged(function(Value)
    _G.Farm2 = Value
    if _G.Farm2 then
        while _G.Farm2 do
            local targetPositions = {
                Vector3.new(-49.6203003, 52.1805964, 668.363831),
                Vector3.new(-49.0358887, 44.6002235, 1283.07361),
                Vector3.new(-54.21815872192383, 61.31955337524414, 1362.96435546875),
                Vector3.new(-51.05792999267578, 58.07366180419922, 2137.30810546875),
                Vector3.new(-56.77909469604492, 53.95687484741211, 2907.669921875),
                Vector3.new(-60.69740676879883, 57.617332458496094, 3674.162841796875),
                Vector3.new(-54.92622375488281, 55.52228546142578, 4441.00341796875),
                Vector3.new(-56.729576110839844, 55.55670928955078, 5212.1337890625),
                Vector3.new(-56.330936431884766, 67.23455810546875, 5981.82958984375),
                Vector3.new(-54.3404541015625, 44.643558502197266, 6759.51904296875),
                Vector3.new(-52.860652923583984, 40.938262939453125, 7537.98193359375),
                Vector3.new(-39.3001823425293, 62.53487014770508, 8301.2998046875),
                Vector3.new(-45.933799743652344, 67.70562744140625, 8816.8271484375),
                Vector3.new(-55.7633247, -359.302094, 9496.33789, 0.0546190403, 6.63240058e-08, 0.998507261, 7.08811356e-08, 1, -7.03004019e-08, -0.998507261, 7.46150661e-08, 0.0546190403)
                -- Add more target positions as needed
            }

            local currentTargetIndex = 1

            local function teleportToNextTarget()
                local targetPosition = targetPositions[currentTargetIndex]

                -- Validate target position
                if not targetPosition then
                    warn("Invalid target position at index", currentTargetIndex)
                    return
                end

                local distance = (targetPosition - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local speed = Slider.Value -- ดึงค่า speed จาก Slider
                local duration = distance / speed

                local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                local tween = game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    tweenInfo,
                    {CFrame = CFrame.new(targetPosition)}
                )
                tween:Play()

                tween.Completed:Connect(function()
                    currentTargetIndex += 1
                    if currentTargetIndex <= #targetPositions then
                        teleportToNextTarget()
                    else
                        print("Reached all target positions!")
                        -- Optional: Perform actions when all targets are reached
                    end
                end)
            end
            teleportToNextTarget()
            workspace:WaitForChild("ClaimRiverResultsGold"):FireServer()
            wait(45)
        end
    end
end)

Options.MyToggle:SetValue(false)





--autoFarm Box

local Toggle = Tabs.Genaral:AddToggle("MyToggle", {Title = "AutoFarmGold💰", Default = false })

Toggle:OnChanged(function(Value)
    _G.FarmGold = Value
    if _G.FarmGold then
    while _G.FarmGold do

        local targetPositions = {
                    Vector3.new(-49.6203003, 52.1805964, 668.363831, -0.999993563, -0.0002226332, 0.00357921072, 7.38511075e-12, 0.998071074, 0.0620817766, -0.00358612812, 0.062081378, -0.998064637),
                    Vector3.new(-49.0358887, 44.6002235, 1283.07361, -0.999757111, -0.00103060459, 0.0220147371, 5.74352198e-11, 0.998906016, 0.0467630923, -0.0220388472, 0.0467517339, -0.998663366),
                    Vector3.new(-52.2924042, 52.8626137, 8810.67676, -0.999800801, -0.00402260385, -0.0195484515, -1.07728368e-10, 0.979477584, -0.201553062, 0.0199580379, -0.201512918, -0.979282498),
                    Vector3.new(-55.7633247, -359.302094, 9496.33789, 0.0546190403, 6.63240058e-08, 0.998507261, 7.08811356e-08, 1, -7.03004019e-08, -0.998507261, 7.46150661e-08, 0.0546190403)
                    -- Add more target positions as needed
                }
                
                local currentTargetIndex = 1
                
                local function teleportToNextTarget()
                    local targetPosition = targetPositions[currentTargetIndex]
                
                    -- Validate target position
                    if not targetPosition then
                        warn("Invalid target position at index", currentTargetIndex)
                        return
                    end
                
                    local distance = (targetPosition - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    local speed = 2900 -- Adjust speed as desired
                    local duration = distance / speed
                
                    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                    local tween = game:GetService("TweenService"):Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        tweenInfo,
                        {CFrame = CFrame.new(targetPosition)}
                    )
                    tween:Play()
                
                    tween.Completed:Connect(function()
                        currentTargetIndex += 1
                        teleportToNextTarget()
                            game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
                                wait(0) -- Wait for death animation to finish
                                currentTargetIndex = 1 -- Reset index to teleport back to the first position
                                teleportToNextTarget() -- Restart the loop
                            end)
                        end)
                    end
                teleportToNextTarget() -- Start the loop
                wait(30)
                workspace:WaitForChild("ClaimRiverResultsGold"):FireServer()
                end
    end
end)

Options.MyToggle:SetValue(false)

--SmoothTween



--PlayerSpeed

local Slider = Tabs.Player:AddSlider("Slider", {
    Title = "Speed",
    Description = "",
    Default = 20,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

Slider:OnChanged(function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

Slider:SetValue(16)

--Jump Power

local Slider = Tabs.Player:AddSlider("Slider", {
    Title = "JumpPower",
    Description = "",
    Default = 50,
    Min = 15,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

Slider:OnChanged(function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)

Slider:SetValue(50)





Tabs.Player:AddButton({
    Title = "Reset☠️",
    Description = "",
    Callback = function()
        local function forceResetAction(player)
            -- Check if player and Humanoid exist
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
              player.Character.Humanoid.Health = 0
            end
          end
          
          -- Example usage (call this function from another script)
          -- Replace "game.Players.LocalPlayer" with the target player object if needed
          forceResetAction(game.Players.LocalPlayer)
    end
})


--anti afk

local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "AntiAfk", Default = false })

Toggle:OnChanged(function(Value)
    _G.antiAFK = Value

    while _G.antiAFK do wait(600)

    game:GetService'VirtualUser':Button1Down(Vector2.new(788, 547))
    
end
end)


local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Noclip", Default = false })

Toggle:OnChanged(function(Value)
    do 
        local NM = game:GetService("Workspace"):FindFirstChild("Noclip")
        if NM then
            NM:Destroy()
        end
    end
    local Noclip = Instance.new("Part",Workspace)
        Noclip.Name = "Noclip"
        Noclip.CanCollide = true
        Noclip.Anchored = true
        Noclip.Transparency = 1
        Noclip.Size = Vector3.new(50, 1, 50)
    function Noclip()
        game:GetService("Workspace"):FindFirstChild("Noclip").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-4,0)
    end
    _G.Noclip = Value
    while _G.Noclip do wait()
    pcall(function()
    Noclip()
    end)
end
end)

Options.MyToggle:SetValue(false)

--Shop
Tabs.Shop:AddParagraph({
    Title = "Accessories Tool",
    Content = ""
})

Tabs.Shop:AddButton({
    Title = "Buy Painting Tool",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Warning",
            Content = "1500 Gold",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local args = {
                            [1] = "Painting Tool",
                            [2] = 1
                        }
                        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(unpack(args))
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Binding Tool",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Warning",
            Content = "2000 Gold",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local args = {
                            [1] = "Binding Tool",
                            [2] = 1
                        }
                        
                        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(unpack(args))
                        
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Property Tool",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Warning",
            Content = "2500 Gold",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local args = {
                            [1] = "Property Tool",
                            [2] = 1
                        }
                        
                        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(unpack(args))
                        
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

Tabs.Shop:AddButton({
    Title = "Buy Scaling Tool",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Warning",
            Content = "5000 Gold",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local args = {
                            [1] = "Scaling Tool",
                            [2] = 1
                        }
                        
                        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(unpack(args))
                        
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

Tabs.Shop:AddButton({
    Title = "Buy Trowel Tool",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Warning",
            Content = "7500 Gold",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local args = {
                            [1] = "Trowel Tool",
                            [2] = 1
                        }
                        
                        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer(unpack(args))
                        
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

--Setting

--rejoin

Tabs.Settings:AddButton({
    Title = "Rejoin Server",
    Description = "",
    Callback = function()
        local ts = game:GetService("TeleportService")

        local p = game:GetService("Players").LocalPlayer
        
         
        
        ts:Teleport(game.PlaceId, p)
    end
})


--hopServerto low


Tabs.Settings:AddButton({
    Title = "Hop Server",
    Description = "",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        
        local _place = game.PlaceId
        local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
        function ListServers(cursor)
           local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
           return Http:JSONDecode(Raw)
        end
        
        local Server, Next; repeat
           local Servers = ListServers(Next)
           Server = Servers.data[1]
           Next = Servers.nextPageCursor
        until Server
        
        TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
    end
})






--FPS boot

Tabs.Settings:AddButton({
    Title = "FpsBoots🚀",
    Description = "",
    Callback = function()

local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
sethiddenproperty(l,"Technology",2)
sethiddenproperty(t,"Decoration",false)
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = 0
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(w:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted  then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.Graphic=0
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=0
    end
end
for i = 1,#l:GetChildren() do
    e=l:GetChildren()[i]
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end
w.DescendantAdded:Connect(function(v)
    wait()--prevent errors and shit
   if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.ShirtGraphic=0
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=0
    end
end)
    end
})


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Notification",
    Content = "The script has been loading",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()



--Team
function TeleportToColor(color)
    if color == "Black" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-585.89892578125, -9.701964378356934, -58.53709030151367)
    elseif color == "Blue" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(478.3410339355469, -9.7019624710083, 289.38494873046875)
    elseif color == "Green" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-585.833251953125, -9.701966285705566, 303.4530944824219)
    elseif color == "Pink" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(478.5516052246094, -9.701963424682617, 636.7717895507812)
    elseif color == "Red" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(478.5126037597656, -9.701966285705566, -75.66240692138672)
    elseif color == "White" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-60.072845458984375, -9.701964378356934, -602.3859252929688)
    elseif color == "Yellow" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-585.8826293945312, -9.701966285705566, 651.19970703125)
    end
end


Tabs.Team:AddParagraph({
    Title = "Teleport To Team Color",
    Content = ""
})


local Dropdown = Tabs.Team:AddDropdown("Dropdown", {
    Title = "Select Team",
    Values = {"Black", "Blue", "Green", "Pink", "Red", "White", "Yellow"},
    Multi = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    color = Value
end)

Tabs.Team:AddButton({
    Title = "Teleport",
    Description = "",
    Callback = function()
    TeleportToColor(Dropdown.Value)
    end
})



--uitoggle

do
    local ToggleUI = game.CoreGui:FindFirstChild("MyToggle") 
    if ToggleUI then 
    ToggleUI:Destroy() 
    end
end

local MyToggle = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

--Properties:

MyToggle.Name = "MyToggle"
MyToggle.Parent = game.CoreGui
MyToggle.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton.Parent = MyToggle
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.156000003, 0, -0, 0)
ImageButton.Size = UDim2.new(0, 50, 0, 50)
ImageButton.Image = "rbxassetid://96764407519217"
ImageButton.MouseButton1Click:Connect(function()
game.CoreGui:FindFirstChild("ScreenGui").Enabled = not game.CoreGui:FindFirstChild("ScreenGui").Enabled
end)


UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ImageButton
