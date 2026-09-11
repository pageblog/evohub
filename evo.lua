--========================================================--
--                  EVO PRIVATE ACCESS
--========================================================--

do
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local SoundService = game:GetService("SoundService")

	local LocalPlayer = Players.LocalPlayer
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

	--====================================================--
	-- PASSWORD
	--====================================================--

	-- DJB2 hash da senha.
	-- A senha em texto puro nao fica armazenada aqui.
	local PASSWORD_HASH = 726903388

	local function HashPassword(Text)
		local Hash = 5381

		for I = 1, #Text do
			Hash = (
				Hash * 33
				+ string.byte(Text, I)
			) % 4294967296
		end

		return Hash
	end

	--====================================================--
	-- COLORS
	--====================================================--

	local Accent = Color3.fromRGB(255, 175, 220)
	local AccentHover = Color3.fromRGB(255, 197, 231)
	local Panel = Color3.fromRGB(9, 9, 11)
	local Input = Color3.fromRGB(15, 15, 18)
	local Muted = Color3.fromRGB(105, 105, 115)
	local Success = Color3.fromRGB(95, 255, 145)
	local ErrorColor = Color3.fromRGB(255, 85, 105)

	--====================================================--
	-- SOUNDS
	--====================================================--

	local function NewSound(Name, SoundId, Volume, PlaybackSpeed)
		local Sound = Instance.new("Sound")
		Sound.Name = Name
		Sound.SoundId = SoundId
		Sound.Volume = Volume
		Sound.PlaybackSpeed = PlaybackSpeed or 1
		Sound.Parent = SoundService
		return Sound
	end

	-- Volumes propositalmente baixos.
	local HoverSound = NewSound(
		"EVO_LoginHover",
		"rbxassetid://6895079853",
		0.045,
		1.18
	)

	local ClickSound = NewSound(
		"EVO_LoginClick",
		"rbxassetid://6895079853",
		0.075,
		0.98
	)

	local SuccessSound = NewSound(
		"EVO_LoginSuccess",
		"rbxassetid://6895079853",
		0.085,
		1.35
	)

	local ErrorSound = NewSound(
		"EVO_LoginError",
		"rbxassetid://6895079853",
		0.06,
		0.72
	)

	local function PlaySound(Sound)
		if not Sound then
			return
		end

		pcall(function()
			Sound.TimePosition = 0
			Sound:Play()
		end)
	end

	--====================================================--
	-- REMOVE OLD LOGIN
	--====================================================--

	local OldGUI = PlayerGui:FindFirstChild("EVO_PRIVATE_ACCESS")

	if OldGUI then
		OldGUI:Destroy()
	end

	--====================================================--
	-- ACCESS EVENT
	--====================================================--

	local AccessGranted = Instance.new("BindableEvent")

	--====================================================--
	-- GUI
	--====================================================--

	local GUI = Instance.new("ScreenGui")
	GUI.Name = "EVO_PRIVATE_ACCESS"
	GUI.ResetOnSpawn = false
	GUI.IgnoreGuiInset = true
	GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	GUI.DisplayOrder = 999999
	GUI.Parent = PlayerGui

	local Background = Instance.new("Frame")
	Background.Size = UDim2.fromScale(1, 1)
	Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Background.BackgroundTransparency = 0.28
	Background.BorderSizePixel = 0
	Background.Parent = GUI

	local Main = Instance.new("Frame")
	Main.Size = UDim2.fromOffset(390, 240)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Position = UDim2.fromScale(0.5, 0.5)
	Main.BackgroundColor3 = Panel
	Main.BorderSizePixel = 0
	Main.Parent = Background

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(42, 42, 47)
	MainStroke.Thickness = 1
	MainStroke.Parent = Main

	local AccentLine = Instance.new("Frame")
	AccentLine.Size = UDim2.new(1, 0, 0, 2)
	AccentLine.BackgroundColor3 = Accent
	AccentLine.BorderSizePixel = 0
	AccentLine.Parent = Main

	local Logo = Instance.new("TextLabel")
	Logo.Size = UDim2.new(1, -28, 0, 30)
	Logo.Position = UDim2.fromOffset(14, 17)
	Logo.BackgroundTransparency = 1
	Logo.Text = "EVO"
	Logo.TextColor3 = Accent
	Logo.Font = Enum.Font.Code
	Logo.TextSize = 18
	Logo.TextXAlignment = Enum.TextXAlignment.Left
	Logo.Parent = Main

	local Build = Instance.new("TextLabel")
	Build.Size = UDim2.new(1, -28, 0, 18)
	Build.Position = UDim2.fromOffset(14, 43)
	Build.BackgroundTransparency = 1
	Build.Text = "<3 evo  |  private access"
	Build.TextColor3 = Muted
	Build.Font = Enum.Font.Code
	Build.TextSize = 8
	Build.TextXAlignment = Enum.TextXAlignment.Left
	Build.Parent = Main

	local Divider = Instance.new("Frame")
	Divider.Size = UDim2.new(1, -28, 0, 1)
	Divider.Position = UDim2.fromOffset(14, 69)
	Divider.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
	Divider.BorderSizePixel = 0
	Divider.Parent = Main

	local KeyLabel = Instance.new("TextLabel")
	KeyLabel.Size = UDim2.new(1, -28, 0, 17)
	KeyLabel.Position = UDim2.fromOffset(14, 79)
	KeyLabel.BackgroundTransparency = 1
	KeyLabel.Text = "ACCESS KEY"
	KeyLabel.TextColor3 = Color3.fromRGB(135, 135, 145)
	KeyLabel.Font = Enum.Font.Code
	KeyLabel.TextSize = 8
	KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
	KeyLabel.Parent = Main

	local PasswordHolder = Instance.new("Frame")
	PasswordHolder.Size = UDim2.new(1, -28, 0, 38)
	PasswordHolder.Position = UDim2.fromOffset(14, 100)
	PasswordHolder.BackgroundColor3 = Input
	PasswordHolder.BorderSizePixel = 0
	PasswordHolder.Parent = Main

	local PasswordStroke = Instance.new("UIStroke")
	PasswordStroke.Color = Color3.fromRGB(38, 38, 42)
	PasswordStroke.Thickness = 1
	PasswordStroke.Parent = PasswordHolder

	local PasswordBox = Instance.new("TextBox")
	PasswordBox.Size = UDim2.new(1, -20, 1, 0)
	PasswordBox.Position = UDim2.fromOffset(10, 0)
	PasswordBox.BackgroundTransparency = 1
	PasswordBox.ClearTextOnFocus = false
	PasswordBox.PlaceholderText = "Enter your access key..."
	PasswordBox.PlaceholderColor3 = Color3.fromRGB(75, 75, 85)
	PasswordBox.Text = ""
	PasswordBox.TextColor3 = Color3.fromRGB(235, 235, 240)
	PasswordBox.Font = Enum.Font.Code
	PasswordBox.TextSize = 10
	PasswordBox.TextXAlignment = Enum.TextXAlignment.Left
	PasswordBox.Parent = PasswordHolder

	local Status = Instance.new("TextLabel")
	Status.Size = UDim2.new(1, -28, 0, 16)
	Status.Position = UDim2.fromOffset(14, 144)
	Status.BackgroundTransparency = 1
	Status.Text = "authentication required"
	Status.TextColor3 = Color3.fromRGB(85, 85, 95)
	Status.Font = Enum.Font.Code
	Status.TextSize = 8
	Status.TextXAlignment = Enum.TextXAlignment.Left
	Status.Parent = Main

	local Login = Instance.new("TextButton")
	Login.Size = UDim2.new(1, -28, 0, 36)
	Login.Position = UDim2.fromOffset(14, 178)
	Login.BackgroundColor3 = Accent
	Login.BorderSizePixel = 0
	Login.Text = "AUTHENTICATE"
	Login.TextColor3 = Color3.fromRGB(12, 10, 12)
	Login.Font = Enum.Font.Code
	Login.TextSize = 9
	Login.AutoButtonColor = false
	Login.Parent = Main

	--====================================================--
	-- MICRO INTERACTIONS
	--====================================================--

	PasswordBox.Focused:Connect(function()
		PlaySound(HoverSound)

		TweenService:Create(
			PasswordStroke,
			TweenInfo.new(0.12),
			{ Color = Accent }
		):Play()
	end)

	Login.MouseEnter:Connect(function()
		PlaySound(HoverSound)

		TweenService:Create(
			Login,
			TweenInfo.new(0.12),
			{ BackgroundColor3 = AccentHover }
		):Play()
	end)

	Login.MouseLeave:Connect(function()
		TweenService:Create(
			Login,
			TweenInfo.new(0.12),
			{ BackgroundColor3 = Accent }
		):Play()
	end)

	Login.MouseButton1Down:Connect(function()
		PlaySound(ClickSound)

		TweenService:Create(
			Login,
			TweenInfo.new(0.06),
			{
				Size = UDim2.new(1, -32, 0, 34),
				Position = UDim2.fromOffset(16, 179)
			}
		):Play()
	end)

	Login.MouseButton1Up:Connect(function()
		TweenService:Create(
			Login,
			TweenInfo.new(0.08),
			{
				Size = UDim2.new(1, -28, 0, 36),
				Position = UDim2.fromOffset(14, 178)
			}
		):Play()
	end)

	--====================================================--
	-- SHAKE / STATUS
	--====================================================--

	local Shaking = false

	local function Shake()
		if Shaking then
			return
		end

		Shaking = true

		local Original = Main.Position
		local Offsets = {-7, 7, -5, 5, -3, 3, 0}

		for _, X in ipairs(Offsets) do
			Main.Position = Original + UDim2.fromOffset(X, 0)
			task.wait(0.024)
		end

		Main.Position = Original
		Shaking = false
	end

	local function WrongKey()
		PlaySound(ErrorSound)

		Status.Text = "invalid access key"
		Status.TextColor3 = ErrorColor
		PasswordStroke.Color = ErrorColor

		task.spawn(Shake)

		task.delay(1.1, function()
			if GUI.Parent then
				Status.Text = "authentication required"
				Status.TextColor3 = Color3.fromRGB(85, 85, 95)
				PasswordStroke.Color = Color3.fromRGB(38, 38, 42)
			end
		end)
	end

	--====================================================--
	-- AUTHENTICATE
	--====================================================--

	local Authenticated = false

	local function Authenticate()
		if Authenticated then
			return
		end

		local EnteredHash = HashPassword(PasswordBox.Text)

		if EnteredHash ~= PASSWORD_HASH then
			WrongKey()
			return
		end

		Authenticated = true
		PlaySound(SuccessSound)

		PasswordBox.TextEditable = false
		Login.Active = false
		Login.Text = "ACCESS GRANTED"

		Status.Text = "authentication successful"
		Status.TextColor3 = Success

		PasswordStroke.Color = Success
		MainStroke.Color = Success

		task.wait(0.3)

		Status.Text = "initializing evo..."
		Login.Text = "LOADING EVO"

		task.wait(0.35)

		AccessGranted:Fire()
	end

	Login.MouseButton1Click:Connect(Authenticate)

	PasswordBox.FocusLost:Connect(function(EnterPressed)
		if EnterPressed then
			PlaySound(ClickSound)
			Authenticate()
		elseif not Authenticated then
			PasswordStroke.Color = Color3.fromRGB(38, 38, 42)
		end
	end)

	task.delay(0.2, function()
		if PasswordBox.Parent then
			PasswordBox:CaptureFocus()
		end
	end)

	-- O restante do EVO nao executa antes da autenticacao.
	AccessGranted.Event:Wait()

	TweenService:Create(
		Background,
		TweenInfo.new(0.18),
		{ BackgroundTransparency = 1 }
	):Play()

	TweenService:Create(
		Main,
		TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
		{ Size = UDim2.fromOffset(390, 0) }
	):Play()

	task.wait(0.2)

	GUI:Destroy()
	AccessGranted:Destroy()

	for _, Sound in ipairs({
		HoverSound,
		ClickSound,
		SuccessSound,
		ErrorSound
	}) do
		if Sound then
			Sound:Destroy()
		end
	end
end


--========================================================--
--                       EVO HUB V7.4
--                Roblox Studio Testing UI
--========================================================--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================================--
-- CONFIG
--========================================================--

local Config = {

	-- AIM
	Aimbot = false,
	TeamCheck = true,
	WallCheck = true,
	Prediction = true,

	AimPart = "Head",
	AimKey = Enum.KeyCode.E,

	FOV = 180,
	Smoothness = 0.18,
	PredictionAmount = 0.08,
	MaxDistance = 2500,

	FOVCircle = true,

	-- ESP
	ESP = false,
	BoxESP = true,
	FillBox = false,

	NameESP = true,
	DistanceESP = true,

	HealthBar = true,
	HealthText = false,

	Tracer = false,
	Chams = false,
	HeadDot = false,

	-- CROSSHAIR
	Crosshair = true,
	CrosshairStyle = "Cross",

	CrosshairSize = 8,
	CrosshairGap = 4,

	CrosshairAnimation = false,
	CrosshairAnimationType = "Spin",
	CrosshairAnimationSpeed = 90,

	-- MOVEMENT
	Fly = false,
	FlySpeed = 65,

	-- UI
	Snow = true,

	AccentR = 255,
	AccentG = 175,
	AccentB = 220,

	MenuKey = Enum.KeyCode.RightShift
}

--========================================================--
-- STATE
--========================================================--

local AimHeld = false
local WaitingAimBind = false

local CurrentTarget = nil

local SelectedPlayer = nil
local ViewingPlayer = nil

local CrosshairAnimationTime = 0

--========================================================--
-- COLORS
--========================================================--

local function Accent()

	return Color3.fromRGB(
		Config.AccentR,
		Config.AccentG,
		Config.AccentB
	)

end

local Colors = {

	Background = Color3.fromRGB(8,8,9),

	Panel = Color3.fromRGB(13,13,14),
	Panel2 = Color3.fromRGB(18,18,19),
	Panel3 = Color3.fromRGB(22,22,24),

	Stroke = Color3.fromRGB(34,34,37),

	Text = Color3.fromRGB(235,235,238),
	Sub = Color3.fromRGB(120,120,128),

	Disabled = Color3.fromRGB(47,47,50),

	Health = Color3.fromRGB(70,255,100),

	Danger = Color3.fromRGB(220,75,90)
}

--========================================================--
-- GUI
--========================================================--

local GUI = Instance.new("ScreenGui")

GUI.Name = "EVO_V7_4"

GUI.ResetOnSpawn = false

GUI.IgnoreGuiInset = true

GUI.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

GUI.Parent =
	LocalPlayer:WaitForChild(
		"PlayerGui"
	)


--========================================================--
-- UI SOUNDS
--========================================================--

local SoundService =
	game:GetService("SoundService")

local UIClickSound =
	Instance.new("Sound")

UIClickSound.Name =
	"EVO_UIClick"

UIClickSound.SoundId =
	"rbxassetid://6895079853"

UIClickSound.Volume =
	0.055

UIClickSound.PlaybackSpeed =
	1

UIClickSound.Parent =
	SoundService

local UIHoverSound =
	Instance.new("Sound")

UIHoverSound.Name =
	"EVO_UIHover"

UIHoverSound.SoundId =
	"rbxassetid://6895079853"

UIHoverSound.Volume =
	0.025

UIHoverSound.PlaybackSpeed =
	1.16

UIHoverSound.Parent =
	SoundService

local function PlayUISound(Sound)

	if not Sound then
		return
	end

	pcall(function()

		Sound.TimePosition =
			0

		Sound:Play()

	end)

end

local function HookUIButton(Object)

	if not Object:IsA("GuiButton") then
		return
	end

	if Object:GetAttribute(
		"EVO_SOUND_HOOKED"
	) then
		return
	end

	Object:SetAttribute(
		"EVO_SOUND_HOOKED",
		true
	)

	Object.MouseEnter:Connect(function()

		PlayUISound(
			UIHoverSound
		)

	end)

	Object.MouseButton1Click:Connect(function()

		PlayUISound(
			UIClickSound
		)

	end)

end

for _, Object in ipairs(
	GUI:GetDescendants()
) do

	HookUIButton(
		Object
	)

end

GUI.DescendantAdded:Connect(function(
	Object
)

	task.defer(function()

		if Object.Parent then

			HookUIButton(
				Object
			)

		end

	end)

end)

--========================================================--
-- MAIN
--========================================================--

local Main =
	Instance.new("Frame")

Main.Size =
	UDim2.fromOffset(
		620,
		540
	)

Main.Position =
	UDim2.new(
		0.5,
		-310,
		0.5,
		-270
	)

Main.BackgroundColor3 =
	Colors.Background

Main.BorderSizePixel =
	0

Main.Parent =
	GUI

local MainStroke =
	Instance.new("UIStroke")

MainStroke.Color =
	Colors.Stroke

MainStroke.Thickness =
	1

MainStroke.Parent =
	Main

--========================================================--
-- TOPBAR
--========================================================--

local Topbar =
	Instance.new("Frame")

Topbar.Size =
	UDim2.new(
		1,
		0,
		0,
		54
	)

Topbar.BackgroundColor3 =
	Colors.Panel

Topbar.BorderSizePixel =
	0

Topbar.ZIndex =
	20

Topbar.Parent =
	Main

local Logo =
	Instance.new("TextLabel")

Logo.Size =
	UDim2.fromOffset(
		85,
		22
	)

Logo.Position =
	UDim2.fromOffset(
		11,
		5
	)

Logo.BackgroundTransparency =
	1

Logo.Text =
	"EVO"

Logo.TextColor3 =
	Accent()

Logo.Font =
	Enum.Font.Code

Logo.TextSize =
	15

Logo.TextXAlignment =
	Enum.TextXAlignment.Left

Logo.ZIndex =
	22

Logo.Parent =
	Topbar

local Build =
	Instance.new("TextLabel")

Build.Size =
	UDim2.fromOffset(
		120,
		16
	)

Build.Position =
	UDim2.fromOffset(
		11,
		27
	)

Build.BackgroundTransparency =
	1

Build.Text =
	"<3 evo  |  v7.4"

Build.TextColor3 =
	Colors.Sub

Build.Font =
	Enum.Font.Code

Build.TextSize =
	8

Build.TextXAlignment =
	Enum.TextXAlignment.Left

Build.ZIndex =
	22

Build.Parent =
	Topbar

--========================================================--
-- TABS
--========================================================--

local TabHolder =
	Instance.new("Frame")

TabHolder.Size =
	UDim2.new(
		1,
		-105,
		0,
		34
	)

TabHolder.Position =
	UDim2.fromOffset(
		100,
		10
	)

TabHolder.BackgroundTransparency =
	1

TabHolder.ZIndex =
	22

TabHolder.Parent =
	Topbar

local TabLayout =
	Instance.new("UIListLayout")

TabLayout.FillDirection =
	Enum.FillDirection.Horizontal

TabLayout.Padding =
	UDim.new(
		0,
		3
	)

TabLayout.Parent =
	TabHolder

local Pages = {}
local TabButtons = {}

local function CreatePage(Name)

	local Page =
		Instance.new("Frame")

	Page.Name =
		Name

	Page.Size =
		UDim2.new(
			1,
			-16,
			1,
			-64
		)

	Page.Position =
		UDim2.fromOffset(
			8,
			59
		)

	Page.BackgroundTransparency =
		1

	Page.Visible =
		false

	Page.Parent =
		Main

	Pages[Name] =
		Page

	return Page

end

local AimingPage =
	CreatePage("Aiming")

local VisualsPage =
	CreatePage("Visuals")

local CharacterPage =
	CreatePage("Character")

local PlayersPage =
	CreatePage("Players")

local OptionsPage =
	CreatePage("Options")

local function SelectTab(Name)

	for PageName, Page in pairs(
		Pages
	) do

		Page.Visible =
			PageName == Name

	end

	for TabName, Button in pairs(
		TabButtons
	) do

		if TabName == Name then

			Button.TextColor3 =
				Accent()

		else

			Button.TextColor3 =
				Colors.Sub

		end

	end

end

local function CreateTab(Name)

	local Button =
		Instance.new("TextButton")

	Button.Size =
		UDim2.fromOffset(
			94,
			28
		)

	Button.BackgroundTransparency =
		1

	Button.Text =
		Name

	Button.TextColor3 =
		Colors.Sub

	Button.Font =
		Enum.Font.Code

	Button.TextSize =
		9

	Button.AutoButtonColor =
		false

	Button.ZIndex =
		23

	Button.Parent =
		TabHolder

	Button.MouseButton1Click:Connect(function()

		SelectTab(
			Name
		)

	end)

	TabButtons[Name] =
		Button

end

CreateTab("Aiming")
CreateTab("Visuals")
CreateTab("Character")
CreateTab("Players")
CreateTab("Options")

SelectTab("Aiming")

--========================================================--
-- COLUMNS
--========================================================--

local function CreateColumns(Page)

	local Left =
		Instance.new("ScrollingFrame")

	local Right =
		Instance.new("ScrollingFrame")

	for _, Column in ipairs({
		Left,
		Right
	}) do

		Column.Size =
			UDim2.new(
				0.5,
				-4,
				1,
				0
			)

		Column.BackgroundTransparency =
			1

		Column.BorderSizePixel =
			0

		Column.ScrollBarThickness =
			2

		Column.ScrollBarImageColor3 =
			Accent()

		Column.AutomaticCanvasSize =
			Enum.AutomaticSize.Y

		Column.CanvasSize =
			UDim2.new()

		Column.Parent =
			Page

		local Layout =
			Instance.new(
				"UIListLayout"
			)

		Layout.Padding =
			UDim.new(
				0,
				5
			)

		Layout.Parent =
			Column

		local Padding =
			Instance.new(
				"UIPadding"
			)

		Padding.PaddingBottom =
			UDim.new(
				0,
				10
			)

		Padding.Parent =
			Column

	end

	Right.Position =
		UDim2.new(
			0.5,
			4,
			0,
			0
		)

	return Left, Right

end

local AimLeft, AimRight =
	CreateColumns(
		AimingPage
	)

local VisualLeft, VisualRight =
	CreateColumns(
		VisualsPage
	)

local CharLeft, CharRight =
	CreateColumns(
		CharacterPage
	)

local PlayerLeft, PlayerRight =
	CreateColumns(
		PlayersPage
	)

local OptionLeft, OptionRight =
	CreateColumns(
		OptionsPage
	)

--========================================================--
-- THEME REFRESHERS
--========================================================--

local ThemeRefreshers = {}

--========================================================--
-- SECTION
--========================================================--

local function Section(
	Parent,
	Text
)

	local Frame =
		Instance.new("Frame")

	Frame.Size =
		UDim2.new(
			1,
			0,
			0,
			27
		)

	Frame.BackgroundColor3 =
		Colors.Panel2

	Frame.BorderSizePixel =
		0

	Frame.Parent =
		Parent

	local Stroke =
		Instance.new("UIStroke")

	Stroke.Color =
		Colors.Stroke

	Stroke.Thickness =
		1

	Stroke.Parent =
		Frame

	local Label =
		Instance.new("TextLabel")

	Label.Size =
		UDim2.new(
			1,
			-12,
			1,
			0
		)

	Label.Position =
		UDim2.fromOffset(
			7,
			0
		)

	Label.BackgroundTransparency =
		1

	Label.Text =
		Text

	Label.TextColor3 =
		Colors.Text

	Label.Font =
		Enum.Font.Code

	Label.TextSize =
		9

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Frame

end

--========================================================--
-- TOGGLE
--========================================================--

local function Toggle(
	Parent,
	Text,
	ConfigName
)

	local Row =
		Instance.new("Frame")

	Row.Size =
		UDim2.new(
			1,
			0,
			0,
			29
		)

	Row.BackgroundColor3 =
		Colors.Panel

	Row.BorderSizePixel =
		0

	Row.Parent =
		Parent

	local Label =
		Instance.new(
			"TextLabel"
		)

	Label.Size =
		UDim2.new(
			1,
			-42,
			1,
			0
		)

	Label.Position =
		UDim2.fromOffset(
			7,
			0
		)

	Label.BackgroundTransparency =
		1

	Label.Text =
		Text

	Label.TextColor3 =
		Colors.Text

	Label.Font =
		Enum.Font.Code

	Label.TextSize =
		9

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Row

	local Button =
		Instance.new(
			"TextButton"
		)

	Button.Size =
		UDim2.fromOffset(
			12,
			12
		)

	Button.Position =
		UDim2.new(
			1,
			-20,
			0.5,
			-6
		)

	Button.BorderSizePixel =
		0

	Button.Text =
		""

	Button.AutoButtonColor =
		false

	Button.Parent =
		Row

	local function Refresh()

		if Config[ConfigName] then

			Button.BackgroundColor3 =
				Accent()

		else

			Button.BackgroundColor3 =
				Colors.Disabled

		end

	end

	Button.MouseButton1Click:Connect(function()

		Config[ConfigName] =
			not Config[ConfigName]

		Refresh()

	end)

	table.insert(
		ThemeRefreshers,
		Refresh
	)

	Refresh()

end

--========================================================--
-- SLIDER
--========================================================--

local function Slider(
	Parent,
	Text,
	ConfigName,
	Minimum,
	Maximum,
	Decimals
)

	local Row =
		Instance.new("Frame")

	Row.Size =
		UDim2.new(
			1,
			0,
			0,
			49
		)

	Row.BackgroundColor3 =
		Colors.Panel

	Row.BorderSizePixel =
		0

	Row.Parent =
		Parent

	local Label =
		Instance.new("TextLabel")

	Label.Size =
		UDim2.new(
			0.65,
			0,
			0,
			19
		)

	Label.Position =
		UDim2.fromOffset(
			7,
			2
		)

	Label.BackgroundTransparency =
		1

	Label.Text =
		Text

	Label.TextColor3 =
		Colors.Text

	Label.Font =
		Enum.Font.Code

	Label.TextSize =
		9

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Row

	local Value =
		Instance.new("TextLabel")

	Value.Size =
		UDim2.fromOffset(
			85,
			19
		)

	Value.Position =
		UDim2.new(
			1,
			-92,
			0,
			2
		)

	Value.BackgroundTransparency =
		1

	Value.TextColor3 =
		Colors.Sub

	Value.Font =
		Enum.Font.Code

	Value.TextSize =
		8

	Value.TextXAlignment =
		Enum.TextXAlignment.Right

	Value.Parent =
		Row

	local Bar =
		Instance.new("Frame")

	Bar.Size =
		UDim2.new(
			1,
			-14,
			0,
			5
		)

	Bar.Position =
		UDim2.fromOffset(
			7,
			32
		)

	Bar.BackgroundColor3 =
		Color3.fromRGB(
			49,
			49,
			52
		)

	Bar.BorderSizePixel =
		0

	Bar.Parent =
		Row

	local BarCorner =
		Instance.new(
			"UICorner"
		)

	BarCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	BarCorner.Parent =
		Bar

	local Fill =
		Instance.new("Frame")

	Fill.BackgroundColor3 =
		Accent()

	Fill.BorderSizePixel =
		0

	Fill.Parent =
		Bar

	local FillCorner =
		Instance.new(
			"UICorner"
		)

	FillCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	FillCorner.Parent =
		Fill

	local Knob =
		Instance.new("Frame")

	Knob.Size =
		UDim2.fromOffset(
			9,
			9
		)

	Knob.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Knob.BackgroundColor3 =
		Color3.fromRGB(
			245,
			245,
			245
		)

	Knob.BorderSizePixel =
		0

	Knob.Parent =
		Bar

	local KnobCorner =
		Instance.new(
			"UICorner"
		)

	KnobCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	KnobCorner.Parent =
		Knob

	local DraggingSlider =
		false

	local function Refresh()

		local Percent =
			math.clamp(
				(
					Config[ConfigName]
					-
					Minimum
				)
				/
				(
					Maximum
					-
					Minimum
				),
				0,
				1
			)

		Fill.Size =
			UDim2.new(
				Percent,
				0,
				1,
				0
			)

		Knob.Position =
			UDim2.new(
				Percent,
				0,
				0.5,
				0
			)

		Value.Text =
			string.format(
				"%."
				..
				Decimals
				..
				"f",
				Config[ConfigName]
			)

		Fill.BackgroundColor3 =
			Accent()

	end

	local function SetFromX(X)

		if Bar.AbsoluteSize.X <= 0 then
			return
		end

		local Percent =
			math.clamp(
				(
					X
					-
					Bar.AbsolutePosition.X
				)
				/
				Bar.AbsoluteSize.X,
				0,
				1
			)

		local Number =
			Minimum
			+
			(
				Maximum
				-
				Minimum
			)
			*
			Percent

		local Multiplier =
			10 ^ Decimals

		Number =
			math.floor(
				Number
				*
				Multiplier
				+
				0.5
			)
			/
			Multiplier

		Config[ConfigName] =
			Number

		Refresh()

	end

	Bar.InputBegan:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			DraggingSlider =
				true

			SetFromX(
				Input.Position.X
			)

		end

	end)

	Knob.InputBegan:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			DraggingSlider =
				true

		end

	end)

	UIS.InputChanged:Connect(function(Input)

		if DraggingSlider
			and
			Input.UserInputType ==
			Enum.UserInputType.MouseMovement then

			SetFromX(
				Input.Position.X
			)

		end

	end)

	UIS.InputEnded:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			DraggingSlider =
				false

		end

	end)

	table.insert(
		ThemeRefreshers,
		Refresh
	)

	Refresh()

end

--========================================================--
-- DROPDOWN
--========================================================--

local OpenDropdown = nil

local function Dropdown(
	Parent,
	Text,
	Values,
	GetValue,
	SetValue
)

	local CLOSED_HEIGHT =
		31

	local OPTION_HEIGHT =
		27

	local Row =
		Instance.new("Frame")

	Row.Size =
		UDim2.new(
			1,
			0,
			0,
			CLOSED_HEIGHT
		)

	Row.BackgroundColor3 =
		Colors.Panel

	Row.BorderSizePixel =
		0

	Row.ClipsDescendants =
		true

	Row.Parent =
		Parent

	local Header =
		Instance.new("TextButton")

	Header.Size =
		UDim2.new(
			1,
			0,
			0,
			CLOSED_HEIGHT
		)

	Header.BackgroundColor3 =
		Colors.Panel

	Header.BorderSizePixel =
		0

	Header.Text =
		""

	Header.AutoButtonColor =
		false

	Header.Parent =
		Row

	local LeftText =
		Instance.new("TextLabel")

	LeftText.Size =
		UDim2.new(
			0.45,
			0,
			1,
			0
		)

	LeftText.Position =
		UDim2.fromOffset(
			7,
			0
		)

	LeftText.BackgroundTransparency =
		1

	LeftText.Text =
		Text

	LeftText.TextColor3 =
		Colors.Text

	LeftText.Font =
		Enum.Font.Code

	LeftText.TextSize =
		9

	LeftText.TextXAlignment =
		Enum.TextXAlignment.Left

	LeftText.Parent =
		Header

	local SelectedText =
		Instance.new("TextLabel")

	SelectedText.Size =
		UDim2.new(
			0.42,
			0,
			1,
			0
		)

	SelectedText.Position =
		UDim2.new(
			0.48,
			0,
			0,
			0
		)

	SelectedText.BackgroundTransparency =
		1

	SelectedText.TextColor3 =
		Colors.Text

	SelectedText.Font =
		Enum.Font.Code

	SelectedText.TextSize =
		9

	SelectedText.TextXAlignment =
		Enum.TextXAlignment.Right

	SelectedText.Parent =
		Header

	local Arrow =
		Instance.new("TextLabel")

	Arrow.Size =
		UDim2.fromOffset(
			24,
			CLOSED_HEIGHT
		)

	Arrow.Position =
		UDim2.new(
			1,
			-26,
			0,
			0
		)

	Arrow.BackgroundTransparency =
		1

	Arrow.Text =
		"▼"

	Arrow.TextColor3 =
		Colors.Text

	Arrow.Font =
		Enum.Font.Code

	Arrow.TextSize =
		9

	Arrow.Parent =
		Header

	local OptionHolder =
		Instance.new("Frame")

	OptionHolder.Size =
		UDim2.new(
			1,
			-8,
			0,
			#Values
			*
			(OPTION_HEIGHT + 2)
		)

	OptionHolder.Position =
		UDim2.fromOffset(
			4,
			CLOSED_HEIGHT + 2
		)

	OptionHolder.BackgroundColor3 =
		Color3.fromRGB(
			10,
			10,
			11
		)

	OptionHolder.BorderSizePixel =
		0

	OptionHolder.Visible =
		false

	OptionHolder.Parent =
		Row

	local OptionStroke =
		Instance.new("UIStroke")

	OptionStroke.Color =
		Colors.Stroke

	OptionStroke.Thickness =
		1

	OptionStroke.Parent =
		OptionHolder

	local OptionLayout =
		Instance.new("UIListLayout")

	OptionLayout.Padding =
		UDim.new(
			0,
			2
		)

	OptionLayout.Parent =
		OptionHolder

	local IsOpen =
		false

	local CloseEvent =
		Instance.new("BindableEvent")

	CloseEvent.Name =
		"CloseDropdown"

	CloseEvent.Parent =
		Row

	local function Refresh()

		SelectedText.Text =
			tostring(
				GetValue()
			)

	end

	local function Close()

		IsOpen =
			false

		OptionHolder.Visible =
			false

		Arrow.Text =
			"▼"

		Row.Size =
			UDim2.new(
				1,
				0,
				0,
				CLOSED_HEIGHT
			)

		if OpenDropdown ==
			Row then

			OpenDropdown =
				nil

		end

	end

	local function Open()

		if OpenDropdown
			and
			OpenDropdown ~= Row then

			local OtherClose =
				OpenDropdown:
				FindFirstChild(
					"CloseDropdown"
				)

			if OtherClose then
				OtherClose:Fire()
			end

		end

		IsOpen =
			true

		OptionHolder.Visible =
			true

		Arrow.Text =
			"▲"

		Row.Size =
			UDim2.new(
				1,
				0,
				0,
				CLOSED_HEIGHT
				+
				6
				+
				#Values
				*
				(OPTION_HEIGHT + 2)
			)

		OpenDropdown =
			Row

	end

	CloseEvent.Event:Connect(
		Close
	)

	for _, Value in ipairs(
		Values
	) do

		local Option =
			Instance.new(
				"TextButton"
			)

		Option.Size =
			UDim2.new(
				1,
				0,
				0,
				OPTION_HEIGHT
			)

		Option.BackgroundColor3 =
			Color3.fromRGB(
				16,
				16,
				18
			)

		Option.BorderSizePixel =
			0

		Option.Text =
			"   "
			..
			tostring(
				Value
			)

		Option.TextColor3 =
			Colors.Text

		Option.Font =
			Enum.Font.Code

		Option.TextSize =
			9

		Option.TextXAlignment =
			Enum.TextXAlignment.Left

		Option.AutoButtonColor =
			false

		Option.Parent =
			OptionHolder

		Option.MouseEnter:Connect(function()

			Option.BackgroundColor3 =
				Color3.fromRGB(
					27,
					23,
					28
				)

			Option.TextColor3 =
				Accent()

		end)

		Option.MouseLeave:Connect(function()

			Option.BackgroundColor3 =
				Color3.fromRGB(
					16,
					16,
					18
				)

			Option.TextColor3 =
				Colors.Text

		end)

		Option.MouseButton1Click:Connect(function()

			SetValue(
				Value
			)

			Refresh()
			Close()

		end)

	end

	Header.MouseButton1Click:Connect(function()

		if IsOpen then
			Close()
		else
			Open()
		end

	end)

	Refresh()

end

--========================================================--
-- AIMING UI
--========================================================--

Section(
	AimLeft,
	"Aimbot"
)

Toggle(
	AimLeft,
	"Enabled",
	"Aimbot"
)

Toggle(
	AimLeft,
	"Team Check",
	"TeamCheck"
)

Toggle(
	AimLeft,
	"Wall Check",
	"WallCheck"
)

Dropdown(
	AimLeft,
	"Hit Part",

	{
		"Head",
		"UpperTorso",
		"HumanoidRootPart"
	},

	function()

		return Config.AimPart

	end,

	function(Value)

		Config.AimPart =
			Value

	end
)

Slider(
	AimLeft,
	"Distance",
	"MaxDistance",
	100,
	5000,
	0
)

Section(
	AimLeft,
	"Prediction"
)

Toggle(
	AimLeft,
	"Aimbot Prediction",
	"Prediction"
)

Slider(
	AimLeft,
	"Prediction",
	"PredictionAmount",
	0,
	0.5,
	2
)

Section(
	AimLeft,
	"Aimbot FOV"
)

Toggle(
	AimLeft,
	"Enabled",
	"FOVCircle"
)

Slider(
	AimLeft,
	"Size",
	"FOV",
	20,
	500,
	0
)

Section(
	AimRight,
	"Smoothness"
)

Slider(
	AimRight,
	"Smoothness",
	"Smoothness",
	0.01,
	1,
	2
)

Section(
	AimRight,
	"Miscellaneous"
)

Dropdown(
	AimRight,
	"Aim Type",

	{
		"Camera",
		"Camera Smooth"
	},

	function()

		if Config.Smoothness >= 1 then

			return "Camera"

		end

		return "Camera Smooth"

	end,

	function(Value)

		if Value == "Camera" then

			Config.Smoothness =
				1

		elseif Config.Smoothness >= 1 then

			Config.Smoothness =
				0.18

		end

	end
)

--========================================================--
-- VISUALS
--========================================================--

Section(
	VisualLeft,
	"ESP"
)

Toggle(
	VisualLeft,
	"Enabled",
	"ESP"
)

Toggle(
	VisualLeft,
	"Team Check",
	"TeamCheck"
)

Toggle(
	VisualLeft,
	"Box",
	"BoxESP"
)

Toggle(
	VisualLeft,
	"Fill Box",
	"FillBox"
)

Toggle(
	VisualLeft,
	"Name",
	"NameESP"
)

Toggle(
	VisualLeft,
	"Distance",
	"DistanceESP"
)

Section(
	VisualLeft,
	"Health"
)

Toggle(
	VisualLeft,
	"Health Bar",
	"HealthBar"
)

Toggle(
	VisualLeft,
	"Health Text",
	"HealthText"
)

Section(
	VisualRight,
	"Indicators"
)

Toggle(
	VisualRight,
	"Tracer",
	"Tracer"
)

Toggle(
	VisualRight,
	"Chams",
	"Chams"
)

Toggle(
	VisualRight,
	"Head Dot",
	"HeadDot"
)

Section(
	VisualRight,
	"Crosshair"
)

Toggle(
	VisualRight,
	"Enabled",
	"Crosshair"
)

Dropdown(
	VisualRight,
	"Style",

	{
		"Cross",
		"Dot",
		"Circle"
	},

	function()

		return Config.CrosshairStyle

	end,

	function(Value)

		Config.CrosshairStyle =
			Value

	end
)

Slider(
	VisualRight,
	"Size",
	"CrosshairSize",
	2,
	30,
	0
)

Slider(
	VisualRight,
	"Gap",
	"CrosshairGap",
	0,
	20,
	0
)

Section(
	VisualRight,
	"Crosshair Animation"
)

Toggle(
	VisualRight,
	"Animation",
	"CrosshairAnimation"
)

Dropdown(
	VisualRight,
	"Animation Type",

	{
		"Spin",
		"Pulse",
		"Spin + Pulse"
	},

	function()

		return Config.CrosshairAnimationType

	end,

	function(Value)

		Config.CrosshairAnimationType =
			Value

	end
)

Slider(
	VisualRight,
	"Animation Speed",
	"CrosshairAnimationSpeed",
	10,
	360,
	0
)

--========================================================--
-- CHARACTER
--========================================================--

Section(
	CharLeft,
	"Movement"
)

Toggle(
	CharLeft,
	"Fly",
	"Fly"
)

Slider(
	CharLeft,
	"Fly Speed",
	"FlySpeed",
	10,
	250,
	0
)

local FlyHelp =
	Instance.new("TextLabel")

FlyHelp.Size =
	UDim2.new(
		1,
		0,
		0,
		75
	)

FlyHelp.BackgroundColor3 =
	Colors.Panel

FlyHelp.BorderSizePixel =
	0

FlyHelp.Text =
	"WASD  - Move\nSPACE - Up\nLEFT CTRL - Down"

FlyHelp.TextColor3 =
	Colors.Sub

FlyHelp.Font =
	Enum.Font.Code

FlyHelp.TextSize =
	9

FlyHelp.TextXAlignment =
	Enum.TextXAlignment.Left

FlyHelp.Parent =
	CharLeft

local FlyHelpPad =
	Instance.new("UIPadding")

FlyHelpPad.PaddingLeft =
	UDim.new(
		0,
		8
	)

FlyHelpPad.Parent =
	FlyHelp

--========================================================--
-- OPTIONS
--========================================================--

Section(
	OptionLeft,
	"Theme"
)

Slider(
	OptionLeft,
	"Red",
	"AccentR",
	0,
	255,
	0
)

Slider(
	OptionLeft,
	"Green",
	"AccentG",
	0,
	255,
	0
)

Slider(
	OptionLeft,
	"Blue",
	"AccentB",
	0,
	255,
	0
)

Section(
	OptionLeft,
	"User Interface"
)

Toggle(
	OptionLeft,
	"Snow Effect",
	"Snow"
)

Section(
	OptionRight,
	"Keybinds"
)

local AimBind =
	Instance.new("TextButton")

AimBind.Size =
	UDim2.new(
		1,
		0,
		0,
		32
	)

AimBind.BackgroundColor3 =
	Colors.Panel

AimBind.BorderSizePixel =
	0

AimBind.TextColor3 =
	Colors.Text

AimBind.Font =
	Enum.Font.Code

AimBind.TextSize =
	9

AimBind.AutoButtonColor =
	false

AimBind.Parent =
	OptionRight

local function KeyName(Key)

	if Key.EnumType ==
		Enum.KeyCode then

		return Key.Name

	end

	if Key ==
		Enum.UserInputType.MouseButton1 then

		return "Mouse1"

	elseif Key ==
		Enum.UserInputType.MouseButton2 then

		return "Mouse2"

	elseif Key ==
		Enum.UserInputType.MouseButton3 then

		return "Mouse3"

	end

	return Key.Name

end

local function RefreshAimBind()

	AimBind.Text =
		"Aimbot Key       "
		..
		KeyName(
			Config.AimKey
		)

end

AimBind.MouseButton1Click:Connect(function()

	WaitingAimBind =
		true

	AimBind.Text =
		"Aimbot Key       [ PRESS KEY ]"

end)

RefreshAimBind()

local MenuInfo =
	Instance.new("TextLabel")

MenuInfo.Size =
	UDim2.new(
		1,
		0,
		0,
		55
	)

MenuInfo.BackgroundColor3 =
	Colors.Panel

MenuInfo.BorderSizePixel =
	0

MenuInfo.Text =
	"Menu Key\nRightShift"

MenuInfo.TextColor3 =
	Colors.Sub

MenuInfo.Font =
	Enum.Font.Code

MenuInfo.TextSize =
	9

MenuInfo.TextXAlignment =
	Enum.TextXAlignment.Left

MenuInfo.Parent =
	OptionRight

local MenuPad =
	Instance.new("UIPadding")

MenuPad.PaddingLeft =
	UDim.new(
		0,
		8
	)

MenuPad.Parent =
	MenuInfo

--========================================================--
-- CLOSE / UNLOAD EVO
--========================================================--

Section(
	OptionRight,
	"Session"
)

local CloseEVO =
	Instance.new("TextButton")

CloseEVO.Size =
	UDim2.new(
		1,
		0,
		0,
		34
	)

CloseEVO.BackgroundColor3 =
	Color3.fromRGB(
		22,
		15,
		18
	)

CloseEVO.BorderSizePixel =
	0

CloseEVO.Text =
	"CLOSE EVO COMPLETELY"

CloseEVO.TextColor3 =
	Color3.fromRGB(
		230,
		150,
		165
	)

CloseEVO.Font =
	Enum.Font.Code

CloseEVO.TextSize =
	9

CloseEVO.AutoButtonColor =
	false

CloseEVO.Parent =
	OptionRight

local CloseEVOStroke =
	Instance.new("UIStroke")

CloseEVOStroke.Color =
	Color3.fromRGB(
		70,
		35,
		42
	)

CloseEVOStroke.Thickness =
	1

CloseEVOStroke.Parent =
	CloseEVO

CloseEVO.MouseEnter:Connect(function()

	CloseEVO.BackgroundColor3 =
		Color3.fromRGB(
			35,
			18,
			23
		)

	CloseEVOStroke.Color =
		Colors.Danger

end)

CloseEVO.MouseLeave:Connect(function()

	CloseEVO.BackgroundColor3 =
		Color3.fromRGB(
			22,
			15,
			18
		)

	CloseEVOStroke.Color =
		Color3.fromRGB(
			70,
			35,
			42
		)

end)

local EVOClosed =
	false

--========================================================--
-- PLAYER LIST
--========================================================--

Section(
	PlayerLeft,
	"Player List"
)

local PlayerList =
	Instance.new(
		"ScrollingFrame"
	)

PlayerList.Size =
	UDim2.new(
		1,
		0,
		0,
		415
	)

PlayerList.BackgroundColor3 =
	Colors.Panel

PlayerList.BorderSizePixel =
	0

PlayerList.ScrollBarThickness =
	2

PlayerList.ScrollBarImageColor3 =
	Accent()

PlayerList.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

PlayerList.CanvasSize =
	UDim2.new()

PlayerList.Parent =
	PlayerLeft

local PlayerListLayout =
	Instance.new(
		"UIListLayout"
	)

PlayerListLayout.Padding =
	UDim.new(
		0,
		3
	)

PlayerListLayout.Parent =
	PlayerList

--========================================================--
-- PLAYER PANEL
--========================================================--

Section(
	PlayerRight,
	"Selected Player"
)

local PlayerCard =
	Instance.new("Frame")

PlayerCard.Size =
	UDim2.new(
		1,
		0,
		0,
		418
	)

PlayerCard.BackgroundColor3 =
	Colors.Panel

PlayerCard.BorderSizePixel =
	0

PlayerCard.Parent =
	PlayerRight

local PlayerCardStroke =
	Instance.new("UIStroke")

PlayerCardStroke.Color =
	Colors.Stroke

PlayerCardStroke.Thickness =
	1

PlayerCardStroke.Parent =
	PlayerCard

--========================================================--
-- PLAYER CARD TOP
--========================================================--

local PlayerHeader =
	Instance.new("Frame")

PlayerHeader.Size =
	UDim2.new(
		1,
		0,
		0,
		42
	)

PlayerHeader.BackgroundColor3 =
	Colors.Panel2

PlayerHeader.BorderSizePixel =
	0

PlayerHeader.Parent =
	PlayerCard

local AccentLine =
	Instance.new("Frame")

AccentLine.Size =
	UDim2.new(
		0,
		2,
		1,
		0
	)

AccentLine.BackgroundColor3 =
	Accent()

AccentLine.BorderSizePixel =
	0

AccentLine.Parent =
	PlayerHeader

local PreviewName =
	Instance.new("TextLabel")

PreviewName.Size =
	UDim2.new(
		1,
		-54,
		0,
		20
	)

PreviewName.Position =
	UDim2.fromOffset(
		10,
		4
	)

PreviewName.BackgroundTransparency =
	1

PreviewName.Text =
	"No player selected"

PreviewName.TextColor3 =
	Colors.Text

PreviewName.Font =
	Enum.Font.Code

PreviewName.TextSize =
	10

PreviewName.TextXAlignment =
	Enum.TextXAlignment.Left

PreviewName.Parent =
	PlayerHeader

local PreviewUser =
	Instance.new("TextLabel")

PreviewUser.Size =
	UDim2.new(
		1,
		-54,
		0,
		14
	)

PreviewUser.Position =
	UDim2.fromOffset(
		10,
		23
	)

PreviewUser.BackgroundTransparency =
	1

PreviewUser.Text =
	"Select a player"

PreviewUser.TextColor3 =
	Colors.Sub

PreviewUser.Font =
	Enum.Font.Code

PreviewUser.TextSize =
	8

PreviewUser.TextXAlignment =
	Enum.TextXAlignment.Left

PreviewUser.Parent =
	PlayerHeader

local StatusDot =
	Instance.new("Frame")

StatusDot.Size =
	UDim2.fromOffset(
		6,
		6
	)

StatusDot.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

StatusDot.Position =
	UDim2.new(
		1,
		-18,
		0.5,
		0
	)

StatusDot.BackgroundColor3 =
	Colors.Health

StatusDot.BorderSizePixel =
	0

StatusDot.Parent =
	PlayerHeader

local StatusCorner =
	Instance.new("UICorner")

StatusCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

StatusCorner.Parent =
	StatusDot

--========================================================--
-- VIEWPORT CONTAINER
--========================================================--

local ViewportContainer =
	Instance.new("Frame")

ViewportContainer.Size =
	UDim2.new(
		1,
		-18,
		0,
		225
	)

ViewportContainer.Position =
	UDim2.fromOffset(
		9,
		50
	)

ViewportContainer.BackgroundColor3 =
	Color3.fromRGB(
		9,
		9,
		11
	)

ViewportContainer.BorderSizePixel =
	0

ViewportContainer.Parent =
	PlayerCard

local ViewportStroke =
	Instance.new("UIStroke")

ViewportStroke.Color =
	Color3.fromRGB(
		41,
		41,
		44
	)

ViewportStroke.Thickness =
	1

ViewportStroke.Parent =
	ViewportContainer

local Viewport =
	Instance.new("ViewportFrame")

Viewport.Size =
	UDim2.new(
		1,
		-24,
		1,
		-12
	)

Viewport.Position =
	UDim2.fromOffset(
		18,
		6
	)

Viewport.BackgroundTransparency =
	1

Viewport.BorderSizePixel =
	0

Viewport.Ambient =
	Color3.fromRGB(
		190,
		190,
		190
	)

Viewport.LightColor =
	Color3.fromRGB(
		255,
		255,
		255
	)

Viewport.LightDirection =
	Vector3.new(
		-1,
		-1,
		-1
	)

Viewport.Parent =
	ViewportContainer

local WorldModel =
	Instance.new("WorldModel")

WorldModel.Parent =
	Viewport

local PreviewCamera =
	Instance.new("Camera")

PreviewCamera.Parent =
	Viewport

Viewport.CurrentCamera =
	PreviewCamera

--========================================================--
-- PLAYER PREVIEW CORNERS
--========================================================--

local function MakePreviewLine(
	Size,
	Position
)

	local Line =
		Instance.new("Frame")

	Line.Size =
		Size

	Line.Position =
		Position

	Line.BackgroundColor3 =
		Color3.fromRGB(
			220,
			220,
			225
		)

	Line.BorderSizePixel =
		0

	Line.ZIndex =
		15

	Line.Parent =
		ViewportContainer

	return Line

end

MakePreviewLine(
	UDim2.fromOffset(32,1),
	UDim2.fromOffset(14,14)
)

MakePreviewLine(
	UDim2.fromOffset(1,32),
	UDim2.fromOffset(14,14)
)

MakePreviewLine(
	UDim2.new(0,32,0,1),
	UDim2.new(1,-46,0,14)
)

MakePreviewLine(
	UDim2.new(0,1,0,32),
	UDim2.new(1,-15,0,14)
)

MakePreviewLine(
	UDim2.new(0,32,0,1),
	UDim2.new(0,14,1,-15)
)

MakePreviewLine(
	UDim2.new(0,1,0,32),
	UDim2.new(0,14,1,-46)
)

MakePreviewLine(
	UDim2.new(0,32,0,1),
	UDim2.new(1,-46,1,-15)
)

MakePreviewLine(
	UDim2.new(0,1,0,32),
	UDim2.new(1,-15,1,-46)
)

--========================================================--
-- PREVIEW HP BAR
--========================================================--

local PreviewHPBack =
	Instance.new("Frame")

PreviewHPBack.Size =
	UDim2.new(
		0,
		3,
		1,
		-28
	)

PreviewHPBack.Position =
	UDim2.fromOffset(
		7,
		14
	)

PreviewHPBack.BackgroundColor3 =
	Color3.fromRGB(
		28,
		28,
		30
	)

PreviewHPBack.BorderSizePixel =
	0

PreviewHPBack.Parent =
	ViewportContainer

local PreviewHP =
	Instance.new("Frame")

PreviewHP.AnchorPoint =
	Vector2.new(
		0,
		1
	)

PreviewHP.Size =
	UDim2.fromScale(
		1,
		1
	)

PreviewHP.Position =
	UDim2.fromScale(
		0,
		1
	)

PreviewHP.BackgroundColor3 =
	Colors.Health

PreviewHP.BorderSizePixel =
	0

PreviewHP.Parent =
	PreviewHPBack

--========================================================--
-- PLAYER INFO
--========================================================--

local PlayerInfo =
	Instance.new("Frame")

PlayerInfo.Size =
	UDim2.new(
		1,
		-18,
		0,
		42
	)

PlayerInfo.Position =
	UDim2.fromOffset(
		9,
		282
	)

PlayerInfo.BackgroundColor3 =
	Colors.Panel2

PlayerInfo.BorderSizePixel =
	0

PlayerInfo.Parent =
	PlayerCard

local PlayerInfoStroke =
	Instance.new("UIStroke")

PlayerInfoStroke.Color =
	Colors.Stroke

PlayerInfoStroke.Parent =
	PlayerInfo

local PreviewDistance =
	Instance.new("TextLabel")

PreviewDistance.Size =
	UDim2.new(
		0.5,
		0,
		1,
		0
	)

PreviewDistance.BackgroundTransparency =
	1

PreviewDistance.Text =
	"Distance\n--"

PreviewDistance.TextColor3 =
	Colors.Sub

PreviewDistance.Font =
	Enum.Font.Code

PreviewDistance.TextSize =
	8

PreviewDistance.Parent =
	PlayerInfo

local PreviewHPText =
	Instance.new("TextLabel")

PreviewHPText.Size =
	UDim2.new(
		0.5,
		0,
		1,
		0
	)

PreviewHPText.Position =
	UDim2.new(
		0.5,
		0,
		0,
		0
	)

PreviewHPText.BackgroundTransparency =
	1

PreviewHPText.Text =
	"Health\n--"

PreviewHPText.TextColor3 =
	Colors.Sub

PreviewHPText.Font =
	Enum.Font.Code

PreviewHPText.TextSize =
	8

PreviewHPText.Parent =
	PlayerInfo

--========================================================--
-- PLAYER ACTION BUTTONS
--========================================================--

local ActionHolder =
	Instance.new("Frame")

ActionHolder.Size =
	UDim2.new(
		1,
		-18,
		0,
		35
	)

ActionHolder.Position =
	UDim2.fromOffset(
		9,
		332
	)

ActionHolder.BackgroundTransparency =
	1

ActionHolder.Parent =
	PlayerCard

local function ActionButton(
	Text,
	Position,
	Size,
	Callback
)

	local Button =
		Instance.new("TextButton")

	Button.Size =
		Size

	Button.Position =
		Position

	Button.BackgroundColor3 =
		Colors.Panel3

	Button.BorderSizePixel =
		0

	Button.Text =
		Text

	Button.TextColor3 =
		Colors.Text

	Button.Font =
		Enum.Font.Code

	Button.TextSize =
		9

	Button.AutoButtonColor =
		false

	Button.Parent =
		ActionHolder

	local Stroke =
		Instance.new("UIStroke")

	Stroke.Color =
		Colors.Stroke

	Stroke.Thickness =
		1

	Stroke.Parent =
		Button

	Button.MouseEnter:Connect(function()

		Button.BackgroundColor3 =
			Color3.fromRGB(
				29,
				25,
				30
			)

		Stroke.Color =
			Accent()

	end)

	Button.MouseLeave:Connect(function()

		Button.BackgroundColor3 =
			Colors.Panel3

		Stroke.Color =
			Colors.Stroke

	end)

	Button.MouseButton1Click:Connect(
		Callback
	)

	return Button

end

ActionButton(

	"TELEPORT",

	UDim2.new(
		0,
		0,
		0,
		0
	),

	UDim2.new(
		0.5,
		-3,
		1,
		0
	),

	function()

		if not SelectedPlayer then
			return
		end

		local MyCharacter =
			LocalPlayer.Character

		local TheirCharacter =
			SelectedPlayer.Character

		if not MyCharacter
			or
			not TheirCharacter then

			return

		end

		local MyRoot =
			MyCharacter:
			FindFirstChild(
				"HumanoidRootPart"
			)

		local TheirRoot =
			TheirCharacter:
			FindFirstChild(
				"HumanoidRootPart"
			)

		if MyRoot
			and
			TheirRoot then

			MyRoot.CFrame =
				TheirRoot.CFrame
				*
				CFrame.new(
					0,
					0,
					-4
				)

		end

	end
)

ActionButton(

	"SPECTATE",

	UDim2.new(
		0.5,
		3,
		0,
		0
	),

	UDim2.new(
		0.5,
		-3,
		1,
		0
	),

	function()

		if not SelectedPlayer
			or
			not SelectedPlayer.Character then

			return

		end

		local Humanoid =
			SelectedPlayer.Character:
			FindFirstChildOfClass(
				"Humanoid"
			)

		if Humanoid then

			ViewingPlayer =
				SelectedPlayer

			Camera.CameraSubject =
				Humanoid

		end

	end
)

local StopSpectating =
	Instance.new("TextButton")

StopSpectating.Size =
	UDim2.new(
		1,
		-18,
		0,
		32
	)

StopSpectating.Position =
	UDim2.fromOffset(
		9,
		375
	)

StopSpectating.BackgroundColor3 =
	Color3.fromRGB(
		22,
		15,
		18
	)

StopSpectating.BorderSizePixel =
	0

StopSpectating.Text =
	"STOP SPECTATING"

StopSpectating.TextColor3 =
	Color3.fromRGB(
		230,
		150,
		165
	)

StopSpectating.Font =
	Enum.Font.Code

StopSpectating.TextSize =
	8

StopSpectating.AutoButtonColor =
	false

StopSpectating.Parent =
	PlayerCard

local StopStroke =
	Instance.new("UIStroke")

StopStroke.Color =
	Color3.fromRGB(
		70,
		35,
		43
	)

StopStroke.Parent =
	StopSpectating

StopSpectating.MouseEnter:Connect(function()

	StopSpectating.BackgroundColor3 =
		Color3.fromRGB(
			33,
			17,
			22
		)

	StopStroke.Color =
		Colors.Danger

end)

StopSpectating.MouseLeave:Connect(function()

	StopSpectating.BackgroundColor3 =
		Color3.fromRGB(
			22,
			15,
			18
		)

	StopStroke.Color =
		Color3.fromRGB(
			70,
			35,
			43
		)

end)

StopSpectating.MouseButton1Click:Connect(function()

	ViewingPlayer =
		nil

	local Character =
		LocalPlayer.Character

	if Character then

		local Humanoid =
			Character:
			FindFirstChildOfClass(
				"Humanoid"
			)

		if Humanoid then

			Camera.CameraSubject =
				Humanoid

		end

	end

end)

--========================================================--
-- PREVIEW MODEL
--========================================================--

local CurrentPreviewModel =
	nil

local function ClearPreviewModel()

	if CurrentPreviewModel then

		CurrentPreviewModel:
		Destroy()

		CurrentPreviewModel =
			nil

	end

end

local function SetPreviewPlayer(Player)

	ClearPreviewModel()

	if not Player then

		PreviewName.Text =
			"No player selected"

		PreviewUser.Text =
			"Select a player"

		PreviewDistance.Text =
			"Distance\n--"

		PreviewHPText.Text =
			"Health\n--"

		StatusDot.BackgroundColor3 =
			Colors.Disabled

		return

	end

	local Character =
		Player.Character

	if not Character then
		return
	end

	PreviewName.Text =
		Player.DisplayName

	PreviewUser.Text =
		"@"
		..
		Player.Name

	StatusDot.BackgroundColor3 =
		Colors.Health

	local PreviousArchivable =
		Character.Archivable

	Character.Archivable =
		true

	local Clone =
		Character:Clone()

	Character.Archivable =
		PreviousArchivable

	for _, Object in ipairs(
		Clone:GetDescendants()
	) do

		if Object:IsA("Script")
			or
			Object:IsA(
				"LocalScript"
			) then

			Object:Destroy()

		elseif Object:IsA(
			"BasePart"
		) then

			Object.Anchored =
				true

			Object.CanCollide =
				false

		end

	end

	Clone.Parent =
		WorldModel

	Clone:PivotTo(
		CFrame.new()
	)

	CurrentPreviewModel =
		Clone

	local _, Size =
		Clone:GetBoundingBox()

	local Height =
		math.max(
			Size.Y,
			5
		)

	-- FRONT VIEW
	PreviewCamera.CFrame =
		CFrame.lookAt(

			Vector3.new(
				0,
				Height * 0.08,
				-Height * 1.35
			),

			Vector3.new(
				0,
				Height * 0.08,
				0
			)

		)

end

--========================================================--
-- PLAYER LIST REFRESH
--========================================================--

local function SelectPlayer(Player)

	SelectedPlayer =
		Player

	SetPreviewPlayer(
		Player
	)

end

local function RefreshPlayerList()

	for _, Child in ipairs(
		PlayerList:GetChildren()
	) do

		if Child:IsA(
			"TextButton"
		) then

			Child:Destroy()

		end

	end

	for _, Player in ipairs(
		Players:GetPlayers()
	) do

		if Player ==
			LocalPlayer then

			continue

		end

		local Button =
			Instance.new(
				"TextButton"
			)

		Button.Size =
			UDim2.new(
				1,
				-4,
				0,
				31
			)

		Button.BackgroundColor3 =
			Colors.Panel2

		Button.BorderSizePixel =
			0

		Button.Text =
			"  "
			..
			Player.DisplayName
			..
			"    @"
			..
			Player.Name

		Button.TextColor3 =
			Colors.Text

		Button.Font =
			Enum.Font.Code

		Button.TextSize =
			8

		Button.TextXAlignment =
			Enum.TextXAlignment.Left

		Button.AutoButtonColor =
			false

		Button.Parent =
			PlayerList

		Button.MouseEnter:Connect(function()

			Button.BackgroundColor3 =
				Color3.fromRGB(
					25,
					22,
					26
				)

			Button.TextColor3 =
				Accent()

		end)

		Button.MouseLeave:Connect(function()

			if SelectedPlayer ==
				Player then

				Button.BackgroundColor3 =
					Color3.fromRGB(
						27,
						22,
						27
					)

			else

				Button.BackgroundColor3 =
					Colors.Panel2

			end

			Button.TextColor3 =
				Colors.Text

		end)

		Button.MouseButton1Click:Connect(function()

			SelectPlayer(
				Player
			)

			Button.BackgroundColor3 =
				Color3.fromRGB(
					27,
					22,
					27
				)

		end)

	end

end

Players.PlayerAdded:Connect(
	RefreshPlayerList
)

Players.PlayerRemoving:Connect(function(Player)

	if SelectedPlayer ==
		Player then

		SelectedPlayer =
			nil

		SetPreviewPlayer(
			nil
		)

	end

	if ViewingPlayer ==
		Player then

		ViewingPlayer =
			nil

	end

	RefreshPlayerList()

end)

RefreshPlayerList()

--========================================================--
-- FOV CIRCLE
--========================================================--

local FOVCircle =
	Instance.new("Frame")

FOVCircle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

FOVCircle.BackgroundTransparency =
	1

FOVCircle.ZIndex =
	2

FOVCircle.Parent =
	GUI

local FOVCorner =
	Instance.new("UICorner")

FOVCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

FOVCorner.Parent =
	FOVCircle

local FOVStroke =
	Instance.new("UIStroke")

FOVStroke.Color =
	Accent()

FOVStroke.Thickness =
	1

FOVStroke.Transparency =
	0.15

FOVStroke.Parent =
	FOVCircle

--========================================================--
-- CROSSHAIR
--========================================================--

local Cross =
	Instance.new("Frame")

Cross.Size =
	UDim2.fromOffset(
		100,
		100
	)

Cross.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Cross.BackgroundTransparency =
	1

Cross.ZIndex =
	40

Cross.Parent =
	GUI

local CrossLines = {}

for I = 1, 4 do

	local Line =
		Instance.new("Frame")

	Line.BorderSizePixel =
		0

	Line.BackgroundColor3 =
		Accent()

	Line.ZIndex =
		41

	Line.Parent =
		Cross

	CrossLines[I] =
		Line

end

local CrossDot =
	Instance.new("Frame")

CrossDot.Size =
	UDim2.fromOffset(
		4,
		4
	)

CrossDot.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

CrossDot.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

CrossDot.BackgroundColor3 =
	Accent()

CrossDot.BorderSizePixel =
	0

CrossDot.ZIndex =
	41

CrossDot.Parent =
	Cross

local CrossDotCorner =
	Instance.new("UICorner")

CrossDotCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

CrossDotCorner.Parent =
	CrossDot

local CrossCircle =
	Instance.new("Frame")

CrossCircle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

CrossCircle.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

CrossCircle.BackgroundTransparency =
	1

CrossCircle.ZIndex =
	41

CrossCircle.Parent =
	Cross

local CrossCircleCorner =
	Instance.new("UICorner")

CrossCircleCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

CrossCircleCorner.Parent =
	CrossCircle

local CrossCircleStroke =
	Instance.new("UIStroke")

CrossCircleStroke.Color =
	Accent()

CrossCircleStroke.Thickness =
	1

CrossCircleStroke.Parent =
	CrossCircle

local function UpdateCrosshair(Delta)

	local Mouse =
		UIS:GetMouseLocation()

	Cross.Position =
		UDim2.fromOffset(
			Mouse.X,
			Mouse.Y
		)

	Cross.Visible =
		Config.Crosshair

	CrosshairAnimationTime +=
		Delta

	local SizeMultiplier =
		1

	if Config.CrosshairAnimation then

		if Config.CrosshairAnimationType ==
			"Spin"
			or
			Config.CrosshairAnimationType ==
			"Spin + Pulse" then

			Cross.Rotation =
				(
					Cross.Rotation
					+
					Config.CrosshairAnimationSpeed
					*
					Delta
				)
				%
				360

		else

			Cross.Rotation =
				0

		end

		if Config.CrosshairAnimationType ==
			"Pulse"
			or
			Config.CrosshairAnimationType ==
			"Spin + Pulse" then

			local PulseSpeed =
				Config.CrosshairAnimationSpeed
				/
				45

			SizeMultiplier =
				1
				+
				math.sin(
					CrosshairAnimationTime
					*
					PulseSpeed
				)
				*
				0.22

		end

	else

		Cross.Rotation =
			0

	end

	for _, Line in ipairs(
		CrossLines
	) do

		Line.Visible =
			false

		Line.BackgroundColor3 =
			Accent()

	end

	CrossDot.Visible =
		false

	CrossCircle.Visible =
		false

	CrossDot.BackgroundColor3 =
		Accent()

	CrossCircleStroke.Color =
		Accent()

	local Size =
		Config.CrosshairSize
		*
		SizeMultiplier

	local Gap =
		Config.CrosshairGap
		*
		SizeMultiplier

	if Config.CrosshairStyle ==
		"Dot" then

		CrossDot.Visible =
			true

		local DotSize =
			math.max(
				3,
				Size * 0.5
			)

		CrossDot.Size =
			UDim2.fromOffset(
				DotSize,
				DotSize
			)

	elseif Config.CrosshairStyle ==
		"Circle" then

		CrossCircle.Visible =
			true

		CrossCircle.Size =
			UDim2.fromOffset(
				Size * 2,
				Size * 2
			)

	else

		for _, Line in ipairs(
			CrossLines
		) do

			Line.Visible =
				true

		end

		-- RIGHT
		CrossLines[1].Size =
			UDim2.fromOffset(
				Size,
				1
			)

		CrossLines[1].Position =
			UDim2.new(
				0.5,
				Gap,
				0.5,
				0
			)

		-- LEFT
		CrossLines[2].Size =
			UDim2.fromOffset(
				Size,
				1
			)

		CrossLines[2].Position =
			UDim2.new(
				0.5,
				-Size - Gap,
				0.5,
				0
			)

		-- DOWN
		CrossLines[3].Size =
			UDim2.fromOffset(
				1,
				Size
			)

		CrossLines[3].Position =
			UDim2.new(
				0.5,
				0,
				0.5,
				Gap
			)

		-- UP
		CrossLines[4].Size =
			UDim2.fromOffset(
				1,
				Size
			)

		CrossLines[4].Position =
			UDim2.new(
				0.5,
				0,
				0.5,
				-Size - Gap
			)

	end

end

--========================================================--
-- ESP
--========================================================--

local ESPObjects = {}

local function CreateESP(Player)

	if Player ==
		LocalPlayer then

		return

	end

	local Holder =
		Instance.new("Frame")

	Holder.BackgroundTransparency =
		1

	Holder.Visible =
		false

	Holder.ZIndex =
		20

	Holder.Parent =
		GUI

	local Fill =
		Instance.new("Frame")

	Fill.BackgroundColor3 =
		Accent()

	Fill.BackgroundTransparency =
		0.88

	Fill.BorderSizePixel =
		0

	Fill.ZIndex =
		20

	Fill.Parent =
		Holder

	local Lines = {}

	for I = 1, 8 do

		local Line =
			Instance.new("Frame")

		Line.BackgroundColor3 =
			Accent()

		Line.BorderSizePixel =
			0

		Line.ZIndex =
			22

		Line.Parent =
			Holder

		Lines[I] =
			Line

	end

	local Name =
		Instance.new("TextLabel")

	Name.BackgroundTransparency =
		1

	Name.TextColor3 =
		Colors.Text

	Name.TextStrokeTransparency =
		0.25

	Name.Font =
		Enum.Font.Code

	Name.TextSize =
		9

	Name.ZIndex =
		23

	Name.Parent =
		Holder

	local Distance =
		Instance.new("TextLabel")

	Distance.BackgroundTransparency =
		1

	Distance.TextColor3 =
		Colors.Sub

	Distance.TextStrokeTransparency =
		0.25

	Distance.Font =
		Enum.Font.Code

	Distance.TextSize =
		8

	Distance.ZIndex =
		23

	Distance.Parent =
		Holder

	local HealthBG =
		Instance.new("Frame")

	HealthBG.BackgroundColor3 =
		Color3.fromRGB(
			20,
			20,
			20
		)

	HealthBG.BorderSizePixel =
		0

	HealthBG.ZIndex =
		22

	HealthBG.Parent =
		Holder

	local Health =
		Instance.new("Frame")

	Health.AnchorPoint =
		Vector2.new(
			0,
			1
		)

	Health.BackgroundColor3 =
		Colors.Health

	Health.BorderSizePixel =
		0

	Health.ZIndex =
		23

	Health.Parent =
		HealthBG

	local HPText =
		Instance.new("TextLabel")

	HPText.BackgroundTransparency =
		1

	HPText.TextColor3 =
		Colors.Text

	HPText.TextStrokeTransparency =
		0.25

	HPText.Font =
		Enum.Font.Code

	HPText.TextSize =
		8

	HPText.ZIndex =
		24

	HPText.Parent =
		Holder

	local Tracer =
		Instance.new("Frame")

	Tracer.AnchorPoint =
		Vector2.new(
			0,
			0.5
		)

	Tracer.BackgroundColor3 =
		Accent()

	Tracer.BorderSizePixel =
		0

	Tracer.Visible =
		false

	Tracer.ZIndex =
		18

	Tracer.Parent =
		GUI

	local HeadDot =
		Instance.new("Frame")

	HeadDot.Size =
		UDim2.fromOffset(
			5,
			5
		)

	HeadDot.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	HeadDot.BackgroundColor3 =
		Accent()

	HeadDot.BorderSizePixel =
		0

	HeadDot.Visible =
		false

	HeadDot.ZIndex =
		24

	HeadDot.Parent =
		GUI

	local HeadCorner =
		Instance.new("UICorner")

	HeadCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	HeadCorner.Parent =
		HeadDot

	local Highlight =
		Instance.new("Highlight")

	Highlight.FillColor =
		Accent()

	Highlight.OutlineColor =
		Accent()

	Highlight.FillTransparency =
		0.82

	Highlight.OutlineTransparency =
		0

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.Enabled =
		false

	ESPObjects[Player] = {

		Holder = Holder,
		Fill = Fill,
		Lines = Lines,

		Name = Name,
		Distance = Distance,

		HealthBG = HealthBG,
		Health = Health,
		HPText = HPText,

		Tracer = Tracer,
		HeadDot = HeadDot,

		Highlight = Highlight

	}

end

local function RemoveESP(Player)

	local Data =
		ESPObjects[Player]

	if not Data then
		return
	end

	for _, Object in pairs(
		Data
	) do

		if typeof(Object) ==
			"Instance" then

			Object:Destroy()

		elseif typeof(Object) ==
			"table" then

			for _, Child in ipairs(
				Object
			) do

				if typeof(Child) ==
					"Instance" then

					Child:Destroy()

				end

			end

		end

	end

	ESPObjects[Player] =
		nil

end

for _, Player in ipairs(
	Players:GetPlayers()
) do

	CreateESP(
		Player
	)

end

Players.PlayerAdded:Connect(
	CreateESP
)

Players.PlayerRemoving:Connect(
	RemoveESP
)

--========================================================--
-- ESP CORNER BOX
--========================================================--

local function UpdateCornerBox(
	Lines,
	Width,
	Height,
	Color
)

	local CornerWidth =
		math.max(
			5,
			Width * 0.27
		)

	local CornerHeight =
		math.max(
			5,
			Height * 0.18
		)

	for _, Line in ipairs(
		Lines
	) do

		Line.BackgroundColor3 =
			Color

		Line.Visible =
			Config.BoxESP

	end

	Lines[1].Size =
		UDim2.fromOffset(
			CornerWidth,
			1
		)

	Lines[1].Position =
		UDim2.fromOffset(
			0,
			0
		)

	Lines[2].Size =
		UDim2.fromOffset(
			1,
			CornerHeight
		)

	Lines[2].Position =
		UDim2.fromOffset(
			0,
			0
		)

	Lines[3].Size =
		UDim2.fromOffset(
			CornerWidth,
			1
		)

	Lines[3].Position =
		UDim2.new(
			1,
			-CornerWidth,
			0,
			0
		)

	Lines[4].Size =
		UDim2.fromOffset(
			1,
			CornerHeight
		)

	Lines[4].Position =
		UDim2.new(
			1,
			-1,
			0,
			0
		)

	Lines[5].Size =
		UDim2.fromOffset(
			CornerWidth,
			1
		)

	Lines[5].Position =
		UDim2.new(
			0,
			0,
			1,
			-1
		)

	Lines[6].Size =
		UDim2.fromOffset(
			1,
			CornerHeight
		)

	Lines[6].Position =
		UDim2.new(
			0,
			0,
			1,
			-CornerHeight
		)

	Lines[7].Size =
		UDim2.fromOffset(
			CornerWidth,
			1
		)

	Lines[7].Position =
		UDim2.new(
			1,
			-CornerWidth,
			1,
			-1
		)

	Lines[8].Size =
		UDim2.fromOffset(
			1,
			CornerHeight
		)

	Lines[8].Position =
		UDim2.new(
			1,
			-1,
			1,
			-CornerHeight
		)

end

--========================================================--
-- ESP UPDATE
--========================================================--

local function UpdateESP()

	for Player, Data in pairs(
		ESPObjects
	) do

		local Character =
			Player.Character

		local Humanoid =
			Character
			and
			Character:
			FindFirstChildOfClass(
				"Humanoid"
			)

		local Root =
			Character
			and
			Character:
			FindFirstChild(
				"HumanoidRootPart"
			)

		local Head =
			Character
			and
			Character:
			FindFirstChild(
				"Head"
			)

		if not Config.ESP
			or
			not Character
			or
			not Humanoid
			or
			not Root
			or
			not Head
			or
			Humanoid.Health <= 0 then

			Data.Holder.Visible =
				false

			Data.Tracer.Visible =
				false

			Data.HeadDot.Visible =
				false

			Data.Highlight.Enabled =
				false

			continue

		end

		if Config.TeamCheck
			and
			LocalPlayer.Team
			and
			Player.Team ==
			LocalPlayer.Team then

			Data.Holder.Visible =
				false

			Data.Tracer.Visible =
				false

			Data.HeadDot.Visible =
				false

			Data.Highlight.Enabled =
				false

			continue

		end

		local RootScreen,
		OnScreen =
			Camera:
			WorldToViewportPoint(
				Root.Position
			)

		if not OnScreen
			or
			RootScreen.Z <= 0 then

			Data.Holder.Visible =
				false

			Data.Tracer.Visible =
				false

			Data.HeadDot.Visible =
				false

			Data.Highlight.Enabled =
				false

			continue

		end

		local TopScreen =
			Camera:
			WorldToViewportPoint(
				Head.Position
				+
				Vector3.new(
					0,
					0.8,
					0
				)
			)

		local BottomScreen =
			Camera:
			WorldToViewportPoint(
				Root.Position
				-
				Vector3.new(
					0,
					3,
					0
				)
			)

		local Height =
			math.abs(
				BottomScreen.Y
				-
				TopScreen.Y
			)

		local Width =
			Height
			*
			0.55

		local X =
			RootScreen.X
			-
			Width / 2

		local Y =
			TopScreen.Y

		Data.Holder.Position =
			UDim2.fromOffset(
				X,
				Y
			)

		Data.Holder.Size =
			UDim2.fromOffset(
				Width,
				Height
			)

		Data.Holder.Visible =
			true

		Data.Fill.Size =
			UDim2.fromScale(
				1,
				1
			)

		Data.Fill.Visible =
			Config.FillBox

		Data.Fill.BackgroundColor3 =
			Accent()

		UpdateCornerBox(
			Data.Lines,
			Width,
			Height,
			Accent()
		)

		Data.Name.Size =
			UDim2.new(
				1,
				50,
				0,
				16
			)

		Data.Name.Position =
			UDim2.fromOffset(
				-25,
				-17
			)

		Data.Name.Text =
			Player.DisplayName

		Data.Name.Visible =
			Config.NameESP

		local Distance =
			(
				Root.Position
				-
				Camera.CFrame.Position
			).Magnitude

		Data.Distance.Size =
			UDim2.new(
				1,
				50,
				0,
				16
			)

		Data.Distance.Position =
			UDim2.new(
				0,
				-25,
				1,
				2
			)

		Data.Distance.Text =
			math.floor(
				Distance
			)
			..
			"m"

		Data.Distance.Visible =
			Config.DistanceESP

		local HealthPercent =
			math.clamp(
				Humanoid.Health
				/
				math.max(
					Humanoid.MaxHealth,
					1
				),
				0,
				1
			)

		Data.HealthBG.Size =
			UDim2.new(
				0,
				3,
				1,
				0
			)

		Data.HealthBG.Position =
			UDim2.fromOffset(
				-6,
				0
			)

		Data.HealthBG.Visible =
			Config.HealthBar

		Data.Health.Size =
			UDim2.new(
				1,
				0,
				HealthPercent,
				0
			)

		Data.Health.Position =
			UDim2.new(
				0,
				0,
				1,
				0
			)

		Data.HPText.Size =
			UDim2.fromOffset(
				35,
				14
			)

		Data.HPText.Position =
			UDim2.fromOffset(
				-43,
				math.max(
					0,
					Height
					*
					(
						1
						-
						HealthPercent
					)
					-
					6
				)
			)

		Data.HPText.Text =
			tostring(
				math.floor(
					Humanoid.Health
				)
			)

		Data.HPText.Visible =
			Config.HealthText

		if Config.HeadDot then

			local HeadScreen =
				Camera:
				WorldToViewportPoint(
					Head.Position
				)

			Data.HeadDot.Position =
				UDim2.fromOffset(
					HeadScreen.X,
					HeadScreen.Y
				)

			Data.HeadDot.BackgroundColor3 =
				Accent()

			Data.HeadDot.Visible =
				true

		else

			Data.HeadDot.Visible =
				false

		end

		if Config.Tracer then

			local Start =
				Vector2.new(
					Camera.ViewportSize.X / 2,
					Camera.ViewportSize.Y
				)

			local Finish =
				Vector2.new(
					RootScreen.X,
					RootScreen.Y
				)

			local Difference =
				Finish
				-
				Start

			Data.Tracer.Position =
				UDim2.fromOffset(
					Start.X,
					Start.Y
				)

			Data.Tracer.Size =
				UDim2.fromOffset(
					Difference.Magnitude,
					1
				)

			Data.Tracer.Rotation =
				math.deg(
					math.atan2(
						Difference.Y,
						Difference.X
					)
				)

			Data.Tracer.BackgroundColor3 =
				Accent()

			Data.Tracer.Visible =
				true

		else

			Data.Tracer.Visible =
				false

		end

		Data.Highlight.Parent =
			Character

		Data.Highlight.FillColor =
			Accent()

		Data.Highlight.OutlineColor =
			Accent()

		Data.Highlight.Enabled =
			Config.Chams

	end

end

--========================================================--
-- WALL CHECK
--========================================================--

local function CanSee(Part)

	if not Config.WallCheck then

		return true

	end

	local Params =
		RaycastParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	Params.FilterDescendantsInstances = {
		LocalPlayer.Character,
		Camera
	}

	local Origin =
		Camera.CFrame.Position

	local Result =
		workspace:Raycast(
			Origin,
			Part.Position
			-
			Origin,
			Params
		)

	if not Result then

		return true

	end

	return Result.Instance:
		IsDescendantOf(
			Part.Parent
		)

end

--========================================================--
-- TARGET
--========================================================--

local function GetTarget()

	local Mouse =
		UIS:GetMouseLocation()

	local Best =
		nil

	local BestDistance =
		Config.FOV

	for _, Player in ipairs(
		Players:GetPlayers()
	) do

		if Player ==
			LocalPlayer then

			continue

		end

		if Config.TeamCheck
			and
			LocalPlayer.Team
			and
			Player.Team ==
			LocalPlayer.Team then

			continue

		end

		local Character =
			Player.Character

		if not Character then
			continue
		end

		local Humanoid =
			Character:
			FindFirstChildOfClass(
				"Humanoid"
			)

		local Part =
			Character:
			FindFirstChild(
				Config.AimPart
			)

		if not Humanoid
			or
			Humanoid.Health <= 0
			or
			not Part then

			continue

		end

		local WorldDistance =
			(
				Part.Position
				-
				Camera.CFrame.Position
			).Magnitude

		if WorldDistance >
			Config.MaxDistance then

			continue

		end

		local Position,
		OnScreen =
			Camera:
			WorldToViewportPoint(
				Part.Position
			)

		if not OnScreen
			or
			Position.Z <= 0 then

			continue

		end

		local ScreenDistance =
			(
				Vector2.new(
					Position.X,
					Position.Y
				)
				-
				Mouse
			).Magnitude

		if ScreenDistance <
			BestDistance
			and
			CanSee(
				Part
			) then

			BestDistance =
				ScreenDistance

			Best =
				Part

		end

	end

	return Best

end

--========================================================--
-- FLY
--========================================================--

local FlyVelocity =
	nil

local FlyGyro =
	nil

local function StopFly()

	if FlyVelocity then

		FlyVelocity:Destroy()

		FlyVelocity =
			nil

	end

	if FlyGyro then

		FlyGyro:Destroy()

		FlyGyro =
			nil

	end

end

local function UpdateFly()

	if not Config.Fly then

		StopFly()

		return

	end

	local Character =
		LocalPlayer.Character

	local Root =
		Character
		and
		Character:
		FindFirstChild(
			"HumanoidRootPart"
		)

	if not Root then
		return
	end

	if not FlyVelocity then

		FlyVelocity =
			Instance.new(
				"BodyVelocity"
			)

		FlyVelocity.MaxForce =
			Vector3.new(
				math.huge,
				math.huge,
				math.huge
			)

		FlyVelocity.Parent =
			Root

	end

	if not FlyGyro then

		FlyGyro =
			Instance.new(
				"BodyGyro"
			)

		FlyGyro.MaxTorque =
			Vector3.new(
				math.huge,
				math.huge,
				math.huge
			)

		FlyGyro.P =
			10000

		FlyGyro.Parent =
			Root

	end

	local Direction =
		Vector3.zero

	if UIS:IsKeyDown(
		Enum.KeyCode.W
	) then

		Direction +=
			Camera.CFrame.LookVector

	end

	if UIS:IsKeyDown(
		Enum.KeyCode.S
	) then

		Direction -=
			Camera.CFrame.LookVector

	end

	if UIS:IsKeyDown(
		Enum.KeyCode.A
	) then

		Direction -=
			Camera.CFrame.RightVector

	end

	if UIS:IsKeyDown(
		Enum.KeyCode.D
	) then

		Direction +=
			Camera.CFrame.RightVector

	end

	if UIS:IsKeyDown(
		Enum.KeyCode.Space
	) then

		Direction +=
			Vector3.new(
				0,
				1,
				0
			)

	end

	if UIS:IsKeyDown(
		Enum.KeyCode.LeftControl
	) then

		Direction -=
			Vector3.new(
				0,
				1,
				0
			)

	end

	if Direction.Magnitude >
		0 then

		Direction =
			Direction.Unit

	end

	FlyVelocity.Velocity =
		Direction
		*
		Config.FlySpeed

	FlyGyro.CFrame =
		CFrame.lookAt(
			Root.Position,
			Root.Position
			+
			Camera.CFrame.LookVector
		)

end

--========================================================--
-- SNOW
--========================================================--

local SnowLayer =
	Instance.new("Frame")

SnowLayer.Name =
	"EvoSnow"

SnowLayer.Size =
	UDim2.fromScale(
		1,
		1
	)

SnowLayer.BackgroundTransparency =
	1

SnowLayer.BorderSizePixel =
	0

SnowLayer.ClipsDescendants =
	true

SnowLayer.ZIndex =
	1

SnowLayer.Parent =
	GUI

local Snowflakes = {}

local SNOW_COUNT =
	65

local function CreateSnowflake()

	local Flake =
		Instance.new("Frame")

	local Size =
		math.random(
			2,
			4
		)

	Flake.Size =
		UDim2.fromOffset(
			Size,
			Size
		)

	Flake.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Flake.BackgroundColor3 =
		Color3.fromRGB(
			255,
			235,
			248
		)

	Flake.BackgroundTransparency =
		math.random(
			20,
			65
		)
		/
		100

	Flake.BorderSizePixel =
		0

	Flake.Parent =
		SnowLayer

	local Corner =
		Instance.new(
			"UICorner"
		)

	Corner.CornerRadius =
		UDim.new(
			1,
			0
		)

	Corner.Parent =
		Flake

	return Flake

end

local function StartSnowflake(
	Flake,
	Initial
)

	if not Flake
		or
		not Flake.Parent then

		return

	end

	local Width =
		math.max(
			Camera.ViewportSize.X,
			100
		)

	local Height =
		math.max(
			Camera.ViewportSize.Y,
			100
		)

	local StartX =
		math.random(
			10,
			math.max(
				11,
				Width - 10
			)
		)

	local StartY

	if Initial then

		StartY =
			math.random(
				0,
				Height
			)

	else

		StartY =
			-math.random(
				10,
				80
			)

	end

	Flake.Position =
		UDim2.fromOffset(
			StartX,
			StartY
		)

	local EndX =
		math.clamp(
			StartX
			+
			math.random(
				-8,
				8
			),
			5,
			Width - 5
		)

	local EndY =
		Height
		+
		math.random(
			30,
			100
		)

	local Duration =
		math.random(
			55,
			105
		)
		/
		10

	local Tween =
		TweenService:Create(

			Flake,

			TweenInfo.new(
				Duration,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out
			),

			{
				Position =
					UDim2.fromOffset(
						EndX,
						EndY
					)
			}

		)

	Tween.Completed:Once(function()

		if Flake
			and
			Flake.Parent then

			task.defer(function()

				StartSnowflake(
					Flake,
					false
				)

			end)

		end

	end)

	Tween:Play()

end

for I = 1, SNOW_COUNT do

	local Flake =
		CreateSnowflake()

	Snowflakes[I] =
		Flake

	task.delay(

		math.random()
		*
		1.5,

		function()

			if Flake.Parent then

				StartSnowflake(
					Flake,
					true
				)

			end

		end
	)

end

local function UpdateSnow()

	SnowLayer.Visible =
		Main.Visible
		and
		Config.Snow

end

--========================================================--
-- SELECTED PLAYER UPDATE
--========================================================--

local function UpdateSelectedPlayer()

	if not SelectedPlayer
		or
		not SelectedPlayer.Character then

		return

	end

	local Character =
		SelectedPlayer.Character

	local Humanoid =
		Character:
		FindFirstChildOfClass(
			"Humanoid"
		)

	local Root =
		Character:
		FindFirstChild(
			"HumanoidRootPart"
		)

	if Humanoid then

		local Percent =
			math.clamp(
				Humanoid.Health
				/
				math.max(
					Humanoid.MaxHealth,
					1
				),
				0,
				1
			)

		PreviewHP.Size =
			UDim2.new(
				1,
				0,
				Percent,
				0
			)

		PreviewHPText.Text =
			"Health\n"
			..
			math.floor(
				Humanoid.Health
			)
			..
			" / "
			..
			math.floor(
				Humanoid.MaxHealth
			)

	end

	if Root then

		local MyCharacter =
			LocalPlayer.Character

		local MyRoot =
			MyCharacter
			and
			MyCharacter:
			FindFirstChild(
				"HumanoidRootPart"
			)

		if MyRoot then

			local Distance =
				(
					Root.Position
					-
					MyRoot.Position
				).Magnitude

			PreviewDistance.Text =
				"Distance\n"
				..
				math.floor(
					Distance
				)
				..
				"m"

		end

	end

end

--========================================================--
-- WINDOW DRAG
--========================================================--

local DraggingWindow =
	false

local DragStart
local StartPosition

Topbar.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		DraggingWindow =
			true

		DragStart =
			Input.Position

		StartPosition =
			Main.Position

	end

end)

UIS.InputChanged:Connect(function(Input)

	if DraggingWindow
		and
		Input.UserInputType ==
		Enum.UserInputType.MouseMovement then

		local Delta =
			Input.Position
			-
			DragStart

		Main.Position =
			UDim2.new(

				StartPosition.X.Scale,

				StartPosition.X.Offset
				+
				Delta.X,

				StartPosition.Y.Scale,

				StartPosition.Y.Offset
				+
				Delta.Y

			)

	end

end)

UIS.InputEnded:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		DraggingWindow =
			false

	end

end)

--========================================================--
-- INPUT
--========================================================--

local function MatchesAimKey(
	Input
)

	if Config.AimKey.EnumType ==
		Enum.KeyCode then

		return Input.KeyCode ==
			Config.AimKey

	end

	return Input.UserInputType ==
		Config.AimKey

end

UIS.InputBegan:Connect(function(
	Input,
	Processed
)

	if WaitingAimBind then

		if Input.KeyCode ==
			Enum.KeyCode.Escape then

			WaitingAimBind =
				false

			RefreshAimBind()

			return

		end

		if Input.UserInputType ==
			Enum.UserInputType.Keyboard then

			Config.AimKey =
				Input.KeyCode

			WaitingAimBind =
				false

			RefreshAimBind()

			return

		elseif
			Input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or
			Input.UserInputType ==
			Enum.UserInputType.MouseButton2
			or
			Input.UserInputType ==
			Enum.UserInputType.MouseButton3 then

			Config.AimKey =
				Input.UserInputType

			WaitingAimBind =
				false

			RefreshAimBind()

			return

		end

	end

	if Input.KeyCode ==
		Config.MenuKey then

		Main.Visible =
			not Main.Visible

		UpdateSnow()

		return

	end

	if Processed then
		return
	end

	if MatchesAimKey(
		Input
	) then

		AimHeld =
			true

	end

end)

UIS.InputEnded:Connect(function(Input)

	if MatchesAimKey(
		Input
	) then

		AimHeld =
			false

	end

end)

--========================================================--
-- FULL UNLOAD
--========================================================--

local function CloseEVOScript()

	if EVOClosed then
		return
	end

	EVOClosed =
		true

	Config.Aimbot =
		false

	Config.ESP =
		false

	Config.Fly =
		false

	Config.FOVCircle =
		false

	Config.Crosshair =
		false

	Config.Snow =
		false

	AimHeld =
		false

	CurrentTarget =
		nil

	-- Stop the EVO render loop first.
	RunService:UnbindFromRenderStep(
		"EVO_V7_4_RENDER"
	)

	-- Stop movement objects.
	StopFly()

	-- Remove all ESP/highlights created by EVO.
	for Player in pairs(
		ESPObjects
	) do

		RemoveESP(
			Player
		)

	end

	-- Restore camera if spectating.
	ViewingPlayer =
		nil

	local Character =
		LocalPlayer.Character

	if Character then

		local Humanoid =
			Character:FindFirstChildOfClass(
				"Humanoid"
			)

		if Humanoid then

			Camera.CameraSubject =
				Humanoid

		end

	end

	-- Remove the entire EVO GUI. This also removes
	-- FOV, crosshair, snow and menu UI descendants.
	if GUI
		and
		GUI.Parent then

		GUI:Destroy()

	end

	-- Remove UI sounds created by EVO.
	if UIClickSound then
		UIClickSound:Destroy()
	end

	if UIHoverSound then
		UIHoverSound:Destroy()
	end

	print(
		"EVO V7.4 closed. Run the loader again to reopen."
	)

end

CloseEVO.MouseButton1Click:Connect(function()

	CloseEVO.Text =
		"CLOSING EVO..."

	task.wait(
		0.08
	)

	CloseEVOScript()

end)

--========================================================--
-- MAIN LOOP
--========================================================--

RunService:BindToRenderStep(

	"EVO_V7_4_RENDER",

	Enum.RenderPriority.Camera.Value
	+
	5,

	function(Delta)

		local Mouse =
			UIS:GetMouseLocation()

		--================================================--
		-- FOV
		--================================================--

		FOVCircle.Position =
			UDim2.fromOffset(
				Mouse.X,
				Mouse.Y
			)

		FOVCircle.Size =
			UDim2.fromOffset(
				Config.FOV * 2,
				Config.FOV * 2
			)

		FOVCircle.Visible =
			Config.FOVCircle

		FOVStroke.Color =
			Accent()

		--================================================--
		-- THEME
		--================================================--

		Logo.TextColor3 =
			Accent()

		AccentLine.BackgroundColor3 =
			Accent()

		for _, Refresh in ipairs(
			ThemeRefreshers
		) do

			Refresh()

		end

		for Name, Button in pairs(
			TabButtons
		) do

			if Pages[Name].Visible then

				Button.TextColor3 =
					Accent()

			end

		end

		--================================================--
		-- SYSTEMS
		--================================================--

		UpdateCrosshair(
			Delta
		)

		UpdateESP()

		UpdateFly()

		UpdateSnow()

		UpdateSelectedPlayer()

		--================================================--
		-- AIMBOT
		--================================================--

		if Config.Aimbot
			and
			AimHeld
			and
			not ViewingPlayer then

			CurrentTarget =
				GetTarget()

		else

			CurrentTarget =
				nil

		end

		if CurrentTarget then

			local TargetPosition =
				CurrentTarget.Position

			if Config.Prediction then

				TargetPosition +=
					CurrentTarget
					.AssemblyLinearVelocity
					*
					Config.PredictionAmount

			end

			local Desired =
				CFrame.lookAt(
					Camera.CFrame.Position,
					TargetPosition
				)

			Camera.CFrame =
				Camera.CFrame:Lerp(
					Desired,
					Config.Smoothness
				)

		end

	end

)

UpdateSnow()

print("EVO V7.4 loaded.")
