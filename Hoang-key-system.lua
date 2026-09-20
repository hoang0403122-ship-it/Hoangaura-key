local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Cấu hình Lennon Hub
local WEB_GET_KEY_URL = "https://hoang0403122-ship-it.github.io/Hoangaura-key/"
local MAIN_SCRIPT_RAW = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua"
local KEY_FILE_NAME = "LennonHubKey.txt"

-- Giải mã XOR Key: LENNON-WJXQH-KPLM
local _0xEnc = {22, 19, 26, 26, 27, 26, 121, 5, 26, 14, 3, 24, 121, 27, 0, 24, 29}
local _0xK = 114

local function _0xDecode()
    local _res = {}
    for _i = 1, #_0xEnc do
        local _b = bit32 and bit32.bxor(_0xEnc[_i], _0xK) or (_0xEnc[_i] ~ _0xK)
        table.insert(_res, string.char(_b))
    end
    return table.concat(_res)
end

local HARDCODED_KEY = _0xDecode()

local function loadMainScript()
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet(MAIN_SCRIPT_RAW))()
        end)
    end)
end

local function getSavedKey()
    local success, res = pcall(function()
        if readfile and isfile and isfile(KEY_FILE_NAME) then
            return string.gsub(readfile(KEY_FILE_NAME), "%s+", "")
        end
    end)
    if success then return res end
    return nil
end

local savedKey = getSavedKey()
local isAutoLogin = (savedKey == HARDCODED_KEY)

-- ==================== TẠO GIAO DIỆN GUI TƯƠNG THÍCH DELTA ====================
local parentGui = (CoreGui:FindFirstChild("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))

if parentGui:FindFirstChild("LennonProMaxKeyGui") then
    parentGui.LennonProMaxKeyGui:Destroy()
end

local KeySystemGui = Instance.new("ScreenGui")
KeySystemGui.Name = "LennonProMaxKeyGui"
KeySystemGui.Parent = parentGui
KeySystemGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KeySystemGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 16, 25)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 260)
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(75, 85, 120)
UIStroke.Thickness = 1.5

-- Thanh Gradient Phía Trên
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 4)
TopBar.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
TopBar.BorderSizePixel = 0

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 102, 241)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153))
}
TopGradient.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 28)
Title.Font = Enum.Font.FredokaOne
Title.Text = "✨ LENNON HUB VIP ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 20, 0, 50)
SubTitle.Size = UDim2.new(1, -40, 0, 20)
SubTitle.Font = Enum.Font.SourceSansSemibold
SubTitle.Text = "Nhập Key để kích hoạt Lennon Hub"
SubTitle.TextColor3 = Color3.fromRGB(148, 163, 184)
SubTitle.TextSize = 14

local KeyInputContainer = Instance.new("Frame")
KeyInputContainer.Parent = MainFrame
KeyInputContainer.BackgroundColor3 = Color3.fromRGB(22, 27, 42)
KeyInputContainer.Position = UDim2.new(0.08, 0, 0.36, 0)
KeyInputContainer.Size = UDim2.new(0.84, 0, 0, 46)

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 12)
InputCorner.Parent = KeyInputContainer

local InputStroke = Instance.new("UIStroke")
InputStroke.Parent = KeyInputContainer
InputStroke.Color = Color3.fromRGB(50, 60, 90)
InputStroke.Thickness = 1

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyInputContainer
KeyInput.BackgroundTransparency = 1
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.PlaceholderText = "Dán Key vào đây..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 105, 135)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(56, 189, 248)
KeyInput.TextSize = 15

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(245, 158, 11)
GetKeyBtn.Position = UDim2.new(0.08, 0, 0.65, 0)
GetKeyBtn.Size = UDim2.new(0.41, 0, 0, 44)
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.Text = "🌐 Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 16

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 12)
BtnCorner1.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Parent = MainFrame
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
CheckKeyBtn.Position = UDim2.new(0.51, 0, 0.65, 0)
CheckKeyBtn.Size = UDim2.new(0.41, 0, 0, 44)
CheckKeyBtn.Font = Enum.Font.SourceSansBold
CheckKeyBtn.Text = "🚀 Check Key"
CheckKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckKeyBtn.TextSize = 16

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 12)
BtnCorner2.Parent = CheckKeyBtn

-- ==================== XỬ LÝ TỰ ĐỘNG ====================
if isAutoLogin then
    KeyInput.Text = savedKey
    KeyInput.TextEditable = false
    SubTitle.Text = "⚡ Đã tìm thấy Key hợp lệ! Đang mở Hub..."
    SubTitle.TextColor3 = Color3.fromRGB(52, 211, 153)
    GetKeyBtn.Visible = false
    CheckKeyBtn.Visible = false
    KeyInputContainer.Size = UDim2.new(0.84, 0, 0, 50)
    KeyInputContainer.Position = UDim2.new(0.08, 0, 0.45, 0)

    task.spawn(function()
        task.wait(1.5)
        KeySystemGui:Destroy()
        loadMainScript()
    end)
    return
end

-- ==================== SỰ KIỆN ====================
GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then setclipboard(WEB_GET_KEY_URL) end
    end)
    pcall(function()
        if GuiService and GuiService.OpenBrowserWindow then
            GuiService:OpenBrowserWindow(WEB_GET_KEY_URL)
        end
    end)
    SubTitle.Text = "📋 Đã copy link Get Key vào bộ nhớ tạm!"
    SubTitle.TextColor3 = Color3.fromRGB(251, 191, 36)
end)

CheckKeyBtn.MouseButton1Click:Connect(function()
    local userKey = string.gsub(KeyInput.Text or "", "%s+", "")

    if userKey == HARDCODED_KEY then
        SubTitle.Text = "🎉 Key chính xác! Đang lưu và mở Hub..."
        SubTitle.TextColor3 = Color3.fromRGB(52, 211, 153)
        
        pcall(function()
            if writefile then writefile(KEY_FILE_NAME, userKey) end
        end)

        task.wait(1)
        KeySystemGui:Destroy()
        loadMainScript()
    else
        SubTitle.Text = "❌ Key không đúng! Vui lòng kiểm tra lại."
        SubTitle.TextColor3 = Color3.fromRGB(248, 113, 113)
    end
end)
