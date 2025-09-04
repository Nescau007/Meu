--//==================================================\\--
--||            Nescau Hub Master v0.4               ||--
--||   Agora com Tela de Carregamento + Animações    ||--
--||     Estruturado e modulado por @Dr.Legado       ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Remover hub antigo se já existir
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Tema visual
local Theme = {
    Background = Color3.fromRGB(15, 15, 15), -- Fundo bem escuro
    Topbar = Color3.fromRGB(25, 25, 25),     -- Um pouco mais claro que o fundo para contraste
    Sidebar = Color3.fromRGB(20, 20, 20),    -- Um pouco mais claro que o fundo
    Button = Color3.fromRGB(35, 35, 35),     -- Botões escuros
    ButtonHover = Color3.fromRGB(60, 60, 60),-- Botão ao passar o mouse
    Text = Color3.fromRGB(240, 240, 240),    -- Texto quase branco
    Accent = Color3.fromRGB(0, 150, 255)     -- Azul vibrante como destaque
}

-- Função para arredondar cantos
local function AddCorner(obj, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, radius)
    UICorner.Parent = obj
end

-- Função para sombra suave
local function AddShadow(obj, opacity)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(0, 0, 0)
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

--==================================================--
--                  Tela de Carregamento
--==================================================--
local Splash = Instance.new("Frame")
Splash.Size = UDim2.new(1,0,1,0)
Splash.BackgroundColor3 = Theme.Background
Splash.Parent = Hub
Splash.ZIndex = 100

local SplashLabel = Instance.new("TextLabel")
SplashLabel.Parent = Splash
SplashLabel.AnchorPoint = Vector2.new(0.5,0.5)
SplashLabel.Position = UDim2.new(0.5,0,0.5,0)
SplashLabel.Size = UDim2.new(0,400,0,50)
SplashLabel.Text = "✨ Bem-vindo ao Nescau Hub!"
SplashLabel.Font = Enum.Font.GothamBold
SplashLabel.TextSize = 20
SplashLabel.TextColor3 = Theme.Accent
SplashLabel.BackgroundTransparency = 1

local LoadingProgress = Instance.new("TextLabel")
LoadingProgress.Parent = Splash
LoadingProgress.AnchorPoint = Vector2.new(0.5,0.5)
LoadingProgress.Position = UDim2.new(0.5,0,0.6,0)
LoadingProgress.Size = UDim2.new(0,200,0,30)
LoadingProgress.Text = "0%"
LoadingProgress.Font = Enum.Font.Gotham
LoadingProgress.TextSize = 18
LoadingProgress.TextColor3 = Theme.Text
LoadingProgress.BackgroundTransparency = 1

-- Animação de Fade Out após 5 segundos
task.spawn(function()
    local duration = 5
    local startTime = tick()
    
    while tick() - startTime < duration do
        local progress = math.min(1, (tick() - startTime) / duration)
        LoadingProgress.Text = math.floor(progress * 100) .. "%"
        task.wait(0.05) -- Update every 0.05 seconds
    end
    LoadingProgress.Text = "100%"
    
    task.wait(0.5) -- Small delay after reaching 100%
    TweenService:Create(Splash, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    TweenService:Create(SplashLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingProgress, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    Splash:Destroy()
end)

--==================================================--
--                  Botão Flutuante
--==================================================--
local FloatBtn = Instance.new("TextButton")
FloatBtn.Name = "FloatBtn"
FloatBtn.Parent = Hub
FloatBtn.Size = UDim2.new(0, 120, 0, 40)
FloatBtn.Position = UDim2.new(0, 20, 0, 200)
FloatBtn.BackgroundColor3 = Theme.Accent
FloatBtn.TextColor3 = Theme.Text
FloatBtn.Text = "Abrir Hub"
FloatBtn.Visible = false
FloatBtn.AutoButtonColor = true
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextSize = 14
AddCorner(FloatBtn, 8)
AddShadow(FloatBtn, 0.5)

--==================================================--
--                  Janela Principal
--==================================================--
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = Hub
MainFrame.Size = UDim2.new(0, 620, 0, 370)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -185)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
AddCorner(MainFrame, 10)
AddShadow(MainFrame, 0.7)

-- Barra superior
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.Size = UDim2.new(1, 0, 0, 35)
Topbar.BackgroundColor3 = Theme.Topbar
Topbar.BorderSizePixel = 0
AddCorner(Topbar, 10)

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.Text = "🌌 Nescau Hub Master v0.4"
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Theme.Text

-- Botão minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Topbar
MinBtn.Size = UDim2.new(0, 40, 1, -6)
MinBtn.Position = UDim2.new(1, -85, 0, 3)
MinBtn.BackgroundColor3 = Theme.Button
MinBtn.TextColor3 = Theme.Text
MinBtn.Text = "–"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BorderSizePixel = 0
AddCorner(MinBtn, 6)

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Topbar
CloseBtn.Size = UDim2.new(0, 40, 1, -6)
CloseBtn.Position = UDim2.new(1, -45, 0, 3)
CloseBtn.BackgroundColor3 = Theme.Button
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
AddCorner(CloseBtn, 6)

-- Conteúdo principal
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.Size = UDim2.new(1, -160, 1, -35)
Content.Position = UDim2.new(0, 160, 0, 35)
Content.BackgroundTransparency = 1

-- Painéis armazenados
local Panels = {}
local CurrentPanel = nil

local function ShowPanel(name)
    for k,v in pairs(Panels) do
        if k == name then
            v.Visible = true
            v.BackgroundTransparency = 1
            TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            CurrentPanel = v
        else
            if v.Visible then
                TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
                task.delay(0.5, function() v.Visible = false end)
            end
        end
    end
end

-- Barra lateral
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 160, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Theme.Sidebar
AddCorner(Sidebar, 10)

-- Função para criar botões
local function CreateButton(text, parent)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 50)
    btn.BackgroundColor3 = Theme.Button
    btn.TextColor3 = Theme.Text
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 15
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    AddCorner(btn, 6)
    AddShadow(btn, 0.6)

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Theme.ButtonHover
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Theme.Button
    end)

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
MenuLabel.Text = "✨ Bem-vindo ao Nescau Hub!"
MenuLabel.BackgroundTransparency = 1
MenuLabel.Font = Enum.Font.Gotham
MenuLabel.TextSize = 20
MenuLabel.TextColor3 = Theme.Accent

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
SearchBox.PlaceholderText = "🔎 Pesquisar jogo..."
SearchBox.Text = ""
SearchBox.BackgroundColor3 = Theme.Button
SearchBox.TextColor3 = Theme.Text
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
SearchBox.BorderSizePixel = 0
AddCorner(SearchBox, 6)
AddShadow(SearchBox, 0.3)

-- Lista de jogos
local JogosList = Instance.new("Frame")
JogosList.Parent = JogosPanel
JogosList.Size = UDim2.new(1, -20, 1, -60)
JogosList.Position = UDim2.new(0, 10, 0, 50)
JogosList.BackgroundTransparency = 1

local JogosBotoes = {}

-- Criar painel de scripts com rolagem
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
        ScriptBtn.Position = UDim2.new(0, 10, 0, (i - 1) * 45)
        ScriptBtn.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(scriptData.Link, true))()
        end)
    end
end

-- Adicionar jogo: 99 noites
local Jogo99 = CreateButton("🌲 99 Noites na Floresta", JogosList)
table.insert(JogosBotoes, Jogo99)
Jogo99.MouseButton1Click:Connect(function()
    ShowPanel("99 Noites na FlorestaScripts")
end)

local JogoBloxFruits = CreateButton("⚔️ BloxFruits", JogosList)
table.insert(JogosBotoes, JogoBloxFruits)
JogoBloxFruits.MouseButton1Click:Connect(function()
    ShowPanel("BloxFruitsScripts")
end)

local JogoRoubeBrainrot = CreateButton("🧠 Roube um Brainrot", JogosList)
table.insert(JogosBotoes, JogoRoubeBrainrot)
JogoRoubeBrainrot.MouseButton1Click:Connect(function()
    ShowPanel("RoubeUmBrainrotScripts")
end)

local JogoGrowAGarden = CreateButton("🌱 Grow a Garden", JogosList)
table.insert(JogosBotoes, JogoGrowAGarden)
JogoGrowAGarden.MouseButton1Click:Connect(function()
    ShowPanel("GrowAGardenScripts")
end)

-- Scripts de 99 noites
local Scripts99 = {
    {Nome = "H4XScripts(key)", Link = "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua"},
    {Nome = "SpaceHub", Link = "https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/loader.lua"},
    {Nome = "SpeedHubX(key)", Link = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Nome = "m00ndiett(key)", Link = "https://raw.githubusercontent.com/m00ndiety/99-nights-in-the-forest/refs/heads/main/Main"},
    {Nome = "Teste", Link = "https://api.exploitingis.fun/loader"},
    {Nome = "voidware(Nokey)", Link = "https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/NightsInTheForest.lua"},
    {Nome = "hutao hub(Nokey)", Link = "https://raw.githubusercontent.com/SLK-gaming/Hutao-Hub/refs/heads/main/99-Nights-In-The-Forest.txt"},
    {Nome = "adibhub(nokey)", Link = "https://raw.githubusercontent.com/adibhub1/99-nighit-in-forest/refs/heads/main/99%20night%20in%20forest"},
    {Nome = "kiki-ware(key)", Link = "https://raw.githubusercontent.com/KiKi-Ware/Roblox/refs/heads/main/Key"},
    {Nome = "syzen Hub", Link = "https://raw.githubusercontent.com/Black69Weed-dev/99-Night-in-the-forest/main/99%20nights%20in%20the%20forest.lua"}
}
CriarPainelDeScripts("99 Noites na Floresta", Scripts99)

-- Scripts de BloxFruits
local ScriptsBloxFruits = {
    {Nome = "Alchemy Hub Script", Link = "https://scripts.alchemyhub.xyz"},
    {Nome = "Banana Cat Hub", Link = "https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"},
    {Nome = "Speed Hub X", Link = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"},
    {Nome = "Raito Hub", Link = "https://raw.githubusercontent.com/Efe0626/RaitoHub/main/Script"},
    {Nome = "HoHo Hub Script", Link = "https://raw.githubusercontent.com/ascn123/HOHO_H/main/Loading_UI"},
    {Nome = "ThunderZ Chest Script", Link = "https://raw.githubusercontent.com/ThundarZ/Welcome/refs/heads/main/Main/BloxFruit/Chest/AllDevices.lua"},
    {Nome = "W-Azure Hub", Link = "https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"},
    {Nome = "redZ Hub", Link = "https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"},
    {Nome = "Ronix Hub", Link = "https://api.luarmor.net/files/v3/loaders/513ccdb3ae8a61d4d7698fc337e5256d.lua"},
    {Nome = "Level Farm (0 to Max)", Link = "https://raw.githubusercontent.com/simple-hubs/contents/refs/heads/main/bloxfruit-kaitan-main.lua"},
    {Nome = "Quantum Onyx Project", Link = "https://raw.githubusercontent.com/FlazhGG/QTONYX/refs/heads/main/NextGeneration.lua"},
    {Nome = "Flow Hub", Link = "https://raw.githubusercontent.com/Yumiara/Overflow/refs/heads/main/Main.lua"},
    {Nome = "AnDepZai Hub", Link = "https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubNewUpdated.lua"},
    {Nome = "BlueX Hub", Link = "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"},
    {Nome = "Cokka Hub", Link = "https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua"},
    {Nome = "Aurora Hub", Link = "https://raw.githubusercontent.com/Jadelly261/BloxFruits/main/Aurora"},
    {Nome = "Volcano Hub", Link = "https://raw.githubusercontent.com/indexeduu/BF-NewVer/refs/heads/main/V3New.lua"},
    {Nome = "Lion Fruit Finder Script", Link = "https://api.luarmor.net/files/v3/loaders/d734d024f3000caddd23122da89a6c3e.lua"}
}
CriarPainelDeScripts("BloxFruits", ScriptsBloxFruits)

-- Scripts de Roube um Brainrot
local ScriptsRoubeBrainrot = {
    {Nome = "Script Roblox Steal a Brainrot", Link = "https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/StealaBrainrot"},
    {Nome = "OP SCRIPT Auto", Link = "https://raw.githubusercontent.com/OverflowBGSI/Overflow/refs/heads/main/loader.txt"},
    {Nome = "Script Steal a Brainrot — um dos melhores scripts", Link = "https://raw.githubusercontent.com/KaspikScriptsRb/steal-a-brainrot/refs/heads/main/.lua"},
    {Nome = "Script Steal a Brainrot Funcionando - Roubo Automático, Voar, NoClip", Link = "https://raw.githubusercontent.com/m00ndiety/Steal-a-brainrot/refs/heads/main/Steal-a-Brainrot"},
    {Nome = "Auto farm/ roubo instantaneo", Link = "https://pastebin.com/raw/HFx6faQY"},
    {Nome = "Lurk Hack", Link = "https://raw.githubusercontent.com/egor2078f/lurkhackv4/refs/heads/main/main.lua"},
    {Nome = "Scripts de Auto Farm", Link = "https://raw.githubusercontent.com/Ayvathion/AV-On-Top/refs/heads/main/Loader.lua"},
    {Nome = "Ronix Hub", Link = "https://api.luarmor.net/files/v3/loaders/7d8a2a1a9a562a403b52532e58a14065.lua"},
    {Nome = "Y Hub – Roubo Instantâneo, Auto Lock", Link = "https://raw.githubusercontent.com/yue-os/script/refs/heads/main/Y-Hub"},
    {Nome = "EcstacyV2 Hub – Roubo, Speed Hack, ESP", Link = "https://raw.githubusercontent.com/ecstacyV2/EcstacyV2/refs/heads/main2/EcstacyV2Real"}
}
CriarPainelDeScripts("RoubeUmBrainrot", ScriptsRoubeBrainrot)

-- Scripts de Grow a Garden
local ScriptsGrowAGarden = {
    {Nome = "AVOnTop No Key – Auto Farming, Auto Summer and More", Link = "https://raw.githubusercontent.com/Ayvathion/AV-On-Top/refs/heads/main/Loader.lua"},
    {Nome = "GAG Script – Auto Planting, Auto Water, Anti AFK", Link = "https://api.luarmor.net/files/v3/loaders/7d8a2a1a9a562a403b52532e58a14065.lua"},
    {Nome = "Y-Hub – Auto Collect, Auto Buy, Auto Sell", Link = "https://raw.githubusercontent.com/yue-os/script/refs/heads/main/Y-Hub"},
    {Nome = "Thunder Z – Grow a Garden NEW Script Keyless", Link = "https://raw.githubusercontent.com/ThundarZ/Welcome/refs/heads/main/Main/GaG/Main.lua"},
    {Nome = "No Lag Keyless", Link = "https://raw.githubusercontent.com/greywaterstill/GAG/refs/heads/main/nathub.lua"},
    {Nome = "New Grow a Garden Script Updated – Auto Planting, Auto Water, Anti-AFK & more", Link = "https://api.luarmor.net/files/v3/loaders/b778b0425fce68591d34cc9d0a04fe3b.lua"},
    {Nome = "Grow a Garden Script Mobile (Android) AlterHub – Auto Farm, Auto Buy, NoClip", Link = "https://raw.githubusercontent.com/frvaunted/Main/refs/heads/main/Alter%20Hub"},
    {Nome = "Grow a Garden Script New Update – Auto Farm, Auto Plant", Link = "https://raw.githubusercontent.com/nootmaus/GrowAAGarden/refs/heads/main/mauscripts"}
}
CriarPainelDeScripts("GrowAGarden", ScriptsGrowAGarden)

-- Filtrar jogos
local function FiltrarJogos(texto)
    texto = string.lower(texto)
    local y = 0
    for _, btn in ipairs(JogosBotoes) do
        if texto == "" or string.find(string.lower(btn.Text), texto) then
            btn.Visible = true
            btn.Position = UDim2.new(0, 10, 0, y * 45)
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
ConfigLabel.Text = "⚙️ Configurações em breve..."
ConfigLabel.BackgroundTransparency = 1
ConfigLabel.Font = Enum.Font.Gotham
ConfigLabel.TextSize = 20
ConfigLabel.TextColor3 = Theme.Accent

-- Botões da sidebar
local BtnMenu = CreateButton("🏠 Menu", Sidebar)
BtnMenu.MouseButton1Click:Connect(function() ShowPanel("Menu") end)

local BtnJogos = CreateButton("🎮 Jogos", Sidebar)
BtnJogos.MouseButton1Click:Connect(function() ShowPanel("Jogos") end)

local BtnConfig = CreateButton("⚙️ Configurações", Sidebar)
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
