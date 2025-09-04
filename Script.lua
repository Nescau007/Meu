--//==================================================\\--
--||               Nescau Hub Master v0.4             ||--
--||  Agora com Tela de Carregamento + Animações      ||--
--||  Estruturado e modulado por @Dr.Legado           ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Remover hub antigo se já existir
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Módulos e configurações
local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    Topbar = Color3.fromRGB(25, 25, 25),
    Sidebar = Color3.fromRGB(20, 20, 20),
    Button = Color3.fromRGB(35, 35, 35),
    ButtonHover = Color3.fromRGB(60, 60, 60),
    Text = Color3.fromRGB(240, 240, 240),
    Accent = Color3.fromRGB(0, 150, 255)
}

-- Instância principal do Hub
local Hub = Instance.new("ScreenGui")
Hub.Name = "NescauHub"
Hub.Parent = CoreGui
Hub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Hub.ResetOnSpawn = false

-- Variáveis globais
local Panels = {}
local CurrentPanel = nil
local JogosBotoes = {}

-- Módulo de utilitários
local Utils = {}

function Utils.AddCorner(obj, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, radius or 6)
    UICorner.Parent = obj
    return UICorner
end

function Utils.AddShadow(obj, opacity)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(0, 0, 0)
    UIStroke.Thickness = 1
    UIStroke.Transparency = opacity or 0.6
    UIStroke.Parent = obj
    return UIStroke
end

function Utils.CreateButton(text, parent, size, position)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = size or UDim2.new(1, -20, 0, 40)
    btn.Position = position or UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 45)
    btn.BackgroundColor3 = Theme.Button
    btn.TextColor3 = Theme.Text
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 15
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    Utils.AddCorner(btn, 6)
    Utils.AddShadow(btn, 0.6)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Theme.ButtonHover
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Theme.Button
    end)
    
    return btn
end

function Utils.FadeIn(obj, duration)
    obj.Visible = true
    obj.BackgroundTransparency = 1
    TweenService:Create(obj, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0
    }):Play()
end

function Utils.FadeOut(obj, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    }):Play()
    
    task.delay(duration or 0.5, function()
        obj.Visible = false
    end)
end

-- Módulo da tela de carregamento
local SplashScreen = {}

function SplashScreen.Create()
    local Splash = Instance.new("Frame")
    Splash.Size = UDim2.new(1, 0, 1, 0)
    Splash.BackgroundColor3 = Theme.Background
    Splash.Parent = Hub
    Splash.ZIndex = 100
    
    local SplashLabel = Instance.new("TextLabel")
    SplashLabel.Parent = Splash
    SplashLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    SplashLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    SplashLabel.Size = UDim2.new(0, 400, 0, 50)
    SplashLabel.Text = "✨ Bem-vindo ao Nescau Hub!"
    SplashLabel.Font = Enum.Font.GothamBold
    SplashLabel.TextSize = 20
    SplashLabel.TextColor3 = Theme.Accent
    SplashLabel.BackgroundTransparency = 1
    
    local LoadingProgress = Instance.new("TextLabel")
    LoadingProgress.Parent = Splash
    LoadingProgress.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingProgress.Position = UDim2.new(0.5, 0, 0.6, 0)
    LoadingProgress.Size = UDim2.new(0, 200, 0, 30)
    LoadingProgress.Text = "0%"
    LoadingProgress.Font = Enum.Font.Gotham
    LoadingProgress.TextSize = 18
    LoadingProgress.TextColor3 = Theme.Text
    LoadingProgress.BackgroundTransparency = 1
    
    return Splash, SplashLabel, LoadingProgress
end

function SplashScreen.Animate(splash, label, progress)
    local duration = 5
    local startTime = tick()
    
    while tick() - startTime < duration do
        local progressValue = math.min(1, (tick() - startTime) / duration)
        progress.Text = math.floor(progressValue * 100) .. "%"
        task.wait(0.05)
    end
    
    progress.Text = "100%"
    task.wait(0.5)
    
    TweenService:Create(splash, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(label, TweenInfo.new(1), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(progress, TweenInfo.new(1), {
        TextTransparency = 1
    }):Play()
    
    task.wait(1)
    splash:Destroy()
end

-- Módulo da interface principal
local MainUI = {}

function MainUI.Create()
    -- Frame principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Hub
    MainFrame.Size = UDim2.new(0, 620, 0, 370)
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -185)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    Utils.AddCorner(MainFrame, 10)
    Utils.AddShadow(MainFrame, 0.7)
    
    -- Barra superior
    local Topbar = Instance.new("Frame")
    Topbar.Parent = MainFrame
    Topbar.Size = UDim2.new(1, 0, 0, 35)
    Topbar.BackgroundColor3 = Theme.Topbar
    Topbar.BorderSizePixel = 0
    Utils.AddCorner(Topbar, 10)
    
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
    
    -- Botões da barra superior
    local MinBtn = Utils.CreateButton("–", Topbar, UDim2.new(0, 40, 1, -6), UDim2.new(1, -85, 0, 3))
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    
    local CloseBtn = Utils.CreateButton("X", Topbar, UDim2.new(0, 40, 1, -6), UDim2.new(1, -45, 0, 3))
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    
    -- Conteúdo principal
    local Content = Instance.new("Frame")
    Content.Parent = MainFrame
    Content.Size = UDim2.new(1, -160, 1, -35)
    Content.Position = UDim2.new(0, 160, 0, 35)
    Content.BackgroundTransparency = 1
    
    -- Barra lateral
    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainFrame
    Sidebar.Size = UDim2.new(0, 160, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Utils.AddCorner(Sidebar, 10)
    
    -- Botão flutuante
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
    
    Utils.AddCorner(FloatBtn, 8)
    Utils.AddShadow(FloatBtn, 0.5)
    
    return {
        MainFrame = MainFrame,
        Topbar = Topbar,
        Content = Content,
        Sidebar = Sidebar,
        MinBtn = MinBtn,
        CloseBtn = CloseBtn,
        FloatBtn = FloatBtn
    }
end

-- Módulo de gerenciamento de painéis
local PanelManager = {}

function PanelManager.ShowPanel(name)
    for panelName, panel in pairs(Panels) do
        if panelName == name then
            Utils.FadeIn(panel)
            CurrentPanel = panel
        elseif panel.Visible then
            Utils.FadeOut(panel)
        end
    end
end

function PanelManager.CreatePanel(name, parent)
    local panel = Instance.new("Frame")
    panel.Name = name
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1
    panel.Parent = parent
    panel.Visible = false
    
    Panels[name] = panel
    return panel
end

function PanelManager.CreateScrollingPanel(name, parent, canvasHeight)
    local panel = Instance.new("ScrollingFrame")
    panel.Name = name
    panel.Parent = parent
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.Visible = false
    panel.BackgroundTransparency = 1
    panel.ScrollBarThickness = 6
    panel.CanvasSize = UDim2.new(0, 0, 0, canvasHeight or 0)
    
    Panels[name] = panel
    return panel
end

-- Módulo de criação de conteúdo
local ContentManager = {}

function ContentManager.CreateMenuPanel()
    local panel = PanelManager.CreatePanel("Menu", MainUI.Content)
    
    local MenuLabel = Instance.new("TextLabel")
    MenuLabel.Parent = panel
    MenuLabel.Size = UDim2.new(1, 0, 0, 50)
    MenuLabel.Text = "✨ Bem-vindo ao Nescau Hub!"
    MenuLabel.BackgroundTransparency = 1
    MenuLabel.Font = Enum.Font.Gotham
    MenuLabel.TextSize = 20
    MenuLabel.TextColor3 = Theme.Accent
    
    local ChangesLog = Instance.new("TextLabel")
    ChangesLog.Parent = panel
    ChangesLog.Size = UDim2.new(1, -20, 1, -60)
    ChangesLog.Position = UDim2.new(0, 10, 0, 60)
    ChangesLog.BackgroundTransparency = 1
    ChangesLog.TextXAlignment = Enum.TextXAlignment.Left
    ChangesLog.TextYAlignment = Enum.TextYAlignment.Top
    ChangesLog.Font = Enum.Font.Gotham
    ChangesLog.TextSize = 14
    ChangesLog.TextColor3 = Theme.Text
    ChangesLog.TextWrapped = true
    ChangesLog.Text = [[
Últimas Alterações e Melhorias:
--------------------------------
- **Integração BloxFruits:** 
  - Adicionado botão "BloxFruits" (18 scripts).
  - Painel de scripts dedicado.

- **Integração Roube um Brainrot:** 
  - Adicionado botão "Roube um Brainrot" (10 scripts).
  - Painel de scripts dedicado.

- **Integração Grow a Garden:** 
  - Adicionado botão "Grow a Garden" (8 scripts).
  - Painel de scripts dedicado.

- **Melhorias Visuais (Tema Preto Profissional):**
  - Esquema de cores refinado (fundo escuro, detalhes em azul vibrante).
  - Sombras mais sutis e elegantes.
  - Tipografia padronizada (títulos: 20, botões: 15, fonte Gotham).
  - Cantos arredondados consistentes (Sidebar: 10).

- **Tela de Carregamento Aprimorada:**
  - Duração de 5 segundos.
  - Mensagem: "✨ Bem-vindo ao Nescau Hub!".
  - Animação de contador de 0-100%.
]]
    
    return panel
end

function ContentManager.CreateJogosPanel()
    local panel = PanelManager.CreatePanel("Jogos", MainUI.Content)
    panel.Visible = false
    
    -- Caixa de pesquisa
    local SearchBox = Instance.new("TextBox")
    SearchBox.Parent = panel
    SearchBox.Size = UDim2.new(1, -20, 0, 35)
    SearchBox.Position = UDim2.new(0, 10, 0, 10)
    SearchBox.PlaceholderText = "🔎 Pesquisar jogo..."
    SearchBox.Text = ""
    SearchBox.BackgroundColor3 = Theme.Button
    SearchBox.TextColor3 = Theme.Text
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.TextSize = 14
    SearchBox.BorderSizePixel = 0
    
    Utils.AddCorner(SearchBox, 6)
    Utils.AddShadow(SearchBox, 0.3)
    
    -- Lista de jogos
    local JogosList = Instance.new("Frame")
    JogosList.Parent = panel
    JogosList.Size = UDim2.new(1, -20, 1, -60)
    JogosList.Position = UDim2.new(0, 10, 0, 50)
    JogosList.BackgroundTransparency = 1
    
    -- Função para filtrar jogos
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
    
    return panel, JogosList
end

function ContentManager.CreateConfigPanel()
    local panel = PanelManager.CreatePanel("Config", MainUI.Content)
    panel.Visible = false
    
    local ConfigLabel = Instance.new("TextLabel")
    ConfigLabel.Parent = panel
    ConfigLabel.Size = UDim2.new(1, 0, 0, 50)
    ConfigLabel.Text = "⚙️ Configurações "
    ConfigLabel.BackgroundTransparency = 1
    ConfigLabel.Font = Enum.Font.Gotham
    ConfigLabel.TextSize = 20
    ConfigLabel.TextColor3 = Theme.Accent
    
    local AntiAFKBtn = Utils.CreateButton("Anti AFK", panel, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 60))
    AntiAFKBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/KazeOnTop/Rice-Anti-Afk/main/Wind", true))()
    end)
    
    return panel
end

function ContentManager.CreateGameScriptsPanel(gameName, scripts, parent)
    local panel = PanelManager.CreateScrollingPanel(gameName .. "Scripts", parent, #scripts * 50)
    
    for i, scriptData in ipairs(scripts) do
        local ScriptBtn = Utils.CreateButton(scriptData.Nome, panel, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, (i - 1) * 45))
        ScriptBtn.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(scriptData.Link, true))()
        end)
    end
    
    return panel
end

-- Dados dos scripts
local ScriptsData = {
    ["99 Noites na Floresta"] = {
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
    },
    
    ["BloxFruits"] = {
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
        {Nome = "Cokka Hub", Link = "https://raw.githubusercontent.com/UserDevEthical/Loader/main/CokkaHub.lua"},
        {Nome = "Aurora Hub", Link = "https://raw.githubusercontent.com/Jadelly261/BloxFruits/main/Aurora"},
        {Nome = "Volcano Hub", Link = "https://raw.githubusercontent.com/indexeduu/BF-NewVer/refs/heads/main/V3New.lua"},
        {Nome = "Lion Fruit Finder Script", Link = "https://api.luarmor.net/files/v3/loaders/d734d024f3000caddd23122da89a6c3e.lua"}
    },
    
    ["RoubeUmBrainrot"] = {
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
    },
    
    ["GrowAGarden"] = {
        {Nome = "AVOnTop No Key – Auto Farming, Auto Summer and More", Link = "https://raw.githubusercontent.com/Ayvathion/AV-On-Top/refs/heads/main/Loader.lua"},
        {Nome = "GAG Script – Auto Planting, Auto Water, Anti AFK", Link = "https://api.luarmor.net/files/v3/loaders/7d8a2a1a9a562a403b52532e58a14065.lua"},
        {Nome = "Y-Hub – Auto Collect, Auto Buy, Auto Sell", Link = "https://raw.githubusercontent.com/yue-os/script/refs/heads/main/Y-Hub"},
        {Nome = "Thunder Z – Grow a Garden NEW Script Keyless", Link = "https://raw.githubusercontent.com/ThundarZ/Welcome/refs/heads/main/Main/GaG/Main.lua"},
        {Nome = "No Lag Keyless", Link = "https://raw.githubusercontent.com/greywaterstill/GAG/refs/heads/main/nathub.lua"},
        {Nome = "New Grow a Garden Script Updated – Auto Planting, Auto Water, Anti-AFK & more", Link = "https://api.luarmor.net/files/v3/loaders/b778b0425fce68591d34cc9d0a04fe3b.lua"},
        {Nome = "Grow a Garden Script Mobile (Android) AlterHub – Auto Farm, Auto Buy, NoClip", Link = "https://raw.githubusercontent.com/frvaunted/Main/refs/heads/main/Alter%20Hub"},
        {Nome = "Grow a Garden Script New Update – Auto Farm, Auto Plant", Link = "https://raw.githubusercontent.com/nootmaus/GrowAAGarden/refs/heads/main/mauscripts"}
    }
}

-- Inicialização
local function Initialize()
    -- Criar tela de carregamento
    local splash, splashLabel, loadingProgress = SplashScreen.Create()
    
    -- Criar interface principal
    MainUI = MainUI.Create()
    
    -- Criar painéis de conteúdo
    ContentManager.CreateMenuPanel()
    local jogosPanel, jogosList = ContentManager.CreateJogosPanel()
    ContentManager.CreateConfigPanel()
    
    -- Criar botões de jogos
    local function AddGameButton(name, icon)
        local btn = Utils.CreateButton(icon .. " " .. name, jogosList)
        table.insert(JogosBotoes, btn)
        
        btn.MouseButton1Click:Connect(function()
            PanelManager.ShowPanel(name .. "Scripts")
        end)
        
        return btn
    end
    
    AddGameButton("99 Noites na Floresta", "🌲")
    AddGameButton("BloxFruits", "⚔️")
    AddGameButton("RoubeUmBrainrot", "🧠")
    AddGameButton("GrowAGarden", "🌱")
    
    -- Criar painéis de scripts para cada jogo
    for gameName, scripts in pairs(ScriptsData) do
        ContentManager.CreateGameScriptsPanel(gameName, scripts, MainUI.Content)
    end
    
    -- Criar botões da sidebar
    local BtnMenu = Utils.CreateButton("🏠 Menu", MainUI.Sidebar)
    BtnMenu.MouseButton1Click:Connect(function() PanelManager.ShowPanel("Menu") end)
    
    local BtnJogos = Utils.CreateButton("🎮 Jogos", MainUI.Sidebar)
    BtnJogos.MouseButton1Click:Connect(function() PanelManager.ShowPanel("Jogos") end)
    
    local BtnConfig = Utils.CreateButton("⚙️ Configurações", MainUI.Sidebar)
    BtnConfig.MouseButton1Click:Connect(function() PanelManager.ShowPanel("Config") end)
    
    -- Configurar eventos dos botões
    MainUI.MinBtn.MouseButton1Click:Connect(function()
        MainUI.MainFrame.Visible = false
        MainUI.FloatBtn.Visible = true
    end)
    
    MainUI.FloatBtn.MouseButton1Click:Connect(function()
        MainUI.MainFrame.Visible = true
        MainUI.FloatBtn.Visible = false
    end)
    
    MainUI.CloseBtn.MouseButton1Click:Connect(function()
        Hub:Destroy()
    end)
    
    -- Mostrar painel inicial
    PanelManager.ShowPanel("Menu")
    
    -- Iniciar animação da tela de carregamento
    task.spawn(function()
        SplashScreen.Animate(splash, splashLabel, loadingProgress)
    end)
end

-- Iniciar o hub
Initialize()