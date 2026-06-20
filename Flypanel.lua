-- Petit Panel Multicolore + Fly Toggle + Bouton Fermer - Delta Executor
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowFlyPanel"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Frame principale
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Active = true
mainFrame.Draggable = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Titre multicolore (rainbow)
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = mainFrame
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Font = Enum.Font.GothamBold
title.Text = "🌈 Fly Panel"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextStrokeTransparency = 0.7

-- Bouton Fermer (X rouge)
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

-- Bouton Fly ON/OFF
local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Parent = mainFrame
flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
flyButton.Position = UDim2.new(0.1, 0, 0.45, 0)
flyButton.Size = UDim2.new(0.8, 0, 0, 45)
flyButton.Font = Enum.Font.GothamSemibold
flyButton.Text = "FLY ON"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextScaled = true

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = flyButton

-- Variables
local flyLoaded = false
local flyScript = nil

-- Fonction rainbow
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

-- Charger le script Fly
local function loadFly()
    if flyLoaded then return end
    flyLoaded = true
    local success, err = pcall(function()
        flyScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
    if not success then
        warn("Erreur Fly Script: " .. err)
    end
end

-- Toggle Fly
local flying = false
flyButton.MouseButton1Click:Connect(function()
    if not flyLoaded then
        loadFly()
    end
    
    flying = not flying
    if flying then
        flyButton.Text = "FLY OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    else
        flyButton.Text = "FLY ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end)

-- Bouton Fermer
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Lancer rainbow
task.spawn(rainbowEffect)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rainbow Fly Panel",
    Text = "Panel chargé ! Clique sur FLY ou X pour fermer.",
    Duration = 5
})

print("✅ Rainbow Fly Panel chargé avec succès !")
