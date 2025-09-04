--//==================================================\\--
--||            Nescau Hub Master v1.1 Gamer RGB      ||--
--||   Tema RGB Neon Animado + Tela de Loading        ||--
--||     Estruturado e modulado por @Dr.Legado        ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Remover hub antigo se já existir
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Tema base
local Theme = {
    Background = Color3.fromRGB(10,10,15),
    Topbar = Color3.fromRGB(15,15,20),
    Sidebar = Color3.fromRGB(20,20,30),
    Button = Color3.fromRGB(30,30,40),
    ButtonHover = Color3.fromRGB(80,20,100),
    Text = Color3.fromRGB(255,255,255),
    Accent = Color3.fromRGB(0,255,180)
}

-- Funções utilitárias
local function AddCorner(obj, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, radius)
    UICorner.Parent = obj
end

local function AddGlow(obj, color)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = color
    UIStroke.Thickness = 2
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Outside
    UIStroke.Transparency = 0.3
    UIStroke.Parent = obj
    return UIStroke
end

-- Função RGB animado
local function AnimateRGB(obj)
    task.spawn(function()
        local hue = 0
        while obj.Parent do
            hue = (hue + 1) % 360
            local color = Color3.fromHSV(hue/360,1,1)
            obj.Color = color
            task.wait(0.03)
        end
    end)
end

-- Hub principal
local Hub = Instance.new("ScreenGui")
Hub.Name = "NescauHub"
Hub.Parent = CoreGui
Hub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Hub.ResetOnSpawn = false

--==================================================--
--                  Tela de Loading
--==================================================--
local Splash = Instance.new("Frame")
Splash.Size = UDim2.new(1,0,1,0)
Splash.BackgroundColor3 = Theme.Background
Splash.Parent = Hub
Splash.ZIndex = 100

local SplashLabel = Instance.new("TextLabel")
SplashLabel.Parent = Splash
SplashLabel.AnchorPoint = Vector2.new(0.5,0.5)
SplashLabel.Position = UDim2.new(0.5,0,0.4,0)
SplashLabel.Size = UDim2.new(0,500,0,50)
SplashLabel.Text = "🚀 Carregando Nescau Hub Gamer..."
SplashLabel.Font = Enum.Font.GothamBold
SplashLabel.TextSize = 26
SplashLabel.TextColor3 = Theme.Accent
SplashLabel.BackgroundTransparency = 1

local LoadingProgress = Instance.new("TextLabel")
LoadingProgress.Parent = Splash
LoadingProgress.AnchorPoint = Vector2.new(0.5,0.5)
LoadingProgress.Position = UDim2.new(0.5,0,0.55,0)
LoadingProgress.Size = UDim2.new(0,200,0,30)
LoadingProgress.Text = "0%"
LoadingProgress.Font = Enum.Font.Gotham
LoadingProgress.TextSize = 20
LoadingProgress.TextColor3 = Theme.Text
LoadingProgress.BackgroundTransparency = 1

local ProgressBar = Instance.new("Frame")
ProgressBar.Parent = Splash
ProgressBar.AnchorPoint = Vector2.new(0.5,0.5)
ProgressBar.Position = UDim2.new(0.5,0,0.65,0)
ProgressBar.Size = UDim2.new(0,350,0,12)
ProgressBar.BackgroundColor3 = Theme.Button
AddCorner(ProgressBar, 8)

local Fill = Instance.new("Frame")
Fill.Parent = ProgressBar
Fill.Size = UDim2.new(0,0,1,0)
Fill.BackgroundColor3 = Theme.Accent
AddCorner(Fill, 8)
local fillStroke = AddGlow(Fill, Theme.Accent)
AnimateRGB(fillStroke)

-- Barra animada
task.spawn(function()
    for i=1,100 do
        LoadingProgress.Text = i.."%"
        TweenService:Create(Fill,TweenInfo.new(0.02),{Size=UDim2.new(i/100,0,1,0)}):Play()
        task.wait(0.02)
    end
    task.wait(0.3)
    Splash:Destroy()
end)

--==================================================--
--                  Estrutura Hub
--==================================================--
local MainFrame = Instance.new("Frame")
MainFrame.Parent = Hub
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Theme.Background
AddCorner(MainFrame, 12)
local mainGlow = AddGlow(MainFrame, Theme.Accent)
AnimateRGB(mainGlow)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
AddCorner(Sidebar, 12)

local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.Size = UDim2.new(1, -150, 1, 0)
Content.Position = UDim2.new(0, 150, 0, 0)
Content.BackgroundColor3 = Theme.Topbar
AddCorner(Content, 12)

--==================================================--
--                  Função Criar Botão
--==================================================--
local function CreateButton(text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 50)
    btn.BackgroundColor3 = Theme.Button
    btn.TextColor3 = Theme.Text
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    AddCorner(btn, 8)
    local glow = AddGlow(btn, Theme.Accent)
    AnimateRGB(glow)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ButtonHover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Button}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(Content:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        if callback then callback() end
    end)

    return btn
end

--==================================================--
--                  Criar Páginas
--==================================================--
local function CreatePage(name)
    local page = Instance.new("Frame")
    page.Parent = Content
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false

    local label = Instance.new("TextLabel")
    label.Parent = page
    label.AnchorPoint = Vector2.new(0.5,0.5)
    label.Position = UDim2.new(0.5,0,0.5,0)
    label.Size = UDim2.new(1,-20,0,50)
    label.Text = name.." 🚀"
    label.Font = Enum.Font.GothamBold
    label.TextSize = 28
    label.TextColor3 = Theme.Accent
    label.BackgroundTransparency = 1

    return page
end

-- Criar páginas
local menuPage = CreatePage("Menu")
local jogosPage = CreatePage("Jogos")
local configPage = CreatePage("Configurações")
local alteracoesPage = CreatePage("Alterações / Correções")

--==================================================--
--                  Menu Alterações
--==================================================--
local changelog = Instance.new("TextLabel")
changelog.Parent = alteracoesPage
changelog.AnchorPoint = Vector2.new(0.5,0.5)
changelog.Position = UDim2.new(0.5,0,0.5,0)
changelog.Size = UDim2.new(1,-40,1,-40)
changelog.Text = [[
✔ Tema RGB Gamer aplicado
✔ Tela de carregamento animada
✔ Botões com efeito hover neon
✔ Aba de correções adicionada ao menu
✔ Visual modernizado com glow neon
]]
changelog.Font = Enum.Font.Gotham
changelog.TextSize = 20
changelog.TextColor3 = Theme.Text
changelog.BackgroundTransparency = 1
changelog.TextWrapped = true

--==================================================--
--                  Sidebar Botões
--==================================================--
CreateButton("Menu", Sidebar, function() menuPage.Visible = true end)
CreateButton("Jogos", Sidebar, function() jogosPage.Visible = true end)
CreateButton("Config", Sidebar, function() configPage.Visible = true end)
CreateButton("Alterações", Sidebar, function() alteracoesPage.Visible = true end)

-- Mostrar menu inicial
menuPage.Visible = true
