--========================================================--
--                  EVO PRIVATE ACCESS
--========================================================--

do
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")

	local LocalPlayer = Players.LocalPlayer
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

	--====================================================--
	-- PASSWORD
	--====================================================--

	-- Hash de "evoisback"
	-- A senha NÃO aparece em texto puro no script.
	local PASSWORD_HASH = 3588656996

	local function HashPassword(Text)
		local Hash = 2166136261

		for I = 1, #Text do
			Hash = bit32.bxor(
				Hash,
				string.byte(Text, I)
			)

			Hash = (
				Hash * 16777619
			) % 4294967296
		end

		return Hash
	end

	--====================================================--
	-- REMOVE OLD LOGIN
	--====================================================--

	local OldGUI =
		PlayerGui:FindFirstChild(
			"EVO_PRIVATE_ACCESS"
		)

	if OldGUI then
		OldGUI:Destroy()
	end

	--====================================================--
	-- ACCESS EVENT
	--====================================================--

	local AccessGranted =
		Instance.new("BindableEvent")

	--====================================================--
	-- GUI
	--====================================================--

	local GUI =
		Instance.new("ScreenGui")

	GUI.Name =
		"EVO_PRIVATE_ACCESS"

	GUI.ResetOnSpawn =
		false

	GUI.IgnoreGuiInset =
		true

	GUI.ZIndexBehavior =
		Enum.ZIndexBehavior.Sibling

	GUI.DisplayOrder =
		999999

	GUI.Parent =
		PlayerGui

	--====================================================--
	-- BACKGROUND
	--====================================================--

	local Background =
		Instance.new("Frame")

	Background.Size =
		UDim2.fromScale(1, 1)

	Background.BackgroundColor3 =
		Color3.fromRGB(
			4,
			4,
			6
		)

	Background.BackgroundTransparency =
		0.12

	Background.BorderSizePixel =
		0

	Background.Parent =
		GUI

	--====================================================--
	-- MAIN
	--====================================================--

	local Main =
		Instance.new("Frame")

	Main.Size =
		UDim2.fromOffset(
			390,
			240
		)

	Main.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Main.Position =
		UDim2.fromScale(
			0.5,
			0.5
		)

	Main.BackgroundColor3 =
		Color3.fromRGB(
			9,
			9,
			11
		)

	Main.BorderSizePixel =
		0

	Main.Parent =
		Background

	local MainStroke =
		Instance.new("UIStroke")

	MainStroke.Color =
		Color3.fromRGB(
			38,
			38,
			42
		)

	MainStroke.Thickness =
		1

	MainStroke.Parent =
		Main

	--====================================================--
	-- TOP ACCENT
	--====================================================--

	local AccentLine =
		Instance.new("Frame")

	AccentLine.Size =
		UDim2.new(
			1,
			0,
			0,
			2
		)

	AccentLine.BackgroundColor3 =
		Color3.fromRGB(
			255,
			175,
			220
		)

	AccentLine.BorderSizePixel =
		0

	AccentLine.Parent =
		Main

	--====================================================--
	-- LOGO
	--====================================================--

	local Logo =
		Instance.new("TextLabel")

	Logo.Size =
		UDim2.new(
			1,
			-28,
			0,
			30
		)

	Logo.Position =
		UDim2.fromOffset(
			14,
			17
		)

	Logo.BackgroundTransparency =
		1

	Logo.Text =
		"EVO"

	Logo.TextColor3 =
		Color3.fromRGB(
			255,
			175,
			220
		)

	Logo.Font =
		Enum.Font.Code

	Logo.TextSize =
		18

	Logo.TextXAlignment =
		Enum.TextXAlignment.Left

	Logo.Parent =
		Main

	--====================================================--
	-- BUILD
	--====================================================--

	local Build =
		Instance.new("TextLabel")

	Build.Size =
		UDim2.new(
			1,
			-28,
			0,
			18
		)

	Build.Position =
		UDim2.fromOffset(
			14,
			43
		)

	Build.BackgroundTransparency =
		1

	Build.Text =
		"<3 evo  |  private access"

	Build.TextColor3 =
		Color3.fromRGB(
			110,
			110,
			120
		)

	Build.Font =
		Enum.Font.Code

	Build.TextSize =
		8

	Build.TextXAlignment =
		Enum.TextXAlignment.Left

	Build.Parent =
		Main

	--====================================================--
	-- DIVIDER
	--====================================================--

	local Divider =
		Instance.new("Frame")

	Divider.Size =
		UDim2.new(
			1,
			-28,
			0,
			1
		)

	Divider.Position =
		UDim2.fromOffset(
			14,
			69
		)

	Divider.BackgroundColor3 =
		Color3.fromRGB(
			30,
			30,
			33
		)

	Divider.BorderSizePixel =
		0

	Divider.Parent =
		Main

	--====================================================--
	-- PASSWORD LABEL
	--====================================================--

	local KeyLabel =
		Instance.new("TextLabel")

	KeyLabel.Size =
		UDim2.new(
			1,
			-28,
			0,
			17
		)

	KeyLabel.Position =
		UDim2.fromOffset(
			14,
			79
		)

	KeyLabel.BackgroundTransparency =
		1

	KeyLabel.Text =
		"ACCESS KEY"

	KeyLabel.TextColor3 =
		Color3.fromRGB(
			135,
			135,
			145
		)

	KeyLabel.Font =
		Enum.Font.Code

	KeyLabel.TextSize =
		8

	KeyLabel.TextXAlignment =
		Enum.TextXAlignment.Left

	KeyLabel.Parent =
		Main

	--====================================================--
	-- PASSWORD HOLDER
	--====================================================--

	local PasswordHolder =
		Instance.new("Frame")

	PasswordHolder.Size =
		UDim2.new(
			1,
			-28,
			0,
			38
		)

	PasswordHolder.Position =
		UDim2.fromOffset(
			14,
			100
		)

	PasswordHolder.BackgroundColor3 =
		Color3.fromRGB(
			15,
			15,
			18
		)

	PasswordHolder.BorderSizePixel =
		0

	PasswordHolder.Parent =
		Main

	local PasswordStroke =
		Instance.new("UIStroke")

	PasswordStroke.Color =
		Color3.fromRGB(
			38,
			38,
			42
		)

	PasswordStroke.Thickness =
		1

	PasswordStroke.Parent =
		PasswordHolder

	--====================================================--
	-- PASSWORD BOX
	--====================================================--

	local PasswordBox =
		Instance.new("TextBox")

	PasswordBox.Size =
		UDim2.new(
			1,
			-20,
			1,
			0
		)

	PasswordBox.Position =
		UDim2.fromOffset(
			10,
			0
		)

	PasswordBox.BackgroundTransparency =
		1

	PasswordBox.ClearTextOnFocus =
		false

	PasswordBox.PlaceholderText =
		"Enter your access key..."

	PasswordBox.PlaceholderColor3 =
		Color3.fromRGB(
			75,
			75,
			85
		)

	PasswordBox.Text =
		""

	PasswordBox.TextColor3 =
		Color3.fromRGB(
			235,
			235,
			240
		)

	PasswordBox.Font =
		Enum.Font.Code

	PasswordBox.TextSize =
		10

	PasswordBox.TextXAlignment =
		Enum.TextXAlignment.Left

	PasswordBox.Parent =
		PasswordHolder

	--====================================================--
	-- STATUS
	--====================================================--

	local Status =
		Instance.new("TextLabel")

	Status.Size =
		UDim2.new(
			1,
			-28,
			0,
			16
		)

	Status.Position =
		UDim2.fromOffset(
			14,
			144
		)

	Status.BackgroundTransparency =
		1

	Status.Text =
		"authentication required"

	Status.TextColor3 =
		Color3.fromRGB(
			85,
			85,
			95
		)

	Status.Font =
		Enum.Font.Code

	Status.TextSize =
		8

	Status.TextXAlignment =
		Enum.TextXAlignment.Left

	Status.Parent =
		Main

	--====================================================--
	-- LOGIN
	--====================================================--

	local Login =
		Instance.new("TextButton")

	Login.Size =
		UDim2.new(
			1,
			-28,
			0,
			36
		)

	Login.Position =
		UDim2.fromOffset(
			14,
			178
		)

	Login.BackgroundColor3 =
		Color3.fromRGB(
			255,
			175,
			220
		)

	Login.BorderSizePixel =
		0

	Login.Text =
		"AUTHENTICATE"

	Login.TextColor3 =
		Color3.fromRGB(
			12,
			10,
			12
		)

	Login.Font =
		Enum.Font.Code

	Login.TextSize =
		9

	Login.AutoButtonColor =
		false

	Login.Parent =
		Main

	--====================================================--
	-- HOVER
	--====================================================--

	Login.MouseEnter:Connect(function()

		TweenService:Create(
			Login,
			TweenInfo.new(
				0.12
			),
			{
				BackgroundColor3 =
					Color3.fromRGB(
						255,
						198,
						232
					)
			}
		):Play()

	end)

	Login.MouseLeave:Connect(function()

		TweenService:Create(
			Login,
			TweenInfo.new(
				0.12
			),
			{
				BackgroundColor3 =
					Color3.fromRGB(
						255,
						175,
						220
					)
			}
		):Play()

	end)

	--====================================================--
	-- SHAKE
	--====================================================--

	local Shaking =
		false

	local function Shake()

		if Shaking then
			return
		end

		Shaking =
			true

		local Original =
			Main.Position

		local Offsets = {
			-8,
			8,
			-6,
			6,
			-4,
			4,
			-2,
			2,
			0
		}

		for _, X in ipairs(
			Offsets
		) do

			Main.Position =
				Original
				+
				UDim2.fromOffset(
					X,
					0
				)

			task.wait(
				0.025
			)

		end

		Main.Position =
			Original

		Shaking =
			false

	end

	--====================================================--
	-- WRONG KEY
	--====================================================--

	local function WrongKey()

		Status.Text =
			"invalid access key"

		Status.TextColor3 =
			Color3.fromRGB(
				255,
				85,
				105
			)

		PasswordStroke.Color =
			Color3.fromRGB(
				180,
				55,
				70
			)

		task.spawn(
			Shake
		)

		task.delay(
			1.15,
			function()

				if GUI.Parent then

					Status.Text =
						"authentication required"

					Status.TextColor3 =
						Color3.fromRGB(
							85,
							85,
							95
						)

					PasswordStroke.Color =
						Color3.fromRGB(
							38,
							38,
							42
						)

				end

			end
		)

	end

	--====================================================--
	-- CHECK PASSWORD
	--====================================================--

	local Authenticated =
		false

	local function Authenticate()

		if Authenticated then
			return
		end

		local EnteredHash =
			HashPassword(
				PasswordBox.Text
			)

		if EnteredHash ~=
			PASSWORD_HASH then

			WrongKey()

			return
		end

		Authenticated =
			true

		PasswordBox.TextEditable =
			false

		Login.Active =
			false

		Login.Text =
			"ACCESS GRANTED"

		Status.Text =
			"authentication successful"

		Status.TextColor3 =
			Color3.fromRGB(
				95,
				255,
				145
			)

		PasswordStroke.Color =
			Color3.fromRGB(
				75,
				210,
				130
			)

		MainStroke.Color =
			Color3.fromRGB(
				75,
				210,
				130
			)

		task.wait(
			0.35
		)

		Status.Text =
			"initializing evo..."

		Login.Text =
			"LOADING EVO"

		task.wait(
			0.45
		)

		AccessGranted:Fire()

	end

	--====================================================--
	-- EVENTS
	--====================================================--

	Login.MouseButton1Click:Connect(
		Authenticate
	)

	PasswordBox.FocusLost:Connect(function(
		EnterPressed
	)

		if EnterPressed then

			Authenticate()

		end

	end)

	task.delay(
		0.25,
		function()

			if PasswordBox.Parent then

				PasswordBox:
					CaptureFocus()

			end

		end
	)

	--====================================================--
	-- IMPORTANT
	--
	-- O SCRIPT PARA AQUI.
	-- O EVO ABAIXO AINDA NÃO EXECUTA.
	--====================================================--

	AccessGranted.Event:Wait()

	--====================================================--
	-- LOGIN SUCCESS
	--====================================================--

	TweenService:Create(
		Main,
		TweenInfo.new(
			0.18
		),
		{
			BackgroundTransparency =
				1
		}
	):Play()

	task.wait(
		0.2
	)

	GUI:Destroy()

	AccessGranted:Destroy()

end


--========================================================--
--========================================================--
--                                                        --
--                 EVO HUB COMEÇA AQUI                    --
--                                                        --
--========================================================--
--========================================================--


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

-- DAQUI PARA BAIXO CONTINUA EXATAMENTE
-- TODO O RESTANTE DO SEU EVO.LUA ATUAL.
