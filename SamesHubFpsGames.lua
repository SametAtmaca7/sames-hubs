-- ==========================================================
-- SAMES HUB v6.0 ULTIMATE - LOADING FIX & BYPASS STABLE
-- ==========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Eski GUI'leri güvenle temizle
pcall(function()
	if PlayerGui:FindFirstChild("SamesHubGui") then PlayerGui.SamesHubGui:Destroy() end
	if PlayerGui:FindFirstChild("SamesLoadingGui") then PlayerGui.SamesLoadingGui:Destroy() end
end)

-- Oyun İsmi
local success, gameInfo = pcall(function()
	return MarketplaceService:GetProductInfo(game.PlaceId)
end)
local gameName = success and gameInfo.Name or "Roblox FPS / Combat"

-- ==========================================================
-- 1. STABLE LOADING EKRANI (DONMA ÇÖZÜldü)
-- ==========================================================
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "SamesLoadingGui"
LoadGui.ResetOnSpawn = false
LoadGui.Parent = PlayerGui

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 360, 0, 120)
LoadFrame.Position = UDim2.new(0.5, -180, 0.5, -60)
LoadFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = LoadGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 10)
LoadCorner.Parent = LoadFrame

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Color = Color3.fromRGB(0, 255, 128)
LoadStroke.Thickness = 1.5
LoadStroke.Parent = LoadFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 35)
LoadTitle.Position = UDim2.new(0, 0, 0, 15)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "⚡ SAMES HUB v6.0 Hazırlanıyor..."
LoadTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
LoadTitle.TextSize = 14
LoadTitle.Font = Enum.Font.Code
LoadTitle.Parent = LoadFrame

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(1, 0, 0, 20)
LoadSub.Position = UDim2.new(0, 0, 0, 45)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "Oyun: " .. gameName
LoadSub.TextColor3 = Color3.fromRGB(150, 160, 175)
LoadSub.TextSize = 11
LoadSub.Font = Enum.Font.Code
LoadSub.Parent = LoadFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 310, 0, 8)
BarBg.Position = UDim2.new(0, 25, 0, 80)
BarBg.BackgroundColor3 = Color3.fromRGB(20, 24, 32)
BarBg.BorderSizePixel = 0
BarBg.Parent = LoadFrame

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg

-- Akıcı ve hızlı dolum (Donma yapmaz)
for i = 1, 100, 2 do
	BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
	task.wait(0.01)
end
LoadGui:Destroy()

-- ==========================================================
-- 2. ANA EKRAN & PİNG & TARGET INFO
-- ==========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SamesHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local InfoBox = Instance.new("Frame")
InfoBox.Size = UDim2.new(0, 240, 0, 65)
InfoBox.Position = UDim2.new(0, 15, 0, 15)
InfoBox.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
InfoBox.BorderSizePixel = 0
InfoBox.Parent = ScreenGui

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoBox

local InfoStroke = Instance.new("UIStroke")
InfoStroke.Color = Color3.fromRGB(0, 255, 128)
InfoStroke.Thickness = 1
InfoStroke.Parent = InfoBox

local PlayerNameLbl = Instance.new("TextLabel")
PlayerNameLbl.Size = UDim2.new(1, -12, 0, 22)
PlayerNameLbl.Position = UDim2.new(0, 12, 0, 6)
PlayerNameLbl.BackgroundTransparency = 1
PlayerNameLbl.Text = "👤 " .. LocalPlayer.Name
PlayerNameLbl.TextColor3 = Color3.fromRGB(0, 255, 128)
PlayerNameLbl.TextSize = 12
PlayerNameLbl.Font = Enum.Font.Code
PlayerNameLbl.TextXAlignment = Enum.TextXAlignment.Left
PlayerNameLbl.Parent = InfoBox

local GameLbl = Instance.new("TextLabel")
GameLbl.Size = UDim2.new(1, -12, 0, 18)
GameLbl.Position = UDim2.new(0, 12, 0, 24)
GameLbl.BackgroundTransparency = 1
GameLbl.Text = "🎮 " .. gameName
GameLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
GameLbl.TextSize = 10
GameLbl.Font = Enum.Font.Code
GameLbl.TextXAlignment = Enum.TextXAlignment.Left
GameLbl.Parent = InfoBox

local PingLbl = Instance.new("TextLabel")
PingLbl.Size = UDim2.new(1, -12, 0, 18)
PingLbl.Position = UDim2.new(0, 12, 0, 41)
PingLbl.BackgroundTransparency = 1
PingLbl.Text = "📡 Ping: ..."
PingLbl.TextColor3 = Color3.fromRGB(130, 140, 160)
PingLbl.TextSize = 10
PingLbl.Font = Enum.Font.Code
PingLbl.TextXAlignment = Enum.TextXAlignment.Left
PingLbl.Parent = InfoBox

RunService.RenderStepped:Connect(function()
	pcall(function()
		local pings = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
		PingLbl.Text = "📡 Ping: " .. math.floor(pings) .. " ms"
	end)
end)

-- Target Info Paneli
local TargetInfoBox = Instance.new("Frame")
TargetInfoBox.Size = UDim2.new(0, 220, 0, 50)
TargetInfoBox.Position = UDim2.new(0.5, -110, 0, 20)
TargetInfoBox.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
TargetInfoBox.BackgroundTransparency = 0.2
TargetInfoBox.BorderSizePixel = 0
TargetInfoBox.Visible = false
TargetInfoBox.Parent = ScreenGui

local TargetCorner = Instance.new("UICorner")
TargetCorner.CornerRadius = UDim.new(0, 6)
TargetCorner.Parent = TargetInfoBox

local TargetNameLbl = Instance.new("TextLabel")
TargetNameLbl.Size = UDim2.new(1, 0, 0, 22)
TargetNameLbl.Position = UDim2.new(0, 0, 0, 4)
TargetNameLbl.BackgroundTransparency = 1
TargetNameLbl.Text = "Hedef: Yok"
TargetNameLbl.TextColor3 = Color3.fromRGB(255, 60, 60)
TargetNameLbl.TextSize = 12
TargetNameLbl.Font = Enum.Font.Code
TargetNameLbl.Parent = TargetInfoBox

local TargetHealthBarBg = Instance.new("Frame")
TargetHealthBarBg.Size = UDim2.new(0, 190, 0, 10)
TargetHealthBarBg.Position = UDim2.new(0, 15, 0, 28)
TargetHealthBarBg.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
TargetHealthBarBg.BorderSizePixel = 0
TargetHealthBarBg.Parent = TargetInfoBox

local TargetHealthBar = Instance.new("Frame")
TargetHealthBar.Size = UDim2.new(1, 0, 1, 0)
TargetHealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
TargetHealthBar.BorderSizePixel = 0
TargetHealthBar.Parent = TargetHealthBarBg

-- Ana Menü
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 420)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 128)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SAMES HUB v6.0 ULTIMATE — [K: Gizle/Göster]"
Title.TextColor3 = Color3.fromRGB(0, 255, 128)
Title.TextSize = 13
Title.Font = Enum.Font.Code
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 140, 1, -50)
TabContainer.Position = UDim2.new(0, 6, 0, 44)
TabContainer.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabContainer

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -156, 1, -50)
ContentContainer.Position = UDim2.new(0, 150, 0, 44)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local categories = {"Combat", "Visuals", "Player", "Teleport", "Misc"}
local pages = {}
local tabButtons = {}

for i, catName in ipairs(categories) do
	local scroll = Instance.new("ScrollingFrame")
	scroll.Name = catName .. "Page"
	scroll.Size = UDim2.new(1, 0, 1, 0)
	scroll.BackgroundTransparency = 1
	scroll.CanvasSize = UDim2.new(0, 0, 0, 650)
	scroll.ScrollBarThickness = 4
	scroll.Visible = (i == 1)
	scroll.Parent = ContentContainer
	pages[catName] = scroll

	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(1, -10, 0, 36)
	tabBtn.Position = UDim2.new(0, 5, 0, (i - 1) * 40 + 6)
	tabBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(22, 26, 35)
	tabBtn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 190, 205)
	tabBtn.Text = catName
	tabBtn.TextSize = 12
	tabBtn.Font = Enum.Font.Code
	tabBtn.Parent = TabContainer
	tabButtons[catName] = tabBtn

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = tabBtn

	tabBtn.MouseButton1Click:Connect(function()
		for name, page in pairs(pages) do
			page.Visible = (name == catName)
		end
		for name, b in pairs(tabButtons) do
			b.BackgroundColor3 = Color3.fromRGB(22, 26, 35)
			b.TextColor3 = Color3.fromRGB(180, 190, 205)
		end
		tabBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
		tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
end

local yPosMap = {Combat = 10, Visuals = 10, Player = 10, Teleport = 10, Misc = 10}

local function addBtn(cat, text, callback)
	local scroll = pages[cat]
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 380, 0, 34)
	btn.Position = UDim2.new(0, 5, 0, yPosMap[cat])
	btn.BackgroundColor3 = Color3.fromRGB(22, 26, 35)
	btn.TextColor3 = Color3.fromRGB(220, 230, 240)
	btn.Text = text .. " [ OFF ]"
	btn.TextSize = 12
	btn.Font = Enum.Font.Code
	btn.Parent = scroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn

	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.Text = text .. (active and " [ ON ]" or " [ OFF ]")
		btn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(22, 26, 35)
		pcall(function() callback(active) end)
	end)
	yPosMap[cat] = yPosMap[cat] + 40
	return btn
end

local function addBox(cat, placeholder, callback)
	local scroll = pages[cat]
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 380, 0, 34)
	box.Position = UDim2.new(0, 5, 0, yPosMap[cat])
	box.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = Color3.fromRGB(110, 120, 140)
	box.Text = ""
	box.TextSize = 12
	box.Font = Enum.Font.Code
	box.Parent = scroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = box

	box.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local num = tonumber(box.Text)
			if num then pcall(function() callback(num) end) end
		end
	end)
	yPosMap[cat] = yPosMap[cat] + 40
	return box
end

local function isEnemy(player)
	if player == LocalPlayer then return false end
	if LocalPlayer.Team and player.Team then
		return player.Team ~= LocalPlayer.Team
	end
	return true
end

local states = {}

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.K then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

-- ÖZELLİKLER
addBtn("Combat", "Hızlı Aimbot (Sağ Tık)", function(v) states.Aim = v end)
addBtn("Combat", "Aimbot FOV Çemberi", function(v) states.Fov = v end)
addBtn("Combat", "Kill Aura (Otomatik Yakın Hasar)", function(v) states.KillAura = v end)
addBtn("Combat", "Hitbox Büyültücü (4x Kafa)", function(v) states.Hitbox = v end)
addBtn("Combat", "Target Info (Hedef Canı Göster)", function(v) states.TargetInfo = v end)

addBtn("Visuals", "ESP (Kutu Highlight)", function(v) states.Esp = v end)
addBtn("Visuals", "Fullbright (Aydınlatma)", function(v)
	Lighting.Brightness = v and 2 or 1
	Lighting.ClockTime = v and 14 or 12
end)
addBtn("Visuals", "Özel Crosshair (Yeşil)", function(v) states.Cross = v end)

local targetSpeed, targetJump = nil, nil
addBox("Player", "Hız Değeri Yazıp Enter'a Bas (Örn: 60)", function(val) targetSpeed = val end)
addBox("Player", "Zıplama Değeri Yazıp Enter'a Bas (Örn: 120)", function(val) targetJump = val end)

addBtn("Player", "Çalışan Ölümsüzlük (Godmode)", function(v) states.God = v end)
addBtn("Player", "Noclip (Duvarlardan Geçme)", function(v) states.Noclip = v end)
addBtn("Player", "Infinite Jump (Sınırsız Zıplama)", function(v) states.InfJump = v end)
addBtn("Player", "Anti-AFK (Atılma Önleyici)", function(v) states.AntiAfk = v end)

addBtn("Teleport", "Ctrl + Click ile İmlece Işınlan", function(v) states.TpMouse = v end)
addBtn("Teleport", "Rakibin Arkasına Işınlan", function(v)
	pcall(function()
		local targets = {}
		for _, p in ipairs(Players:GetPlayers()) do
			if isEnemy(p) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				table.insert(targets, p)
			end
		end
		if #targets > 0 then
			local t = targets[math.random(1, #targets)]
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
			end
		end
	end)
end)

addBox("Misc", "FOV Değeri Gir (Örn: 100)", function(val) Camera.FieldOfView = val end)

-- ==========================================================
-- ÇALIŞTIRICI DÖNGÜLER
-- ==========================================================
RunService.Stepped:Connect(function()
	pcall(function()
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			local hum = char.Humanoid
			if targetSpeed then hum.WalkSpeed = targetSpeed end
			if targetJump then
				hum.UseJumpPower = true
				hum.JumpPower = targetJump
			end
		end
		if states.Noclip and char then
			for _, v in ipairs(char:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide = false end
			end
		end
	end)
end)

RunService.RenderStepped:Connect(function()
	pcall(function()
		if states.God then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("Humanoid") then
				char.Humanoid.Health = char.Humanoid.MaxHealth
			end
		end
	end)
end)

RunService.RenderStepped:Connect(function()
	pcall(function()
		if states.KillAura then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				for _, p in ipairs(Players:GetPlayers()) do
					if isEnemy(p) and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character:FindFirstChild("HumanoidRootPart") then
						local hum = p.Character.Humanoid
						local dist = (char.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
						if dist < 16 and hum.Health > 0 then
							hum.Health = math.max(0, hum.Health - 2)
						end
					end
				end
			end
		end
	end)
end)

local function getClosestEnemy()
	local target, shortest = nil, 160
	for _, p in ipairs(Players:GetPlayers()) do
		if isEnemy(p) and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") then
			local head = p.Character.Head
			local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
			if onScreen then
				local dist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
				if dist < shortest then shortest = dist; target = p end
			end
		end
	end
	return target
end

RunService.RenderStepped:Connect(function()
	pcall(function()
		if states.TargetInfo then
			local t = getClosestEnemy()
			if t and t.Character and t.Character:FindFirstChild("Humanoid") then
				TargetInfoBox.Visible = true
				local hum = t.Character.Humanoid
				TargetNameLbl.Text = "Hedef: " .. t.Name .. " [" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "]"
				local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
				TargetHealthBar.Size = UDim2.new(ratio, 0, 1, 0)
			else
				TargetInfoBox.Visible = false
			end
		else
			TargetInfoBox.Visible = false
		end
	end)
end)

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Radius = 150
fovCircle.Color = Color3.fromRGB(0, 255, 128)
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Transparency = 0.7

RunService.RenderStepped:Connect(function()
	pcall(function()
		fovCircle.Position = UserInputService:GetMouseLocation()
		fovCircle.Visible = states.Fov or false
	end)
end)

RunService.RenderStepped:Connect(function()
	pcall(function()
		if states.Aim and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
			local t = getClosestEnemy()
			if t and t.Character and t.Character:FindFirstChild("Head") then
				Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.Head.Position)
			end
		end
	end)
end)

RunService.RenderStepped:Connect(function()
	pcall(function()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local enemy = isEnemy(p)
				if states.Esp then
					if not p.Character:FindFirstChild("SamesESP") then
						local hl = Instance.new("Highlight")
						hl.Name = "SamesESP"
						hl.FillColor = enemy and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(40, 255, 40)
						hl.FillTransparency = 0.4
						hl.Parent = p.Character
					end
				else
					local hl = p.Character:FindFirstChild("SamesESP")
					if hl then hl:Destroy() end
				end
				
				if states.Hitbox and enemy and p.Character:FindFirstChild("Head") then
					p.Character.Head.Size = Vector3.new(4, 4, 4)
					p.Character.Head.Transparency = 0.6
					p.Character.Head.CanCollide = false
				end
			end
		end
	end)
end)

UserInputService.JumpRequest:Connect(function()
	if states.InfJump then
		pcall(function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("Humanoid") then
				char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	pcall(function()
		if states.TpMouse and input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
			end
		end
	end)
end)

local crossGui
RunService.RenderStepped:Connect(function()
	pcall(function()
		if states.Cross and not crossGui then
			crossGui = Instance.new("Frame")
			crossGui.Size = UDim2.new(0, 6, 0, 6)
			crossGui.Position = UDim2.new(0.5, -3, 0.5, -3)
			crossGui.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
			crossGui.BorderSizePixel = 0
			crossGui.Parent = ScreenGui
		elseif not states.Cross and crossGui then
			crossGui:Destroy()
			crossGui = nil
		end
	end)
end)
