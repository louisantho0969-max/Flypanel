-- Rainbow Fly Panel + Loading Stylé - Version Complète
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==================== CHARGEMENT STYLÉ ====================
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "StylishLoader"
loadingGui.Parent = playerGui
loadingGui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingFrame"
loadingFrame.Parent = loadingGui
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loadingFrame.Size = UDim2.new(0, 320, 0, 180)
loadingFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
loadingFrame.Active = true
loadingFrame.Draggable = false

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 20)
loadingCorner.Parent = loadingFrame

local icon = Instance.new("ImageLabel")
icon.Name = "Icon"
icon.Parent = loadingFrame
icon.BackgroundTransparency = 1
icon.Size = UDim2.new(0, 80, 0, 80)
icon.Position = UDim2.new(0.5, -40, 0.2, 0)
icon.Image = "rbxassetid://3926305904" 
icon.ImageColor3 = Color3.fromRGB(0, 255, 200)

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 16)
iconCorner.Parent = icon

local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.Parent = loadingFrame
loadingText.BackgroundTransparency = 1
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0, 0, 0.65, 0)
loadingText.Font = Enum.Font.GothamBold
loadingText.Text = "CHARGEMENT..."
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.TextScaled = true

-- Animation Loading
task.spawn(function()
    while loadingGui.Parent do
        icon.Rotation = icon.Rotation + 8
        task.wait(0.03)
    end
end)

local function loadingRainbow()
    for i = 0, 1, 0.015 do
        local color = Color3.fromHSV(i, 1, 1)
        loadingFrame.BorderColor3 = color
        icon.ImageColor3 = color
        loadingText.TextColor3 = color
        task.wait(0.04)
    end
end
task.spawn(loadingRainbow)

task.wait(3)
loadingFrame:TweenSizeAndPosition(UDim2.new(0,0,0,0), UDim2.new(0.5,0,0.5,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.6, true)
task.wait(0.7)
loadingGui:Destroy()

-- ==================== PANEL PRINCIPAL ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowFlyPanel"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.4, 0, 0.25, 0)
mainFrame.Size = UDim2.new(0, 240, 0, 300)
mainFrame.Active = true
mainFrame.Draggable = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Titre
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = mainFrame
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Font = Enum.Font.GothamBold
title.Text = "🌈 Fly Panel"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true

-- Bouton Fermer
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Parent = mainFrame
closeButton.BackgroundColor3 = Color3.fromRGB(220, 20, 20)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Boutons
local function createButton(name, text, posY, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = mainFrame
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    return btn
end

local flyButton   = createButton("FlyButton",   "FLY ON",          0.22, Color3.fromRGB(0, 170, 0))
local ijButton    = createButton("IJButton",    "INFINITE JUMP ON",0.37, Color3.fromRGB(0, 120, 255))
local jdButton    = createButton("JohnDoeButton","JOHN DOE",       0.52, Color3.fromRGB(139, 0, 139))
local r6Button    = createButton("R6Button",    "R6",              0.67, Color3.fromRGB(255, 140, 0))
local noclipButton= createButton("NoclipButton","NOCLIP ON",       0.82, Color3.fromRGB(0, 200, 100))

-- Variables
local flyLoaded = false
local ijEnabled = false
local ijConnection = nil
local noclipEnabled = false
local noclipConnection = nil
local character = player.Character or player.CharacterAdded:Wait()

-- Rainbow Effect
local function rainbowEffect()
    while mainFrame.Parent do
        for i = 0, 1, 0.01 do
            if not mainFrame.Parent then break end
            local color = Color3.fromHSV(i, 1, 1)
            mainFrame.BorderColor3 = color
            title.TextColor3 = color
            task.wait(0.03)
        end
    end
end

-- Fly
local function loadFly()
    if flyLoaded then return end
    flyLoaded = true
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
end

local function toggleFly(on)
    if not flyLoaded then loadFly() end
    pcall(function()
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.PlatformStand = on
        end
    end)
end

-- Infinite Jump
local function toggleInfiniteJump(enable)
    ijEnabled = enable
    if enable then
        if not ijConnection then
            ijConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                if ijEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
        ijButton.Text = "INFINITE JUMP OFF"
        ijButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    else
        if ijConnection then ijConnection:Disconnect() ijConnection = nil end
        ijButton.Text = "INFINITE JUMP ON"
        ijButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end
end

-- Noclip
local function toggleNoclip(enable)
    noclipEnabled = enable
    if enable then
        if not noclipConnection then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                if noclipEnabled and character then
                    for _, v in pairs(character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end)
        end
        noclipButton.Text = "NOCLIP OFF"
        noclipButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
        if character then
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = true end
            end
        end
        noclipButton.Text = "NOCLIP ON"
        noclipButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    end
end

local function activateJohnDoe()
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-John-Doe-131661"))() end)
end

local function activateR6()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/jHGVauVX", true))() end)
end

-- Connexions
flyButton.MouseButton1Click:Connect(function()
    local isOn = flyButton.Text == "FLY ON"
    if isOn then
        flyButton.Text = "FLY OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        toggleFly(true)
    else
        flyButton.Text = "FLY ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        toggleFly(false)
    end
end)

ijButton.MouseButton1Click:Connect(function() toggleInfiniteJump(not ijEnabled) end)
jdButton.MouseButton1Click:Connect(activateJohnDoe)
r6Button.MouseButton1Click:Connect(activateR6)
noclipButton.MouseButton1Click:Connect(function() toggleNoclip(not noclipEnabled) end)

player.CharacterAdded:Connect(function(new) character = new end)

closeButton.MouseButton1Click:Connect(function()
    if ijConnection then ijConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    screenGui:Destroy()
end)

task.spawn(rainbowEffect)

print("✅ Panel complet avec loading stylé chargé !")
