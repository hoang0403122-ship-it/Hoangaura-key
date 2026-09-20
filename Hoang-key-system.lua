local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

-- Config đường link web Get Key
local WEB_GET_KEY_URL = "https://hoang0403122-ship-it.github.io/Hoangaura-key/"

-- 🔴 DÁN LINK RAW SCRIPT HACK CHÍNH CỦA BẠN VÀO ĐÂY (KHÔNG DÁN LINK HOANG-KEY-SYSTEM!):
local MAIN_SCRIPT_RAW = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua"

-- Hàm lấy HWID / Client ID duy nhất của người chơi
local function getHWID()
    local rawId = LocalPlayer.UserId .. "-" .. game:GetService("RbxAnalyticsService"):GetClientId()
    return rawId
end

-- Hàm tạo Key kỳ vọng theo thuật toán
local function getExpectedKey()
    local hwid = getHWID()
    local hash = 0
    for i = 1, #hwid do
        hash = (hash * 31 + string.byte(hwid, i, i)) % 4294967296
    end
    local hexHash = string.upper(string.format("%08x", hash))
    return "KEY-" .. string.sub(hexHash, 1, 4) .. "-" .. string.sub(hexHash, 5, 8)
end

-- ==================== HÀM CHẠY SCRIPT CHÍNH ====================
local function loadMainScript()
    print("Key chính xác! Đang tải Script chính từ GitHub...")
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(MAIN_SCRIPT_RAW))()
    end)
    
    if success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hoangaura Hub",
            Text = "Kích hoạt thành công! Script chính đã hoạt động.",
            Duration = 5
        })
    else
        warn("Lỗi tải Script chính:", err)
    end
end

-- ==================== GIAO DIỆN GET KEY GUI ====================
local KeySystemGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local InputCorner = Instance.new("UICorner")
local GetKeyBtn = Instance.new("TextButton")
local GetKeyCorner = Instance.new("UICorner")
local CheckKeyBtn = Instance.new("TextButton")
local CheckCorner = Instance.new("UICorner")

KeySystemGui.Name = "KeySystemGui"
KeySystemGui.Parent = (game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
KeySystemGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = KeySystemGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 37)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 250)

UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.FredokaOne
Title.Text = "🔑 HOANGAURA KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

SubTitle.Name = "SubTitle"
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 45)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.Text = "Nhập Key của bạn để mở khóa Script"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
SubTitle.TextSize = 14

KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
KeyInput.Position = UDim2.new(0.08, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.84, 0, 0, 40)
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.PlaceholderText = "Dán Key vào đây (KEY-XXXX-XXXX)..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14

InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyInput

GetKeyBtn.Name = "GetKeyBtn"
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
GetKeyBtn.Position = UDim2.new(0.08, 0, 0.62, 0)
GetKeyBtn.Size = UDim2.new(0.4, 0, 0, 40)
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.Text = "🌐 Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 16

GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

CheckKeyBtn.Name = "CheckKeyBtn"
CheckKeyBtn.Parent = MainFrame
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
CheckKeyBtn.Position = UDim2.new(0.52, 0, 0.62, 0)
CheckKeyBtn.Size = UDim2.new(0.4, 0, 0, 40)
CheckKeyBtn.Font = Enum.Font.SourceSansBold
CheckKeyBtn.Text = "🚀 Check Key"
CheckKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckKeyBtn.TextSize = 16

CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckKeyBtn

-- ==================== SỰ KIỆN NÚT BẤM ====================

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(WEB_GET_KEY_URL)
        SubTitle.Text = "Đã copy link Web Get Key vào bộ nhớ tạm!"
        SubTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    else
        GuiService:OpenBrowserWindow(WEB_GET_KEY_URL)
    end
end)

CheckKeyBtn.MouseButton1Click:Connect(function()
    local userKey = string.gsub(KeyInput.Text, "%s+", "")
    local expectedKey = getExpectedKey()

    if userKey == expectedKey then
        SubTitle.Text = "Key chính xác! Đang tải..."
        SubTitle.TextColor3 = Color3.fromRGB(50, 255, 126)
        
        task.wait(1)
        KeySystemGui:Destroy()
        loadMainScript()
    else
        SubTitle.Text = "Key không đúng hoặc không thuộc về máy này!"
        SubTitle.TextColor3 = Color3.fromRGB(255, 75, 75)
    end
end)
