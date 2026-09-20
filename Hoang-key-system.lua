-- Lennon Hub Key System - Fix Full UI cho Delta
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

local WEB_GET_KEY_URL = "https://hoang0403122-ship-it.github.io/Hoangaura-key/"
local MAIN_SCRIPT_RAW = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua"
local KEY_FILE_NAME = "LennonHubKey.txt"

-- Key giải mã XOR: LENNON-WJXQH-KPLM
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

-- Xóa GUI cũ nếu có
local parentGui = (CoreGui:FindFirstChild("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
if parentGui:FindFirstChild("LennonProMaxKeyGui") then
    parentGui.LennonProMaxKeyGui:Destroy()
end

local KeySystemGui = Instance.new("ScreenGui")
KeySystemGui.Name = "LennonProMaxKeyGui"
KeySystemGui.Parent = parentGui
KeySystemGui.ResetOnSpawn = false

-- Khung chính
local MainFrame = Instance.new("Frame")
MainFrame.Parent = KeySystemGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 250)
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(99, 102, 241)
UIStroke.Thickness = 1.5

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "LENNON HUB VIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22

-- Phụ đề / Trạng thái
local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 20, 0, 50)
SubTitle.Size = UDim2.new(1, -40, 0, 20)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.Text = "Vui lòng nhập Key bản quyền để tiếp tục"
SubTitle.TextColor3 = Color3.fromRGB(160, 175, 200)
SubTitle.TextSize = 14

-- Khung nhập Key
local KeyInputContainer = Instance.new("Frame")
KeyInputContainer.Parent = MainFrame
KeyInputContainer.BackgroundColor3 = Color3.fromRGB(28, 35, 55)
KeyInputContainer.Position = UDim2.new(0.08, 0, 0.35, 0)
KeyInputContainer.Size = UDim2.new(0.84, 0, 0, 45)

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = KeyInputContainer

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyInputContainer
KeyInput.BackgroundTransparency = 1
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.PlaceholderText = "Dán Key vào đây..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 115, 145)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(56, 189, 248)
KeyInput.TextSize = 16

-- Nút Get Key
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(245, 158, 11)
GetKeyBtn.Position = UDim2.new(0.08, 0, 0.65, 0)
GetKeyBtn.Size = UDim2.new(0.41, 0, 0, 45)
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 16

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 10)
BtnCorner1.Parent = GetKeyBtn

-- Nút Check Key
local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Parent = MainFrame
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
CheckKeyBtn.Position = UDim2.new(0.51, 0, 0.65, 0)
CheckKeyBtn.Size = UDim2.new(0.41, 0, 0, 45)
CheckKeyBtn.Font = Enum.Font.SourceSansBold
CheckKeyBtn.Text = "CHECK KEY"
CheckKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckKeyBtn.TextSize = 16

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 10)
BtnCorner2.Parent = CheckKeyBtn

-- Kiểm tra tự động đăng nhập
if isAutoLogin then
    KeyInput.Text = savedKey
    KeyInput.TextEditable = false
    SubTitle.Text = "Đã tìm thấy Key! Đang mở Hub..."
    SubTitle.TextColor3 = Color3.fromRGB(52, 211, 153)
    GetKeyBtn.Visible = false
    CheckKeyBtn.Visible = false

    task.spawn(function()
        task.wait(1.5)
        KeySystemGui:Destroy()
        loadMainScript()
    end)
    return
end

-- Sự kiện bấm nút Get Key
GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then setclipboard(WEB_GET_KEY_URL) end
    end)
    pcall(function()
        if GuiService and GuiService.OpenBrowserWindow then
            GuiService:OpenBrowserWindow(WEB_GET_KEY_URL)
        end
    end)
    SubTitle.Text = "Đã copy link Get Key vào bộ nhớ tạm!"
    SubTitle.TextColor3 = Color3.fromRGB(251, 191, 36)
end)

-- Sự kiện bấm nút Check Key
CheckKeyBtn.MouseButton1Click:Connect(function()
    local userKey = string.gsub(KeyInput.Text or "", "%s+", "")

    if userKey == HARDCODED_KEY then
        SubTitle.Text = "Key chính xác! Đang mở Hub..."
        SubTitle.TextColor3 = Color3.fromRGB(52, 211, 153)
        
        pcall(function()
            if writefile then writefile(KEY_FILE_NAME, userKey) end
        end)

        task.wait(1)
        KeySystemGui:Destroy()
        loadMainScript()
    else
        SubTitle.Text = "Key không đúng! Vui lòng thử lại."
        SubTitle.TextColor3 = Color3.fromRGB(248, 113, 113)
    end
end)
