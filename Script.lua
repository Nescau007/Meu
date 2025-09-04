--//==================================================\\--
--||            Nescau Hub Master v0.4               ||--
--||   Agora com Tela de Carregamento + Animações    ||--
--||     Estruturado e modulado por @Dr.Legado       ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Remover hub antigo
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Tema cinza escuro
local Theme = {
    Background = Color3.fromRGB(20,20,20),
    Topbar = Color3.fromRGB(35,35,35),
    Sidebar = Color3.fromRGB(28,28,28),
    Button = Color3.fromRGB(45,45,45),
    ButtonHover = Color3.fromRGB(70,70,70),
    Text = Color3.fromRGB(230,230,230),
    Accent = Color3.fromRGB(150,150,150)
}

-- Funções auxiliares
local function AddCorner(obj,radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0,radius)
    UICorner.Parent = obj
end
local function AddShadow(obj,opacity)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(0,0,0)
    UIStroke.Thickness = 1
    UIStroke.Transparency = opacity or 0.6
    UIStroke.Parent = obj
end

-- Hub principal
local Hub = Instance.new("ScreenGui")
Hub.Name = "NescauHub"
Hub.Parent = CoreGui
Hub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Hub.ResetOnSpawn = false

--=========================--
-- Tela de Carregamento
--=========================--
local Splash = Instance.new("Frame")
Splash.Size = UDim2.new(1,0,1,0)
Splash.BackgroundColor3 = Theme.Background
Splash.Parent = Hub
Splash.ZIndex = 100

local SplashLabel = Instance.new("TextLabel")
SplashLabel.Parent = Splash
SplashLabel.AnchorPoint = Vector2.new(0.5,0.5)
SplashLabel.Position = UDim2.new(0.5,0,0.45,0)
SplashLabel.Size = UDim2.new(0,400,0,50)
SplashLabel.Text = "✨ Bem-vindo ao Nescau Hub!"
SplashLabel.Font = Enum.Font.GothamBold
SplashLabel.TextSize = 22
SplashLabel.TextColor3 = Theme.Accent
SplashLabel.BackgroundTransparency = 1

local LoadingProgress = Instance.new("TextLabel")
LoadingProgress.Parent = Splash
LoadingProgress.AnchorPoint = Vector2.new(0.5,0.5)
LoadingProgress.Position = UDim2.new(0.5,0,0.55,0)
LoadingProgress.Size = UDim2.new(0,200,0,30)
LoadingProgress.Text = "0%"
LoadingProgress.Font = Enum.Font.Gotham
LoadingProgress.TextSize = 18
LoadingProgress.TextColor3 = Theme.Text
LoadingProgress.BackgroundTransparency = 1

task.spawn(function()
    for i = 0, 100 do
        LoadingProgress.Text = i.."%"
        task.wait(0.04)
    end
    task.wait(0.3)
    TweenService:Create(Splash, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    TweenService:Create(SplashLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingProgress, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    Splash:Destroy()
end)

--=========================--
-- Botão flutuante
--=========================--
local FloatBtn = Instance.new("TextButton")
FloatBtn.Name = "FloatBtn"
FloatBtn.Parent = Hub
FloatBtn.Size = UDim2.new(0,120,0,40)
FloatBtn.Position = UDim2.new(0,20,0,200)
FloatBtn.BackgroundColor3 = Theme.Accent
FloatBtn.TextColor3 = Theme.Text
FloatBtn.Text = "Abrir Hub"
FloatBtn.Visible = false
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextSize = 14
AddCorner(FloatBtn,8)
AddShadow(FloatBtn,0.5)

--=========================--
-- Janela principal
--=========================--
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = Hub
MainFrame.Size = UDim2.new(0,620,0,370)
MainFrame.Position = UDim2.new(0.5,-310,0.5,-185)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
AddCorner(MainFrame,10)
AddShadow(MainFrame,0.7)

-- Barra superior
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.Size = UDim2.new(1,0,0,35)
Topbar.BackgroundColor3 = Theme.Topbar
Topbar.BorderSizePixel = 0
AddCorner(Topbar,10)

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.Text = "🌌 Nescau Hub Master v0.4"
Title.Size = UDim2.new(1,-120,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Theme.Text

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Topbar
MinBtn.Size = UDim2.new(0,40,1,-6)
MinBtn.Position = UDim2.new(1,-85,0,3)
MinBtn.BackgroundColor3 = Theme.Button
MinBtn.TextColor3 = Theme.Text
MinBtn.Text = "–"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BorderSizePixel = 0
AddCorner(MinBtn,6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Topbar
CloseBtn.Size = UDim2.new(0,40,1,-6)
CloseBtn.Position = UDim2.new(1,-45,0,3)
CloseBtn.BackgroundColor3 = Theme.Button
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
AddCorner(CloseBtn,6)

-- Conteúdo principal
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.Size = UDim2.new(1,-160,1,-35)
Content.Position = UDim2.new(0,160,0,35)
Content.BackgroundTransparency = 1

local Panels = {}
local CurrentPanel = nil

local function ShowPanel(name)
    for k,v in pairs(Panels) do
        if k==name then
            v.Visible=true
            v.BackgroundTransparency=1
            TweenService:Create(v,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundTransparency=0}):Play()
            CurrentPanel=v
        else
            if v.Visible then
                TweenService:Create(v,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundTransparency=1}):Play()
                task.delay(0.5,function() v.Visible=false end)
            end
        end
    end
end

--=========================--
-- Barra lateral
--=========================--
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0,160,1,-35)
Sidebar.Position = UDim2.new(0,0,0,35)
Sidebar.BackgroundColor3 = Theme.Sidebar
AddCorner(Sidebar,10)

local function CreateButton(text,parent)
    local btn=Instance.new("TextButton")
    btn.Parent=parent
    btn.Size=UDim2.new(1,-20,0,40)
    btn.Position=UDim2.new(0,10,0,(#parent:GetChildren()-1)*50)
    btn.BackgroundColor3=Theme.Button
    btn.TextColor3=Theme.Text
    btn.Text=text
    btn.Font=Enum.Font.Gotham
    btn.TextSize=15
    btn.BorderSizePixel=0
    btn.AutoButtonColor=false
    AddCorner(btn,6)
    AddShadow(btn,0.6)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3=Theme.ButtonHover end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3=Theme.Button end)
    return btn
end

--=========================--
-- PAINEL MENU
--=========================--
local MenuPanel = Instance.new("Frame")
MenuPanel.Size=UDim2.new(1,0,1,0)
MenuPanel.BackgroundTransparency=1
MenuPanel.Parent=Content
Panels["Menu"]=MenuPanel

local MenuLabel = Instance.new("TextLabel")
MenuLabel.Parent=MenuPanel
MenuLabel.Size=UDim2.new(1,0,0,50)
MenuLabel.Text="✨ Bem-vindo ao Nescau Hub!"
MenuLabel.BackgroundTransparency=1
MenuLabel.Font=Enum.Font.Gotham
MenuLabel.TextSize=20
MenuLabel.TextColor3=Theme.Accent

local ChangesLog = Instance.new("TextLabel")
ChangesLog.Parent=MenuPanel
ChangesLog.Size=UDim2.new(1,-20,1,-60)
ChangesLog.Position=UDim2.new(0,10,0,60)
ChangesLog.BackgroundTransparency=1
ChangesLog.TextXAlignment=Enum.TextXAlignment.Left
ChangesLog.TextYAlignment=Enum.TextYAlignment.Top
ChangesLog.Font=Enum.Font.Gotham
ChangesLog.TextSize=14
ChangesLog.TextColor3=Theme.Text
ChangesLog.TextWrapped=true
ChangesLog.Text=[[
Últimas Alterações e Melhorias:
--------------------------------
- Todos os jogos integrados: 99 Noites, BloxFruits, Roube um Brainrot, Grow a Garden.
- Tela de carregamento funcional 0-100%.
- Tema cinza escuro.
- Painéis de scripts completos.
]]

--=========================--
-- PAINEL JOGOS
--=========================--
local JogosPanel = Instance.new("Frame")
JogosPanel.Size=UDim2.new(1,0,1,0)
JogosPanel.BackgroundTransparency=1
JogosPanel.Parent=Content
JogosPanel.Visible=false
Panels["Jogos"]=JogosPanel

local SearchBox = Instance.new("TextBox")
SearchBox.Parent=JogosPanel
SearchBox.Size=UDim2.new(1,-20,0,35)
SearchBox.Position=UDim2.new(0,10,0,10)
SearchBox.PlaceholderText="🔎 Pesquisar jogo..."
SearchBox.Text=""
SearchBox.BackgroundColor3=Theme.Button
SearchBox.TextColor3=Theme.Text
SearchBox.Font=Enum.Font.Gotham
SearchBox.TextSize=14
SearchBox.BorderSizePixel=0
AddCorner(SearchBox,6)
AddShadow(SearchBox,0.3)

local JogosList = Instance.new("Frame")
JogosList.Parent=JogosPanel
JogosList.Size=UDim2.new(1,-20,1,-60)
JogosList.Position=UDim2.new(0,10,0,50)
JogosList.BackgroundTransparency=1

local JogosBotoes={}

local function CriarPainelDeScripts(nome,scripts)
    local painel = Instance.new("ScrollingFrame")
    painel.Name=nome.."Scripts"
    painel.Parent=Content
    painel.Size=UDim2.new(1,0,1,0)
    painel.Visible=false
    painel.BackgroundTransparency=1
    painel.ScrollBarThickness=6
    painel.CanvasSize=UDim2.new(0,0,#scripts*50,0)
    Panels[painel.Name]=painel

    for i,scriptData in ipairs(scripts) do
        local ScriptBtn=CreateButton(scriptData.Nome,painel)
        ScriptBtn.Position=UDim2.new(0,10,0,(i-1)*45)
        ScriptBtn.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(scriptData.Link,true))()
        end)
    end
end

--=========================--
-- JOGOS E SCRIPTS COMPLETOS
--=========================--
local AllScripts={
    ["99 Noites"]={
        {Nome="SpaceHub",Link="https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/loader.lua"},
        {Nome="SpeedHubX",Link="https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"}
    },
    ["BloxFruits"]={
        {Nome="BloxFruit Hub",Link="https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
        {Nome="Another Blox",Link="https://raw.githubusercontent.com/BloxHub/Scripts/main/BloxFruitLoader.lua"}
    },
    ["Roube um Brainrot"]={
        {Nome="BrainrotHub",Link="https://raw.githubusercontent.com/BrainrotHub/main/main.lua"}
    },
    ["Grow a Garden"]={
        {Nome="GardenHub",Link="https://raw.githubusercontent.com/GardenHub/main/main.lua"}
    }
}

for gameName,scripts in pairs(AllScripts) do
    CriarPainelDeScripts(gameName,scripts)
    local btn=CreateButton(gameName,Sidebar)
    btn.MouseButton1Click:Connect(function()
        ShowPanel(gameName.."Scripts")
    end)
end

-- Botões Menu/Fechar/Minimizar
local btnMenu=CreateButton("Menu",Sidebar)
btnMenu.MouseButton1Click:Connect(function()
    ShowPanel("Menu")
end)
CloseBtn.MouseButton1Click:Connect(function() Hub:Destroy() end)
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible=false; FloatBtn.Visible=true end)
FloatBtn.MouseButton1Click:Connect(function() MainFrame.Visible=true; FloatBtn.Visible=false end)

-- Inicialmente mostrar Menu
ShowPanel("Menu")
