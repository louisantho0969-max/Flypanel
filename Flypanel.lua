-- Petit Panel Multicolore + Fly Toggle - Pour Delta Executor
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowFlyPanel"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Frame principale (petit panel)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Active = true
mainFrame.Draggable = true

-- Coin arrondi
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

-- Fonction rainbow (animation de couleurs)
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

-- Charger le script Fly (de ton lien)
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
        -- Le script Fly V3 gère déjà son propre toggle interne via son bouton "fly"
        -- Si besoin d'activer directement, on peut simuler, mais le load suffit généralement
    else
        flyButton.Text = "FLY ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        -- Le script Fly V3 a son propre système de toggle
    end
end)

-- Lancer l'effet rainbow
task.spawn(rainbowEffect)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rainbow Fly Panel",
    Text = "Panel chargé ! Clique sur FLY pour activer.",
    Duration = 5
})

print("✅ Rainbow Fly Panel chargé avec succès !")
