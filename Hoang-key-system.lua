local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local HUBS = {
    {
        Name = "VoidShell Hub",
        Prefix = "VOID",
        Color1 = Color3.fromRGB(245, 158, 11),
        ScriptUrl = "https://raw.githubusercontent.com/VoidShell-null/VoidShell-Hub/refs/heads/main/Scripts/StealAnEgg.luau",
        FileName = "VoidShell_Key.txt"
    },
    {
        Name = "WhiteX Hub",
        Prefix = "WHITEX",
        Color1 = Color3.fromRGB(236, 72, 153),
        ScriptUrl = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau",
        FileName = "WhiteX_Key.txt"
    },
    {
        Name = "VZStudio Hub",
        Prefix = "VZ",
        Color1 = Color3.fromRGB(6, 182, 212),
        ScriptUrl = "http://vxezestudio.online/api/scripts/script_G5CGjqj2X3rOS/strem/init",
        FileName = "VZStudio_Key.txt"
    },
    {
        Name = "JualNasi Hub",
        Prefix = "JUAL",
        Color1 = Color3.fromRGB(16, 185, 129),
        ScriptUrl = "https://raw.githubusercontent.com/JualNasiRendang/loader/refs/heads/main/main.lua",
        FileName = "JualNasi_Key.txt"
    }
}

local WEB_GET_KEY_URL = "https://hoang0403122-ship-it.github.io/Hoangaura-key/"

local function getExpectedKey(prefix)
    local success, dt = pcall(function() return os.date("!*t", os.time() + 25200) end)
    if success and dt then
        return string.format("%s-%d%d%d-%s", prefix, dt.year, dt.month, dt.day, dt.hour < 12 and "P1" or "P2")
    end
    return prefix .. "-FALLBACK"
end

local function sendNotif(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
    end)
end

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 14)
    corner.Parent = parent
end

local function addStroke(parent, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Transparency = transparency or 0.7
    stroke.Thickness = 1.5
    stroke.Parent = parent
end

local function openHubSelector()
    local oldGui = (game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")):FindFirstChild("MultiHubSelector")
    if oldGui then oldGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MultiHubSelector"
    ScreenGui.Parent = (game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 14, 21)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 370)
    addCorner(MainFrame, 18)
    addStroke(MainFrame, Color3.fromRGB(147, 51, 234), 0.4)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 21, 33)
    TopBar.Size = UDim2.new(1, 0, 0, 48)
    addCorner(TopBar, 18)

    local FixBar = Instance.new("Frame", TopBar)
    FixBar.BackgroundColor3 = Color3.fromRGB(20, 21, 33)
    FixBar.BorderSizePixel = 0
    FixBar.Position = UDim2.new(0, 0, 0.5, 0)
    FixBar.Size = UDim2.new(1, 0, 0.5, 0)

    local Title = Instance.new("TextLabel", TopBar)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Size = UDim2.new(0.8, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "✨ AURA MULTI-HUB SYSTEM"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    CloseBtn.Position = UDim2.new(1, -12, 0.5, 0)
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 13
    addCorner(CloseBtn, 8)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local SubTitle = Instance.new("TextLabel", MainFrame)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0, 20, 0, 55)
    SubTitle.Size = UDim2.new(1, -40, 0, 20)
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.Text = "Chọn Hub bạn muốn sử dụng bên dưới:"
    SubTitle.TextColor3 = Color3.fromRGB(156, 163, 175)
    SubTitle.TextSize = 12
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left

    for i, hub in ipairs(HUBS) do
        local hasKey = false
        pcall(function()
            if readfile and isfile and isfile(hub.FileName) then
                if string.gsub(readfile(hub.FileName), "%s+", "") == getExpectedKey(hub.Prefix) then
                    hasKey = true
                end
            end
        end)

        local HubBtn = Instance.new("TextButton", MainFrame)
        HubBtn.BackgroundColor3 = Color3.fromRGB(26, 28, 43)
        HubBtn.Position = UDim2.new(0.05, 0, 0, 82 + ((i - 1) * 65))
        HubBtn.Size = UDim2.new(0.9, 0, 0, 52)
        HubBtn.Font = Enum.Font.GothamBold
        HubBtn.Text = hasKey and ("⭐ " .. hub.Name .. " (Đã có Key)") or ("🚀 Mở " .. hub.Name)
        HubBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        HubBtn.TextSize = 13
        addCorner(HubBtn, 12)
        addStroke(HubBtn, hub.Color1, 0.3)

        HubBtn.MouseButton1Click:Connect(function()
            if hasKey then
                ScreenGui:Destroy()
                sendNotif(hub.Name, "Đang khởi chạy script...")
                pcall(function() loadstring(game:HttpGet(hub.ScriptUrl))() end)
            else
                ScreenGui:Destroy()
                
                local KeyGui = Instance.new("ScreenGui")
                KeyGui.Name = "KeyInputGui"
                KeyGui.Parent = (game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
                KeyGui.ResetOnSpawn = false
                
                local Frame = Instance.new("Frame", KeyGui)
                Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                Frame.BackgroundColor3 = Color3.fromRGB(13, 14, 21)
                Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
                Frame.Size = UDim2.new(0, 380, 0, 230)
                addCorner(Frame, 18)
                addStroke(Frame, hub.Color1, 0.3)
                
                local TB = Instance.new("Frame", Frame)
                TB.BackgroundColor3 = Color3.fromRGB(20, 21, 33)
                TB.Size = UDim2.new(1, 0, 0, 44)
                addCorner(TB, 18)

                local FixTB = Instance.new("Frame", TB)
                FixTB.BackgroundColor3 = Color3.fromRGB(20, 21, 33)
                FixTB.BorderSizePixel = 0
                FixTB.Position = UDim2.new(0, 0, 0.5, 0)
                FixTB.Size = UDim2.new(1, 0, 0.5, 0)
                
                local TText = Instance.new("TextLabel", TB)
                TText.BackgroundTransparency = 1
                TText.Position = UDim2.new(0, 18, 0, 0)
                TText.Size = UDim2.new(0.55, 0, 1, 0)
                TText.Font = Enum.Font.GothamBold
                TText.Text = "🔑 " .. string.upper(hub.Name)
                TText.TextColor3 = hub.Color1
                TText.TextSize = 13
                TText.TextXAlignment = Enum.TextXAlignment.Left

                local BackBtn = Instance.new("TextButton", TB)
                BackBtn.AnchorPoint = Vector2.new(1, 0.5)
                BackBtn.BackgroundColor3 = Color3.fromRGB(40, 42, 60)
                BackBtn.Position = UDim2.new(1, -12, 0.5, 0)
                BackBtn.Size = UDim2.new(0, 80, 0, 28)
                BackBtn.Font = Enum.Font.GothamBold
                BackBtn.Text = "⬅ Quay lại"
                BackBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                BackBtn.TextSize = 11
                addCorner(BackBtn, 8)
                
                BackBtn.MouseButton1Click:Connect(function()
                    KeyGui:Destroy()
                    openHubSelector()
                end)
                
                local Input = Instance.new("TextBox", Frame)
                Input.BackgroundColor3 = Color3.fromRGB(20, 21, 33)
                Input.Position = UDim2.new(0.05, 0, 0.35, 0)
                Input.Size = UDim2.new(0.9, 0, 0, 44)
                Input.Font = Enum.Font.GothamBold
                Input.PlaceholderText = "Dán Key 12h vào đây..."
                Input.PlaceholderColor3 = Color3.fromRGB(100, 105, 120)
                Input.Text = ""
                Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                Input.TextSize = 13
                addCorner(Input, 10)
                addStroke(Input, Color3.fromRGB(255, 255, 255), 0.8)
                
                local GetBtn = Instance.new("TextButton", Frame)
                GetBtn.BackgroundColor3 = Color3.fromRGB(35, 38, 56)
                GetBtn.Position = UDim2.new(0.05, 0, 0.68, 0)
                GetBtn.Size = UDim2.new(0.43, 0, 0, 42)
                GetBtn.Font = Enum.Font.GothamBold
                GetBtn.Text = "🌐 GET KEY"
                GetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                GetBtn.TextSize = 13
                addCorner(GetBtn, 10)
                
                local CheckBtn = Instance.new("TextButton", Frame)
                CheckBtn.BackgroundColor3 = hub.Color1
                CheckBtn.Position = UDim2.new(0.52, 0, 0.68, 0)
                CheckBtn.Size = UDim2.new(0.43, 0, 0, 42)
                CheckBtn.Font = Enum.Font.GothamBold
                CheckBtn.Text = "🚀 CHECK"
                CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                CheckBtn.TextSize = 13
                addCorner(CheckBtn, 10)
                
                GetBtn.MouseButton1Click:Connect(function()
                    pcall(function() setclipboard(WEB_GET_KEY_URL) end)
                    sendNotif("Link", "Đã copy link trang web Get Key thành công!")
                end)
                
                CheckBtn.MouseButton1Click:Connect(function()
                    local userKey = string.gsub(Input.Text or "", "%s+", "")
                    if userKey == getExpectedKey(hub.Prefix) then
                        pcall(function() writefile(hub.FileName, userKey) end)
                        sendNotif("Thành công", "Key chính xác! Đang mở Hub...")
                        KeyGui:Destroy()
                        task.wait(0.5)
                        pcall(function() loadstring(game:HttpGet(hub.ScriptUrl))() end)
                    else
                        sendNotif("Lỗi", "Key không chính xác hoặc đã hết phiên 12h!")
                    end
                end)
            end
        end)
    end
end

openHubSelector()
