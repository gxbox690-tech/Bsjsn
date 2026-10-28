--[[-
    nox_zu1 Ultimate Head Aimbot & Guaranteed WallHack ESP (Delta Executor)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعدادات السكربت
local Settings = {
    AimbotEnabled = false,
    FOV = 180,
    Smoothness = 0, -- تثبيت فوري ولاصق 100%
    TargetPart = "Head", -- التصويب على الرأس
    WallCheck = true,
    TeamCheck = false, -- يبدأ معطلاً حسب طلبك
    ESPEnabled = true
}

-- تنظيف أي واجهة قديمة
pcall(function()
    if CoreGui:FindFirstChild("NoxAimbotGUI") then
        CoreGui.NoxAimbotGUI:Destroy()
    end
end)

-- إنشاء الواجهة الرسومية الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoxAimbotGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- 1. أنيميشن البداية باسم nox_zu1 مع الغراب
local function PlayNoxIntro()
    local IntroGui = Instance.new("ScreenGui")
    IntroGui.Name = "NoxIntro"
    IntroGui.Parent = CoreGui

    local DarkBg = Instance.new("Frame")
    DarkBg.Parent = IntroGui
    DarkBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    DarkBg.BackgroundTransparency = 1
    DarkBg.Size = UDim2.new(1, 0, 1, 0)
    DarkBg.BorderSizePixel = 0

    local NoxText = Instance.new("TextLabel")
    NoxText.Parent = IntroGui
    NoxText.BackgroundTransparency = 1
    NoxText.Position = UDim2.new(0.5, -200, 0.5, -50)
    NoxText.Size = UDim2.new(0, 400, 0, 100)
    NoxText.Font = Enum.Font.SourceSansBold
    NoxText.Text = "🦅 [ nox_zu1 Script ] 🦅\nجاري تفعيل كشف الجدران الشامل..."
    NoxText.TextColor3 = Color3.fromRGB(0, 170, 255)
    NoxText.TextSize = 22
    NoxText.TextTransparency = 1

    TweenService:Create(DarkBg, TweenInfo.new(0.6), {BackgroundTransparency = 0.4}):Play()
    TweenService:Create(NoxText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()

    task.wait(2.2)

    TweenService:Create(DarkBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(NoxText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()

    task.wait(0.6)
    IntroGui:Destroy()
end

task.spawn(PlayNoxIntro)

-- 2. الزر العائم
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "FloatingButton"
FloatingBtn.Parent = ScreenGui
FloatingBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
FloatingBtn.BorderSizePixel = 0
FloatingBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
FloatingBtn.Font = Enum.Font.SourceSansBold
FloatingBtn.Text = "OFF"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
FloatingBtn.TextSize = 14
FloatingBtn.Active = true
FloatingBtn.Draggable = true

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = FloatingBtn

-- 3. زر القائمة
local MenuBtn = Instance.new("TextButton")
MenuBtn.Name = "MenuButton"
MenuBtn.Parent = ScreenGui
MenuBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MenuBtn.BorderSizePixel = 0
MenuBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
MenuBtn.Size = UDim2.new(0, 50, 0, 30)
MenuBtn.Font = Enum.Font.SourceSansBold
MenuBtn.Text = "MENU"
MenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuBtn.TextSize = 12
MenuBtn.Active = true
MenuBtn.Draggable = true

local UICornerMenu = Instance.new("UICorner")
UICornerMenu.CornerRadius = UDim.new(0, 6)
UICornerMenu.Parent = MenuBtn

-- 4. نافذة التحكم الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = Color3.fromRGB(0, 170, 255)
UIStrokeMain.Thickness = 2
UIStrokeMain.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "✨ nox_zu1 - أيم وكشف جدران فوري ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15

local CloseMenuBtn = Instance.new("TextButton")
CloseMenuBtn.Parent = MainFrame
CloseMenuBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
CloseMenuBtn.Position = UDim2.new(0.85, 0, 0, 15)
CloseMenuBtn.Size = UDim2.new(0, 30, 0, 30)
CloseMenuBtn.Text = "X"
CloseMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseMenuBtn.TextSize = 14

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseMenuBtn

local isOpen = false
local function ToggleMenu()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 300, 0, 260),
            Position = UDim2.new(0.5, -150, 0.5, -130)
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not isOpen then MainFrame.Visible = false end
        end)
    end
end

CloseMenuBtn.MouseButton1Click:Connect(ToggleMenu)
MenuBtn.MouseButton1Click:Connect(ToggleMenu)

FloatingBtn.MouseButton1Click:Connect(function()
    Settings.AimbotEnabled = not Settings.AimbotEnabled
    
    TweenService:Create(FloatingBtn, TweenInfo.new(0.15), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    task.wait(0.15)
    TweenService:Create(FloatingBtn, TweenInfo.new(0.15), {Size = UDim2.new(0, 50, 0, 50)}):Play()

    if Settings.AimbotEnabled then
        FloatingBtn.Text = "ON"
        FloatingBtn.TextColor3 = Color3.fromRGB(60, 255, 60)
        FloatingBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
    else
        FloatingBtn.Text = "OFF"
        FloatingBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
        FloatingBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
    end
end)

local function CreateToggle(name, posY, initialVal, callback)
    local Label = Instance.new("TextLabel")
    Label.Parent = MainFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.1, 0, 0, posY)
    Label.Size = UDim2.new(0.5, 0, 0, 25)
    Label.Font = Enum.Font.SourceSans
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = MainFrame
    ToggleBtn.BackgroundColor3 = initialVal and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(170, 50, 50)
    ToggleBtn.Position = UDim2.new(0.65, 0, 0, posY)
    ToggleBtn.Size = UDim2.new(0, 70, 0, 24)
    ToggleBtn.Font = Enum.Font.SourceSansBold
    ToggleBtn.Text = initialVal and "ON" or "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 12

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = ToggleBtn

    ToggleBtn.MouseButton1Click:Connect(function()
        initialVal = not initialVal
        ToggleBtn.Text = initialVal and "ON" or "OFF"
        ToggleBtn.BackgroundColor3 = initialVal and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(170, 50, 50)
        callback(initialVal)
    end)
end

CreateToggle("فحص الجدران (WallCheck)", 55, Settings.WallCheck, function(v) Settings.WallCheck = v end)
CreateToggle("تحديد الأعداء (Blue ESP)", 95, Settings.ESPEnabled, function(v) 
    Settings.ESPEnabled = v
    if not v then
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("NoxHighlight") then
                player.Character.NoxHighlight:Destroy()
            end
        end
    end
end)
CreateToggle("فحص الفريق (TeamCheck)", 135, Settings.TeamCheck, function(v) Settings.TeamCheck = v end)

-- سلايدر الـ FOV
local FovLabel = Instance.new("TextLabel")
FovLabel.Parent = MainFrame
FovLabel.BackgroundTransparency = 1
FovLabel.Position = UDim2.new(0.1, 0, 0, 175)
FovLabel.Size = UDim2.new(0.8, 0, 0, 20)
FovLabel.Font = Enum.Font.SourceSans
FovLabel.Text = "نطاق الرؤية (FOV): " .. Settings.FOV
FovLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FovLabel.TextSize = 13
FovLabel.TextXAlignment = Enum.TextXAlignment.Left

local SliderBar = Instance.new("TextButton")
SliderBar.Parent = MainFrame
SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBar.Position = UDim2.new(0.1, 0, 0, 200)
SliderBar.Size = UDim2.new(0.8, 0, 0, 8)
SliderBar.Text = ""

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = SliderBar

local Fill = Instance.new("Frame")
Fill.Parent = SliderBar
Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Fill.Size = UDim2.new((Settings.FOV - 50) / 350, 0, 1, 0)
Fill.BorderSizePixel = 0

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = Fill

local dragging = false
SliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Settings.FOV = math.floor(50 + (400 - 50) * pos)
        FovLabel.Text = "نطاق الرؤية (FOV): " .. Settings.FOV
    end
end)

-- دائرة الـ FOV المرئية
local FOVFrame = Instance.new("Frame")
FOVFrame.Name = "FOVCircle"
FOVFrame.Parent = ScreenGui
FOVFrame.BackgroundTransparency = 1
FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FOVFrame.Position = UDim2.new(0.5, 0, 0.45, 0)

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = FOVFrame

local UICornerCircle = Instance.new("UICorner")
UICornerCircle.CornerRadius = UDim.new(1, 0)
UICornerCircle.Parent = FOVFrame

local function IsVisible(targetPart)
    if not Settings.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then
        local hitCharacter = result.Instance:FindFirstAncestorOfClass("Model")
        if hitCharacter and hitCharacter == targetPart.Parent then
            return true
        end
        return false
    end
    return true
end

local function GetClosestPlayer()
    local target = nil
    local shortestDistance = Settings.FOV

    pcall(function()
        local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y * 0.45)

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if not Settings.TeamCheck or (player.Team ~= LocalPlayer.Team) then
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                        local part = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
                        if part then
                            local screenPoint, onScreen = Camera:WorldToViewportPoint(part.Position)
                            if onScreen and IsVisible(part) then
                                local vectorDist = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                                if vectorDist < shortestDistance then
                                    shortestDistance = vectorDist
                                    target = part
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    return target
end

-- التشغيل والتحديث المستمر (Highlight قوي يظهر من خلف الجدران فور تفعيله)
RunService.RenderStepped:Connect(function()
    pcall(function()
        FOVFrame.Visible = Settings.AimbotEnabled
        FOVFrame.Size = UDim2.new(0, Settings.FOV * 2, 0, Settings.FOV * 2)

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local character = player.Character
                local isAlive = character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0
                local highlight = character and character:FindFirstChild("NoxHighlight")
                
                -- فحص ما إذا كان يجب تطبيق الكشف أم لا
                local shouldShow = Settings.ESPEnabled and isAlive

                if shouldShow then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "NoxHighlight"
                        highlight.Adornee = character
                        highlight.FillColor = Color3.fromRGB(0, 120, 255)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- الأسرع والأقوى لإظهارهم من خلف الجدران
                        highlight.Parent = character
                    end
                else
                    if highlight then 
                        highlight:Destroy() 
                    end
                end
            end
        end

        -- تثبيت فوري على الرأس
        if Settings.AimbotEnabled then
            local targetPart = GetClosestPlayer()
            if targetPart then
                local currentCFrame = Camera.CFrame
                local targetCFrame = CFrame.new(currentCFrame.Position, targetPart.Position)
                Camera.CFrame = targetCFrame
            end
        end
    end)
end)
