-- A3K🔑 Key System (Delta Executor)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local CORRECT_KEY = "Free-30849"
local DISCORD_LINK = "https://discord.gg/gZWVVKSwp"
local SCRIPT_URL = "https://raw.githubusercontent.com/louisantho0969-max/DASRI-P/refs/heads/main/DASRI-P"

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "A3KKeySystem"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Fond semi-transparent
local background = Instance.new("Frame")
background.Name = "Background"
background.Parent = screenGui
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.4
background.Size = UDim2.new(1, 0, 1, 0)
background.BorderSizePixel = 0

-- Frame principale
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(100, 70, 255)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

-- Titre
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = mainFrame
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 0, 0, 15)
title.Size = UDim2.new(1, 0, 0, 30)
title.Font = Enum.Font.GothamBold
title.Text = "A3K🔑"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22

-- Sous-titre
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Parent = mainFrame
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 0, 0, 45)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Entrez la clé pour continuer"
subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
subtitle.TextSize = 13

-- TextBox pour la key
local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyBox"
keyBox.Parent = mainFrame
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
keyBox.Position = UDim2.new(0.1, 0, 0.42, 0)
keyBox.Size = UDim2.new(0.8, 0, 0, 40)
keyBox.Font = Enum.Font.Gotham
keyBox.PlaceholderText = "Entrez votre clé ici..."
keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.TextXAlignment = Enum.TextXAlignment.Center

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(80, 60, 160)
keyStroke.Thickness = 1
keyStroke.Parent = keyBox

-- Bouton Get Key
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Name = "GetKeyBtn"
getKeyBtn.Parent = mainFrame
getKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 140)
getKeyBtn.Position = UDim2.new(0.1, 0, 0.68, 0)
getKeyBtn.Size = UDim2.new(0.38, 0, 0, 38)
getKeyBtn.Font = Enum.Font.GothamSemibold
getKeyBtn.Text = "GET KEY"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 14
getKeyBtn.AutoButtonColor = false

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 8)
getKeyCorner.Parent = getKeyBtn

-- Bouton Submit
local submitBtn = Instance.new("TextButton")
submitBtn.Name = "SubmitBtn"
submitBtn.Parent = mainFrame
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 90)
submitBtn.Position = UDim2.new(0.52, 0, 0.68, 0)
submitBtn.Size = UDim2.new(0.38, 0, 0, 38)
submitBtn.Font = Enum.Font.GothamSemibold
submitBtn.Text = "SUBMIT"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.TextSize = 14
submitBtn.AutoButtonColor = false

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitBtn

-- Message d'erreur / succès
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Parent = mainFrame
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(0, 0, 0.88, 0)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
statusLabel.TextSize = 12

-- Effet hover
local function addHover(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = hoverColor
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = normalColor
    end)
end

addHover(getKeyBtn, Color3.fromRGB(60, 50, 140), Color3.fromRGB(80, 70, 180))
addHover(submitBtn, Color3.fromRGB(0, 160, 90), Color3.fromRGB(0, 190, 110))

-- Bouton GET KEY
getKeyBtn.MouseButton1Click:Connect(function()
    keyBox.Text = DISCORD_LINK
    statusLabel.Text = "Lien Discord copié dans la barre !"
    statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
end)

-- Bouton SUBMIT
submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text:gsub("%s+", "")

    if enteredKey == CORRECT_KEY then
        statusLabel.Text = "✅ Clé correcte ! Chargement..."
        statusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)

        task.wait(0.8)
        screenGui:Destroy()

        pcall(function()
            loadstring(game:HttpGet(SCRIPT_URL))()
        end)
    else
        statusLabel.Text = "❌ Clé incorrecte !"
        statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)

        keyBox.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
        task.wait(0.4)
        keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    end
end)

-- Effet rainbow
task.spawn(function()
    while mainFrame.Parent do
        for i = 0, 1, 0.02 do
            if not mainFrame.Parent then break end
            mainStroke.Color = Color3.fromHSV(i, 0.8, 1)
            task.wait(0.04)
        end
    end
end)

print("✅ A3K🔑 Key System chargé !")
