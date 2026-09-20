local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

-- Config đường link web Get Key
local WEB_GET_KEY_URL = "https://hoang0403122-ship-it.github.io/Hoangaura-key/"

-- Link RAW Script chính (Lennon Hub)
local MAIN_SCRIPT_RAW = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua"

-- KEY CỐ ĐỊNH
local HARDCODED_KEY = "KEY-LENNONHUBV3"

-- Tên file lưu Key trên thiết bị
local KEY_FILE_NAME = "HoangauraKey.txt"

-- ==================== HÀM CHẠY SCRIPT CHÍNH ====================
local function loadMainScript()
    print("Key chính xác! Đang tải Script chính...")
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(MAIN_SCRIPT_RAW))()
    end)
    
    if success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Lennon Hub",
            Text = "Kích hoạt thành công! Script đã hoạt động.",
            Duration = 5
        })
    else
        warn("Lỗi tải Script chính:", err)
    end
end

-- ==================== KIỂM TRA KEY ĐÃ LƯU CHƯA ====================
local function checkSavedKey()
    if readfile and isfile and isfile(KEY_FILE_NAME) then
        local savedKey = readfile(KEY_FILE_NAME)
        savedKey = string.gsub(savedKey, "%s+", "") -- Xóa khoảng trắng thừa
        if savedKey == HARDCODED_KEY then
            return true
        end
    end
    return false
end

-- Nếu đã nhập Key đúng từ trước ➔ Bỏ qua Bảng Key và Chạy Script Luôn!
if checkSavedKey() then
    loadMainScript()
    return
end

-- ==================== GIAO DIỆN GET KEY GUI (Chạy khi chưa có Key) ====================
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
SubTitle.Text = "Nhập Key 1 lần duy nhất để lưu trên thiết bị"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
SubTitle.TextSize = 14

KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
KeyInput.Position = UDim2.new(0.08, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.84, 0, 0, 40)
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.PlaceholderText = "Dán Key vào đây..."
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

    if userKey == HARDCODED_KEY then
        SubTitle.Text = "Key chính xác! Đã lưu Key..."
        SubTitle.TextColor3 = Color3.fromRGB(50, 255, 126)
        
        -- Lưu Key vào bộ nhớ thiết bị
        if writefile then
            writefile(KEY_FILE_NAME, userKey)
        end

        task.wait(1)
        KeySystemGui:Destroy()
        loadMainScript()
    else
        SubTitle.Text = "Key không đúng! Vui lòng kiểm tra lại."
        SubTitle.TextColor3 = Color3.fromRGB(255, 75, 75)
    end
end)
