--//==================================================\\--
--||            Nescau Hub Master v1.3 Gamer RGB      ||--
--||   Tema Neon + Loading Funcional + Jogos          ||--
--||     Estruturado e modulado por @Dr.Legado        ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Remover hub antigo se já existir
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Tema Gamer Neon
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

local function AnimateRGB(obj)
    task.spawn(function()
        local hue = 0
        while obj.Parent do
            hue = (hue + 1) % 360
            obj.Color = Color3.fromHSV(hue/360,1,1)
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

-- Loading Funcional
task.spawn(function()
    local progress = 0
    local startTime = tick()
    while progress < 100 do
        local dt = tick() - startTime
        progress = math.min(100, math.floor(dt*20)) -- 5 segundos até 100%
        LoadingProgress.Text = progress.."%"
        Fill.Size = UDim2.new(progress/100,0,1,0)
        RunService.RenderStepped:Wait()
    end
    task.wait(0.3)
    Splash:Destroy()
end)

--==================================================--
--                  Estrutura Hub
--==================================================--
local MainFrame = Instance.new("Frame")
MainFrame.Parent = Hub
MainFrame.Size = UDim2.new(0, 620, 0, 400)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -200)
MainFrame.BackgroundColor3 = Theme.Background
AddCorner(MainFrame, 12)
local mainGlow = AddGlow(MainFrame, Theme.Accent)
AnimateRGB(mainGlow)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
AddCorner(Sidebar, 12)

local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.Size = UDim2.new(1, -160, 1, 0)
Content.Position = UDim2.new(0, 160, 0, 0)
Content.BackgroundTransparency = 1

--==================================================--
--                  Criar Páginas
--==================================================--
local Panels = {}
local function CreatePage(name)
    local page = Instance.new("Frame")
    page.Parent = Content
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    Panels[name] = page

    local label = Instance.new("TextLabel")
    label.Parent = page
    label.Position = UDim2.new(0,20,0,20)
    label.Size = UDim2.new(1,-40,0,40)
    label.Text = name
    label.Font = Enum.Font.GothamBold
    label.TextSize = 22
    label.TextColor3 = Theme.Accent
    label.BackgroundTransparency = 1

    return page
end

local menuPage = CreatePage("Menu")
local jogosPage = CreatePage("Jogos")
local configPage = CreatePage("Configurações")
local alteracoesPage = CreatePage("Alterações / Correções")

--==================================================--
--                  Botão Criar
--==================================================--
local function CreateButton(text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, (#parent:GetChildren()-1)*50)
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
        for _,v in pairs(Content:GetChildren()) do
            if v:IsA("Frame") then v.Visible=false end
        end
        if callback then callback() end
    end)

    return btn
end

--==================================================--
--                  Menu Alterações
--==================================================--
local changelog = Instance.new("TextLabel")
changelog.Parent = alteracoesPage
changelog.Position = UDim2.new(0,20,0,60)
changelog.Size = UDim2.new(1,-40,1,-80)
changelog.Text = [[
✔ Tema Neon RGB aplicado
✔ Tela de carregamento funcional
✔ Botões com efeito hover neon
✔ Alterações e correções exibidas aqui
✔ Scripts de jogos adicionados: 99 Noites, BloxFruits, Roube um Brainrot, Grow a Garden
✔ Visual modernizado com glow neon
]]
changelog.Font = Enum.Font.Gotham
changelog.TextSize = 16
changelog.TextColor3 = Theme.Text
changelog.BackgroundTransparency = 1
changelog.TextWrapped = true

--==================================================--
--                  Botões Sidebar
--==================================================--
CreateButton("Menu", Sidebar, function() menuPage.Visible=true end)
CreateButton("Jogos", Sidebar, function() jogosPage.Visible=true end)
CreateButton("Configurações", Sidebar, function() configPage.Visible=true end)
CreateButton("Alterações", Sidebar, function() alteracoesPage.Visible=true end)

-- Mostrar menu inicial
menuPage.Visible = true

--==================================================--
--                  Adicionar Scripts de Jogos
--==================================================--
local function CreateScriptPanel(nome, scripts)
    local painel = Instance.new("ScrollingFrame")
    painel.Parent = Content
    painel.Size = UDim2.new(1,0,1,0)
    painel.Visible = false
    painel.BackgroundTransparency = 1
    painel.ScrollBarThickness = 6
    painel.CanvasSize = UDim2.new(0,0,0,#scripts*50)
    Panels[nome.."Scripts"] = painel

    for i,scriptData in ipairs(scripts) do
        local btn = CreateButton(scriptData.Nome, painel, function()
            loadstring(game:HttpGet(scriptData.Link,true))()
        end)
        btn.Position = UDim2.new(0,10,0,(i-1)*45)
    end
end

-- Scripts 99 Noites
local Scripts99 = {
    {Nome="H4XScripts(key)", Link="https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua"},
    {Nome="SpaceHub", Link="https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/loader.lua"},
    {Nome="SpeedHubX(key)", Link="https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}
}
CreateScriptPanel("99 Noites", Scripts99)

-- Scripts BloxFruits
local ScriptsBloxFruits = {
    {Nome="Alchemy Hub Script", Link="https://scripts.alchemyhub.xyz"},
    {Nome="Banana Cat Hub", Link="https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"}
}
CreateScriptPanel("BloxFruits", ScriptsBloxFruits)

-- Scripts Roube Brainrot
local ScriptsRoubeBrainrot = {
    {Nome="Script Steal a Brainrot", Link="https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/StealaBrainrot"},
}
CreateScriptPanel("RoubeUmBrainrot", ScriptsRoubeBrainrot)

-- Scripts Grow a Garden
local ScriptsGrowAGarden = {
    {Nome="AVOnTop No Key", Link="https://raw.githubusercontent.com/Ayvathion/AV-On-Top/refs/heads/main/Loader.lua"}
}
CreateScriptPanel("GrowAGarden", ScriptsGrowAGarden)
