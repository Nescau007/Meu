--//==================================================\\--
--||            Nescau Hub Master v0.3               ||--
--||     Estruturado e modulado por @Dr.Legado       ||--
--//==================================================\\--

local CoreGui = game:GetService("CoreGui")

-- Remover hub antigo se já existir
if CoreGui:FindFirstChild("NescauHub") then
    CoreGui.NescauHub:Destroy()
end

-- Tema visual melhorado
local Theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Topbar = Color3.fromRGB(40, 40, 40),
    Sidebar = Color3.fromRGB(30, 30, 30),
    Button = Color3.fromRGB(50, 50, 50),
    ButtonHover = Color3.fromRGB(80, 80, 80),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 170, 255) -- cor de destaque
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

-- Botão flutuante (minimizar)
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
AddShadow(FloatBtn, 0.3)

-- Janela principal
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
AddShadow(MainFrame, 0.5)

-- Barra superior
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.Size = UDim2.new(1, 0, 0, 35)
Topbar.BackgroundColor3 = Theme.Topbar
Topbar.BorderSizePixel = 0
AddCorner(Topbar, 10)

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.Text = "🌌 Nescau Hub Master v0.3"
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
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

local function ShowPanel(name)
    for k,v in pairs(Panels) do
        v.Visible = (k == name)
    end
end

-- Barra lateral
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 160, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Theme.Sidebar
AddCorner(Sidebar, 8)

-- Função para criar botões com animação
local function CreateButton(text, parent)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 50)
    btn.BackgroundColor3 = Theme.Button
    btn.TextColor3 = Theme.Text
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    AddCorner(btn, 6)
    AddShadow(btn, 0.4)

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Theme.ButtonHover
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Theme.Button
    end)

    return btn
end

---------------------------------------------------------
-- Aqui mantém todos os painéis e funções originais
-- (Menu, Jogos, Config, Pesquisar, etc.)
-- Sem mexer nas lógicas, só aproveitando os novos visuais
---------------------------------------------------------

-- (resto do seu script continua igual daqui pra baixo)