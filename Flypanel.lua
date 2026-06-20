-- Rainbow Fly Panel + Infinite Jump - Delta Executor
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
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
mainFrame.Size = UDim2.new(0, 240, 0, 160)  -- un peu plus grand
mainFrame.Active = true
mainFrame.Draggable = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Titre rainbow
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

-- Bouton Fermer X
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
flyButton.Position = UDim2.new(0.1, 0, 0.35, 0)
flyButton.Size = UDim2.new(0.8, 0, 0, 45)
flyButton.Font = Enum.Font.GothamSemibold
flyButton.Text = "FLY ON"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextScaled = true

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyButton

-- Bouton Infinite Jump
local ijButton = Instance.new("TextButton")
ijButton.Name = "IJButton"
ijButton.Parent = mainFrame
ijButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ijButton.Position = UDim2.new(0.1, 0, 0.68, 0)
ijButton.Size = UDim2.new(0.8, 0, 0, 40)
ijButton.Font = Enum.Font.GothamSemibold
ijButton.Text = "INFINITE JUMP ON"
ijButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ijButton.TextScaled = true

local ijCorner = Instance.new("UICorner")
ijCorner.CornerRadius = UDim.new(0, 10)
ijCorner.Parent = ijButton

-- Variables
local flyLoaded = false
local flyGui = nil
local ijEnabled = false
local ijConnection = nil

-- Rainbow effect
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

-- Charger le Fly Script une seule fois
local function loadFly()
    if flyLoaded then return end
    flyLoaded = true
    pcall(function()
        flyGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
end

-- Activer/Désactiver Fly (on simule le toggle du script original)
local function toggleFly(on)
    if not flyLoaded then loadFly() end
    pcall(function()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        if on then
            -- Active le vol (simule le bouton "onof")
            hum.PlatformStand = true
            -- Le script original utilise la variable "nowe", mais on force l'état
        else
            hum.PlatformStand = false
            -- Réactive les états normaux
            hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        end
    end)
end

-- Infinite Jump
local function toggleInfiniteJump(enable)
    ijEnabled = enable
    if enable then
        if not ijConnection then
            ijConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                if ijEnabled and player.Character then
                    local hum = player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
        ijButton.Text = "INFINITE JUMP OFF"
        ijButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    else
        if ijConnection then
            ijConnection:Disconnect()
            ijConnection = nil
        end
        ijButton.Text = "INFINITE JUMP ON"
        ijButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end
end

-- Toggle Fly
flyButton.MouseButton1Click:Connect(function()
    local flying = flyButton.Text == "FLY ON"
    if flying then
        flyButton.Text = "FLY OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        toggleFly(true)
    else
        flyButton.Text = "FLY ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        toggleFly(false)
    end
end)

-- Toggle Infinite Jump
ijButton.MouseButton1Click:Connect(function()
    toggleInfiniteJump(not ijEnabled)
end)

-- Fermer panel
closeButton.MouseButton1Click:Connect(function()
    if ijConnection then ijConnection:Disconnect() end
    screenGui:Destroy()
end)

-- Lancer rainbow
task.spawn(rainbowEffect)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rainbow Fly Panel",
    Text = "Panel chargé ! Fly + Infinite Jump",
    Duration = 5
})

print("✅ Rainbow Fly Panel + Infinite Jump chargé !")
