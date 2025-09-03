--//==================================================\\--
--||            Nescau Hub Master v0.2               ||--
--||     Estruturado e modulado por @Dr.Legado       ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")

-- Remover hub antigo se já existir
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Tema
local Theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Topbar = Color3.fromRGB(35, 35, 35),
    Button = Color3.fromRGB(50, 50, 50),
    ButtonHover = Color3.fromRGB(70, 70, 70),
    Text = Color3.fromRGB(255, 255, 255)
}

-- Hub principal
local Hub = Instance.new("ScreenGui")
Hub.Name = "NescauHub"
Hub.Parent = CoreGui
Hub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Hub.ResetOnSpawn = false

-- Botão flutuante (minimizar)
local FloatBtn = Instance.new("TextButton")
FloatBtn.Name = "FloatBtn"
FloatBtn.Parent = Hub
FloatBtn.Size = UDim2.new(0, 120, 0, 40)
FloatBtn.Position = UDim2.new(0, 20, 0, 200)
FloatBtn.BackgroundColor3 = Theme.Button
FloatBtn.TextColor3 = Theme.Text
FloatBtn.Text = "Abrir Hub"
FloatBtn.Visible = false
FloatBtn.AutoButtonColor = true
FloatBtn.Font = Enum.Font.Gotham
FloatBtn.TextSize = 14

-- Janela principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = Hub
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Barra superior
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.Size = UDim2.new(1, 0, 0, 30)
Topbar.BackgroundColor3 = Theme.Topbar
Topbar.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.Text = "Nescau Hub Master v0.2"
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Theme.Text

-- Botão minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Topbar
MinBtn.Size = UDim2.new(0, 40, 1, 0)
MinBtn.Position = UDim2.new(1, -80, 0, 0)
MinBtn.BackgroundColor3 = Theme.Button
MinBtn.TextColor3 = Theme.Text
MinBtn.Text = "_"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BorderSizePixel = 0

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Topbar
CloseBtn.Size = UDim2.new(0, 40, 1, 0)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Theme.Button
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0

-- Conteúdo principal
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.Size = UDim2.new(1, -150, 1, -30)
Content.Position = UDim2.new(0, 150, 0, 30)
Content.BackgroundTransparency = 1

-- Painéis armazenados
local Panels = {}

-- Função para trocar painéis
local function ShowPanel(name)
    for k,v in pairs(Panels) do
        v.Visible = (k == name)
    end
end

-- Barra lateral
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 150, 1, -30)
Sidebar.Position = UDim2.new(0, 0, 0, 30)
Sidebar.BackgroundColor3 = Theme.Button

-- Função para criar botões
local function CreateButton(text, parent)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, (#parent:GetChildren() - 1) * 45)
    btn.BackgroundColor3 = Theme.Button
    btn.TextColor3 = Theme.Text
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = true
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Theme.ButtonHover end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Theme.Button end)
    return btn
end

-- Painel: Menu
local MenuPanel = Instance.new("Frame")
MenuPanel.Size = UDim2.new(1, 0, 1, 0)
MenuPanel.BackgroundTransparency = 1
MenuPanel.Parent = Content
Panels["Menu"] = MenuPanel

local MenuLabel = Instance.new("TextLabel")
MenuLabel.Parent = MenuPanel
MenuLabel.Size = UDim2.new(1, 0, 0, 50)
MenuLabel.Text = "Bem-vindo ao Nescau Hub!"
MenuLabel.BackgroundTransparency = 1
MenuLabel.Font = Enum.Font.GothamBold
MenuLabel.TextSize = 18
MenuLabel.TextColor3 = Theme.Text

-- Painel: Jogos
local JogosPanel = Instance.new("Frame")
JogosPanel.Size = UDim2.new(1, 0, 1, 0)
JogosPanel.BackgroundTransparency = 1
JogosPanel.Parent = Content
JogosPanel.Visible = false
Panels["Jogos"] = JogosPanel

-- Caixa de pesquisa
local SearchBox = Instance.new("TextBox")
SearchBox.Parent = JogosPanel
SearchBox.Size = UDim2.new(1, -20, 0, 35)
SearchBox.Position = UDim2.new(0, 10, 0, 10)
SearchBox.PlaceholderText = "Pesquisar jogo..."
SearchBox.Text = ""
SearchBox.BackgroundColor3 = Theme.Button
SearchBox.TextColor3 = Theme.Text
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
SearchBox.BorderSizePixel = 0

-- Lista de jogos
local JogosList = Instance.new("Frame")
JogosList.Parent = JogosPanel
JogosList.Size = UDim2.new(1, -20, 1, -60)
JogosList.Position = UDim2.new(0, 10, 0, 50)
JogosList.BackgroundTransparency = 1

local JogosBotoes = {}

-- Função para criar painel de scripts com rolagem
local function CriarPainelDeScripts(nome, scripts)
    local painel = Instance.new("ScrollingFrame")
    painel.Name = nome .. "Scripts"
    painel.Parent = Content
    painel.Size = UDim2.new(1, 0, 1, 0)
    painel.Visible = false
    painel.BackgroundTransparency = 1
    painel.ScrollBarThickness = 6
    painel.CanvasSize = UDim2.new(0,0,0, #scripts * 50)

    Panels[painel.Name] = painel

    for i, scriptData in ipairs(scripts) do
        local ScriptBtn = CreateButton(scriptData.Nome, painel)
        ScriptBtn.Position = UDim2.new(0, 5, 0, (i - 1) * 45)
        ScriptBtn.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(scriptData.Link, true))()
        end)
    end
end

-- Adicionar jogo: 99 noites
local Jogo99 = CreateButton("99 Noites na Floresta", JogosList)
table.insert(JogosBotoes, Jogo99)
Jogo99.MouseButton1Click:Connect(function()
    ShowPanel("99 Noites na FlorestaScripts")
end)

-- Scripts de 99 noites
local Scripts99 = {
    {Nome = "H4XScripts", Link = "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua"},
    {Nome = "SpaceHub", Link = "https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/loader.lua"},
    {Nome = "SpeedHubX", Link = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Nome = "m00ndiett", Link = "https://raw.githubusercontent.com/m00ndiety/99-nights-in-the-forest/refs/heads/main/Main"},
    {Nome = "Teste", Link = "https://api.exploitingis.fun/loader"},
    {Nome = "voidware", Link = "https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/NightsInTheForest.lua"},
    {Nome = "hutao hub", Link = "https://raw.githubusercontent.com/SLK-gaming/Hutao-Hub/refs/heads/main/99-Nights-In-The-Forest.txt"},
    {Nome = "adibhub", Link = "https://raw.githubusercontent.com/adibhub1/99-nighit-in-forest/refs/heads/main/99%20night%20in%20forest"},
    {Nome = "kiki-ware", Link = "https://raw.githubusercontent.com/KiKi-Ware/Roblox/refs/heads/main/Key"},
    {Nome = "syzen Hub", Link = "https://raw.githubusercontent.com/Black69Weed-dev/99-Night-in-the-forest/main/99%20nights%20in%20the%20forest.lua"}
}
CriarPainelDeScripts("99 Noites na Floresta", Scripts99)

-- Filtrar jogos
local function FiltrarJogos(texto)
    texto = string.lower(texto)
    local y = 0
    for _, btn in ipairs(JogosBotoes) do
        if texto == "" or string.find(string.lower(btn.Text), texto) then
            btn.Visible = true
            btn.Position = UDim2.new(0, 5, 0, y * 45)
            y = y + 1
        else
            btn.Visible = false
        end
    end
end
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    FiltrarJogos(SearchBox.Text)
end)

-- Painel: Configurações
local ConfigPanel = Instance.new("Frame")
ConfigPanel.Size = UDim2.new(1, 0, 1, 0)
ConfigPanel.BackgroundTransparency = 1
ConfigPanel.Parent = Content
ConfigPanel.Visible = false
Panels["Config"] = ConfigPanel

local ConfigLabel = Instance.new("TextLabel")
ConfigLabel.Parent = ConfigPanel
ConfigLabel.Size = UDim2.new(1, 0, 0, 50)
ConfigLabel.Text = "Configurações em breve..."
ConfigLabel.BackgroundTransparency = 1
ConfigLabel.Font = Enum.Font.GothamBold
ConfigLabel.TextSize = 18
ConfigLabel.TextColor3 = Theme.Text

-- Botões da sidebar
local BtnMenu = CreateButton("Menu", Sidebar)
BtnMenu.MouseButton1Click:Connect(function() ShowPanel("Menu") end)

local BtnJogos = CreateButton("Jogos", Sidebar)
BtnJogos.MouseButton1Click:Connect(function() ShowPanel("Jogos") end)

local BtnConfig = CreateButton("Configurações", Sidebar)
BtnConfig.MouseButton1Click:Connect(function() ShowPanel("Config") end)

-- Inicial
ShowPanel("Menu")

-- Minimizar
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatBtn.Visible = true
end)

FloatBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    FloatBtn.Visible = false
end)

-- Fechar
CloseBtn.MouseButton1Click:Connect(function()
    Hub:Destroy()
end)