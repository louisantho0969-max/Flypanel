-- Rainbow Fly Panel + Infinite Jump + John Doe + R6 - Delta Executor
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
mainFrame.Size = UDim2.new(0, 240, 0, 240)  -- agrandi pour le nouveau bouton
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

-- Bouton Fly
local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Parent = mainFrame
flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
flyButton.Position = UDim2.new(0.1, 0, 0.28, 0)
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
ijButton.Position = UDim2.new(0.1, 0, 0.48, 0)
ijButton.Size = UDim2.new(0.8, 0, 0, 40)
ijButton.Font = Enum.Font.GothamSemibold
ijButton.Text = "INFINITE JUMP ON"
ijButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ijButton.TextScaled = true

local ijCorner = Instance.new("UICorner")
ijCorner.CornerRadius = UDim.new(0, 10)
ijCorner.Parent = ijButton

-- Bouton John Doe
local jdButton = Instance.new("TextButton")
jdButton.Name = "JohnDoeButton"
jdButton.Parent = mainFrame
jdButton.BackgroundColor3 = Color3.fromRGB(139, 0, 139)
jdButton.Position = UDim2.new(0.1, 0, 0.68, 0)
jdButton.Size = UDim2.new(0.8, 0, 0, 40)
jdButton.Font = Enum.Font.GothamSemibold
jdButton.Text = "JOHN DOE"
jdButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jdButton.TextScaled = true

local jdCorner = Instance.new("UICorner")
jdCorner.CornerRadius = UDim.new(0, 10)
jdCorner.Parent = jdButton

-- Bouton R6
local r6Button = Instance.new("TextButton")
r6Button.Name = "R6Button"
r6Button.Parent = mainFrame
r6Button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- orange
r6Button.Position = UDim2.new(0.1, 0, 0.88, 0)
r6Button.Size = UDim2.new(0.8, 0, 0, 40)
r6Button.Font = Enum.Font.GothamSemibold
r6Button.Text = "R6"
r6Button.TextColor3 = Color3.fromRGB(255, 255, 255)
r6Button.TextScaled = true

local r6Corner = Instance.new("UICorner")
r6Corner.CornerRadius = UDim.new(0, 10)
r6Corner.Parent = r6Button

-- Variables
local flyLoaded = false
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

-- Fly functions
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
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.PlatformStand = on
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

-- John Doe
local function activateJohnDoe()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-John-Doe-131661"))()
    end)
end

-- R6 (le script que tu as fourni)
local function activateR6()
    pcall(function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/jHGVauVX'), true))()
        print("✅ R6 activé !")
    end)
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

ijButton.MouseButton1Click:Connect(function()
    toggleInfiniteJump(not ijEnabled)
end)

jdButton.MouseButton1Click:Connect(activateJohnDoe)

r6Button.MouseButton1Click:Connect(function()
    activateR6()
    r6Button.Text = "R6 ✓"
    task.delay(1.5, function()
        if r6Button and r6Button.Parent then r6Button.Text = "R6" end
    end)
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
    Text = "R6 ajouté !",
    Duration = 5
})

print("✅ Panel complet avec R6 chargé !")
