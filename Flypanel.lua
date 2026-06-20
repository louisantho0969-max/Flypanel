-- Noclip GUI
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local RunService = game:GetService("RunService")

local noclip = false

-- GUI
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "NoclipGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 80)
Frame.Position = UDim2.new(0, 20, 0.6, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0, 120, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 20)
Button.Text = "NOCLIP OFF"
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
Button.TextColor3 = Color3.fromRGB(255,255,255)

-- Function
RunService.Stepped:Connect(function()
	if noclip and char then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

Button.MouseButton1Click:Connect(function()
	noclip = not noclip
	if noclip then
		Button.Text = "NOCLIP ON"
	else
		Button.Text = "NOCLIP OFF"
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end
end)
