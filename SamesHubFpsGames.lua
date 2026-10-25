-- ==========================================================
-- SAMES HUB v2.4 - LOADING SCREEN & PLAYER INFO (TEK LOCAL SCRIPT)
-- ==========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Eski paneli temizle
if PlayerGui:FindFirstChild("SamesHubGui") then
	PlayerGui.SamesHubGui:Destroy()
end

-- ==========================================================
-- 1. LOADING EKRANI (AÇILIŞ ANİMASYONU)
-- ==========================================================
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "SamesLoadingGui"
LoadGui.ResetOnSpawn = false
LoadGui.Parent = PlayerGui

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 350, 0, 120)
LoadFrame.Position = UDim2.new(0.5, -175, 0.5, -60)
LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = LoadGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 10)
LoadCorner.Parent = LoadFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 40)
LoadTitle.Position = UDim2.new(0, 0, 0, 15)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "⚡ SAMES HUB Yükleniyor..."
LoadTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
LoadTitle.TextSize = 16
LoadTitle.Font = Enum.Font.Code
LoadTitle.Parent = LoadFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 310, 0, 12)
BarBg.Position = UDim2.new(0, 20, 0, 70)
BarBg.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
BarBg.BorderSizePixel = 0
BarBg.Parent = LoadFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 6)
BarBgCorner.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(0, 6)
BarFillCorner.Parent = BarFill

-- Dolum animasyonu
for i = 1, 100 do
	BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
	task.wait(0.01)
end
LoadGui:Destroy() -- Yükleme bitince ekranı sil

-- ==========================================================
-- DİL SÖZLÜĞÜ (TR / EN)
-- ==========================================================
local currentLang = "TR"
local langText = {
	TR = {
		HubTitle = "⚡ SAMES HUB v2.4 (TR/EN) — [K: Gizle/Göster]",
		Aim = "Hızlı Aimbot (Sağ Tık)",
		FovCircle = "Aimbot FOV Çemberi Göster",
		Hitbox = "Hitbox Büyültücü (Sadece Rakip)",
		NoRecoil = "Geri Tepmeme (No Recoil)",
		InfiniteAmmo = "Sınırsız Mermi",
		Esp = "ESP (Sadece Rakipler)",
		NameEsp = "Name & Distance ESP (Rakipler)",
		Bright = "Fullbright (Geceyi Aydınlat)",
		Cross = "Özel Crosshair",
		Wire = "Neon / Parlama Modu",
		God = "Ölümsüzlük (Godmode)",
		Fly = "Uçma (Fly)",
		Noclip = "Noclip (Duvarlardan Geçme)",
		InfJump = "Infinite Jump (Sınırsız Zıplama)",
		Bhop = "Bunny Hop (Oto Zıplama)",
		Invis = "Karakteri Gizle (Invis)",
		SpeedBox = "Hız Değeri Yazıp Enter'a Bas",
		JumpBox = "Zıplama Değeri Yazıp Enter'a Bas",
		TpMouse = "Ctrl + Click ile İmlece Işınlan",
		TpPlayer = "Rastgele Rakibe Işınlan",
		FovBox = "FOV (Görüş Açısı) Değeri Gir",
		TpCam = "Third Person (3. Şahıs Görüşü)",
		Fcam = "Freecam (Serbest Kamera)",
		LangBtn = "🌍 Dil Değiştir: Türkçe (TR)"
	},
	EN = {
		HubTitle = "⚡ SAMES HUB v2.4 (TR/EN) — [K: Toggle]",
		Aim = "Fast Aimbot (R-Click)",
		FovCircle = "Show Aimbot FOV Circle",
		Hitbox = "Hitbox Expander (Enemy Only)",
		NoRecoil = "No Recoil",
		InfiniteAmmo = "Infinite Ammo",
		Esp = "ESP (Enemies Only)",
		NameEsp = "Name & Distance ESP (Enemies)",
		Bright = "Fullbright (Lighting)",
		Cross = "Custom Crosshair",
		Wire = "Neon / Glow Mode",
		God = "Godmode",
		Fly = "Fly",
		Noclip = "Noclip",
		InfJump = "Infinite Jump",
		Bhop = "Bunny Hop",
		Invis = "Invisibility",
		SpeedBox = "Type Speed & Press Enter",
		JumpBox = "Type Jump & Press Enter",
		TpMouse = "Ctrl + Click Teleport",
		TpPlayer = "Teleport to Random Enemy",
		FovBox = "Type FOV Value",
		TpCam = "Third Person Camera",
		Fcam = "Freecam",
		LangBtn = "🌍 Change Language: English (EN)"
	}
}

-- ScreenGui (Ana Panel)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SamesHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ==========================================================
-- 2. PLAYER INFO (SOL ÜST KÖŞE OYUNCU BİLGİSİ)
-- ==========================================================
local InfoBox = Instance.new("Frame")
InfoBox.Size = UDim2.new(0, 200, 0, 55)
InfoBox.Position = UDim2.new(0, 15, 0, 15)
InfoBox.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
InfoBox.BorderSizePixel = 0
InfoBox.Parent = ScreenGui

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoBox

local PlayerNameLbl = Instance.new("TextLabel")
PlayerNameLbl.Size = UDim2.new(1, -10, 0, 25)
PlayerNameLbl.Position = UDim2.new(0, 10, 0, 5)
PlayerNameLbl.BackgroundTransparency = 1
PlayerNameLbl.Text = "👤 " .. LocalPlayer.Name
PlayerNameLbl.TextColor3 = Color3.fromRGB(0, 255, 128)
PlayerNameLbl.TextSize = 13
PlayerNameLbl.Font = Enum.Font.Code
PlayerNameLbl.TextXAlignment = Enum.TextXAlignment.Left
PlayerNameLbl.Parent = InfoBox

local PingLbl = Instance.new("TextLabel")
PingLbl.Size = UDim2.new(1, -10, 0, 20)
PingLbl.Position = UDim2.new(0, 10, 0, 28)
PingLbl.BackgroundTransparency = 1
PingLbl.Text = "📡 Ping: Hesaplanıyor..."
PingLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
PingLbl.TextSize = 11
PingLbl.Font = Enum.Font.Code
PingLbl.TextXAlignment = Enum.TextXAlignment.Left
PingLbl.Parent = InfoBox

-- Ping Güncelleyici
RunService.RenderStepped:Connect(function()
	local pings = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
	PingLbl.Text = "📡 Ping: " .. math.floor(pings) .. " ms"
end)

-- ==========================================================
-- ANA PENCERE (MAIN FRAME)
-- ==========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
MainFrame.BorderSizePixel = 0
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Üst Başlık
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = langText[currentLang].HubTitle
Title.TextColor3 = Color3.fromRGB(0, 255, 128)
Title.TextSize = 13
Title.Font = Enum.Font.Code
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Sol Kategori Menüsü
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 130, 1, -45)
TabContainer.Position = UDim2.new(0, 5, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

-- Sağ İçerik Alanı
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -145, 1, -45)
ContentContainer.Position = UDim2.new(0, 140, 0, 40)
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
	scroll.CanvasSize = UDim2.new(0, 0, 0, 550)
	scroll.ScrollBarThickness = 4
	scroll.Visible = (i == 1)
	scroll.Parent = ContentContainer
	pages[catName] = scroll

	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(1, -10, 0, 32)
	tabBtn.Position = UDim2.new(0, 5, 0, (i - 1) * 36 + 5)
	tabBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(35, 40, 55) or Color3.fromRGB(24, 28, 38)
	tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabBtn.Text = catName
	tabBtn.TextSize = 12
	tabBtn.Font = Enum.Font.Code
	tabBtn.Parent = TabContainer
	tabButtons[catName] = tabBtn

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 5)
	btnCorner.Parent = tabBtn

	tabBtn.MouseButton1Click:Connect(function()
		for name, page in pairs(pages) do
			page.Visible = (name == catName)
		end
		for _, b in pairs(tabButtons) do
			b.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
		end
		tabBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
	end)
end

local yPosMap = {Combat = 10, Visuals = 10, Player = 10, Teleport = 10, Misc = 10}

local function addFeatureBtn(category, key, textKey)
	local scroll = pages[category]
	local btn = Instance.new("TextButton")
	btn.Name = key
	btn.Size = UDim2.new(0, 350, 0, 32)
	btn.Position = UDim2.new(0, 5, 0, yPosMap[category])
	btn.BackgroundColor3 = Color3.fromRGB(28, 33, 45)
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.Text = langText[currentLang][textKey] .. " [ OFF ]"
	btn.TextSize = 12
	btn.Font = Enum.Font.Code
	btn.Parent = scroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = btn
	yPosMap[category] = yPosMap[category] + 38
	return btn
end

local function addFeatureBox(category, key, placeholderKey)
	local scroll = pages[category]
	local box = Instance.new("TextBox")
	box.Name = key
	box.Size = UDim2.new(0, 350, 0, 32)
	box.Position = UDim2.new(0, 5, 0, yPosMap[category])
	box.BackgroundColor3 = Color3.fromRGB(22, 26, 35)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.PlaceholderText = langText[currentLang][placeholderKey]
	box.PlaceholderColor3 = Color3.fromRGB(100, 110, 130)
	box.Text = ""
	box.TextSize = 12
	box.Font = Enum.Font.Code
	box.Parent = scroll

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = box
	yPosMap[category] = yPosMap[category] + 38
	return box
end

-- Butonlar
local AimBtn = addFeatureBtn("Combat", "Aim", "Aim")
local FovCircleBtn = addFeatureBtn("Combat", "FovCircle", "FovCircle")
local HitboxBtn = addFeatureBtn("Combat", "Hitbox", "Hitbox")
local NoRecoilBtn = addFeatureBtn("Combat", "NoRecoil", "NoRecoil")
local InfiniteAmmoBtn = addFeatureBtn("Combat", "InfiniteAmmo", "InfiniteAmmo")

local EspBtn = addFeatureBtn("Visuals", "Esp", "Esp")
local NameEspBtn = addFeatureBtn("Visuals", "NameEsp", "NameEsp")
local BrightBtn = addFeatureBtn("Visuals", "Bright", "Bright")
local CrossBtn = addFeatureBtn("Visuals", "Cross", "Cross")
local WireBtn = addFeatureBtn("Visuals", "Wire", "Wire")

local GodBtn = addFeatureBtn("Player", "God", "God")
local FlyBtn = addFeatureBtn("Player", "Fly", "Fly")
local NoclipBtn = addFeatureBtn("Player", "Noclip", "Noclip")
local InfJumpBtn = addFeatureBtn("Player", "InfJump", "InfJump")
local BhopBtn = addFeatureBtn("Player", "Bhop", "Bhop")
local InvisBtn = addFeatureBtn("Player", "Invis", "Invis")
local SpeedBox = addFeatureBox("Player", "SpeedBox", "SpeedBox")
local JumpBox = addFeatureBox("Player", "JumpBox", "JumpBox")

local TpMouseBtn = addFeatureBtn("Teleport", "TpMouse", "TpMouse")
local TpPlayerBtn = addFeatureBtn("Teleport", "TpPlayer", "TpPlayer")

local FovBox = addFeatureBox("Misc", "FovBox", "FovBox")
local TpCamBtn = addFeatureBtn("Misc", "TpCam", "TpCam")
local FcamBtn = addFeatureBtn("Misc", "Fcam", "Fcam")
local LangToggleBtn = addFeatureBtn("Misc", "LangToggle", "LangBtn")

-- Dil Değiştirme
LangToggleBtn.MouseButton1Click:Connect(function()
	currentLang = (currentLang == "TR") and "EN" or "TR"
	Title.Text = langText[currentLang].HubTitle
	AimBtn.Text = langText[currentLang].Aim .. " [ ... ]"
	FovCircleBtn.Text = langText[currentLang].FovCircle .. " [ ... ]"
	HitboxBtn.Text = langText[currentLang].Hitbox .. " [ ... ]"
	EspBtn.Text = langText[currentLang].Esp .. " [ ... ]"
	NameEspBtn.Text = langText[currentLang].NameEsp .. " [ ... ]"
	GodBtn.Text = langText[currentLang].God .. " [ ... ]"
	FlyBtn.Text = langText[currentLang].Fly .. " [ ... ]"
	LangToggleBtn.Text = langText[currentLang].LangBtn
	SpeedBox.PlaceholderText = langText[currentLang].SpeedBox
	JumpBox.PlaceholderText = langText[currentLang].JumpBox
	FovBox.PlaceholderText = langText[currentLang].FovBox
end)

-- Takım / Düşman Kontrolü
local function isEnemy(player)
	if player == LocalPlayer then return false end
	if LocalPlayer.Team and player.Team then
		return player.Team ~= LocalPlayer.Team
	end
	return true
end

local states_active = {}
local targetSpeed, targetJump = nil, nil

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.K then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

RunService.Stepped:Connect(function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		local hum = char.Humanoid
		if targetSpeed then hum.WalkSpeed = targetSpeed end
		if targetJump then
			hum.UseJumpPower = true
			hum.JumpPower = targetJump
			hum.JumpHeight = targetJump / 3.5
		end
	end
end)

SpeedBox.FocusLost:Connect(function() targetSpeed = tonumber(SpeedBox.Text) end)
JumpBox.FocusLost:Connect(function() targetJump = tonumber(JumpBox.Text) end)

-- Aimbot FOV & Kilitleme
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Radius = 150
fovCircle.Color = Color3.fromRGB(0, 255, 128)
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Transparency = 0.7

RunService.RenderStepped:Connect(function()
	fovCircle.Position = UserInputService:GetMouseLocation()
end)

FovCircleBtn.MouseButton1Click:Connect(function()
	states_active.FovCircle = not states_active.FovCircle
	fovCircle.Visible = states_active.FovCircle
end)

local function getClosestEnemy()
	local target, shortest = nil, 150
	for _, p in ipairs(Players:GetPlayers()) do
		if isEnemy(p) and p.Character and p.Character:FindFirstChild("Head") then
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

AimBtn.MouseButton1Click:Connect(function() states_active.Aim = not states_active.Aim end)
RunService.RenderStepped:Connect(function()
	if states_active.Aim and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		local t = getClosestEnemy()
		if t and t.Character and t.Character:FindFirstChild("Head") then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.Head.Position)
		end
	end
end)

-- ESP
local function updateESP()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			local enemy = isEnemy(p)
			if states_active.Esp then
				if not p.Character:FindFirstChild("HubESP") then
					local hl = Instance.new("Highlight")
					hl.Name = "HubESP"
					hl.FillColor = enemy and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
					hl.FillTransparency = 0.4
					hl.Parent = p.Character
				end
			else
				local hl = p.Character:FindFirstChild("HubESP")
				if hl then hl:Destroy() end
			end
		end
	end
end

EspBtn.MouseButton1Click:Connect(function() states_active.Esp = not states_active.Esp end)
RunService.RenderStepped:Connect(function() if states_active.Esp then updateESP() end end)

-- Godmode
local godConn
GodBtn.MouseButton1Click:Connect(function()
	states_active.God = not states_active.God
	if states_active.God then
		godConn = RunService.RenderStepped:Connect(function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = char.Humanoid.MaxHealth end
		end)
	else
		if godConn then godConn:Disconnect() end
	end
end)

-- Noclip
RunService.Stepped:Connect(function()
	if states_active.Noclip then
		local char = LocalPlayer.Character
		if char then for _, v in ipairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
	end
end)
NoclipBtn.MouseButton1Click:Connect(function() states_active.Noclip = not states_active.Noclip end)

-- Teleport (Ctrl + Click)
UserInputService.InputBegan:Connect(function(input, gp)
	if states_active.TpMouse and input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootRootPart") or char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
		end
	end
end)
TpMouseBtn.MouseButton1Click:Connect(function() states_active.TpMouse = not states_active.TpMouse end)

FovBox.FocusLost:Connect(function() local fov = tonumber(FovBox.Text); if fov then Camera.FieldOfView = fov end end)
