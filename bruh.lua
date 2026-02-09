-- Blade Ball Fast Flags (UwU Edition)
-- Structure inspired by Bloxstrap/Premium scripts
-- Optimized for Blade Ball performance

-- === COMPATIBILITY & SECURITY ===
local cloneref = (typeof(cloneref) == "function") and cloneref or function(obj) return obj end
local setfflag = (typeof(setfflag) == "function") and setfflag or function() end

local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local HttpService = cloneref(game:GetService("HttpService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local Lighting = cloneref(game:GetService("Lighting"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local Stats = cloneref(game:GetService("Stats"))

-- === CONFIGURATION SYSTEM ===
local FOLDER_NAME = "UwU_Flags"
local CONFIG_FILE = FOLDER_NAME .. "/Config.json"

if not isfolder(FOLDER_NAME) then makefolder(FOLDER_NAME) end

local Config = {
    Preset = "None",
    FPSCap = 60,
    HitregFix = true
}

local function SaveConfig()
    writefile(CONFIG_FILE, HttpService:JSONEncode(Config))
end

local function LoadConfig()
    if isfile(CONFIG_FILE) then
        local success, result = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
        if success then Config = result end
    end
end
LoadConfig()

-- === UTILS ===
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- === FAST FLAGS & OPTIMIZATIONS ===
local function ToggleFFlag(name, value)
    pcall(function()
        setfflag(name, tostring(value))
    end)
end

local function ApplyHitregFix()
    local FFlags = {
        ["DFIntCodecMaxIncomingPackets"] = "100",
        ["DFIntCodecMaxOutgoingFrames"] = "10000",
        ["DFIntLargePacketQueueSizeCutoffMB"] = "1000",
        ["DFIntMaxProcessPacketsJobScaling"] = "10000",
        ["DFIntMaxProcessPacketsStepsAccumulated"] = "0",
        ["DFIntMaxProcessPacketsStepsPerCyclic"] = "5000",
        ["DFIntMegaReplicatorNetworkQualityProcessorUnit"] = "10",
        ["DFIntNetworkLatencyTolerance"] = "1",
        ["DFIntNetworkPrediction"] = "120",
        ["DFIntOptimizePingThreshold"] = "50",
        ["DFIntPlayerNetworkUpdateQueueSize"] = "20",
        ["DFIntPlayerNetworkUpdateRate"] = "60",
        ["DFIntRaknetBandwidthInfluxHundredthsPercentageV2"] = "10000",
        ["DFIntRaknetBandwidthPingSendEveryXSeconds"] = "1",
        ["DFIntRakNetLoopMs"] = "1",
        ["DFIntRakNetResendRttMultiple"] = "1",
        ["DFIntServerPhysicsUpdateRate"] = "60",
        ["DFIntServerTickRate"] = "60",
        ["DFIntWaitOnRecvFromLoopEndedMS"] = "100",
        ["DFIntWaitOnUpdateNetworkLoopEndedMS"] = "100",
        ["FFlagOptimizeNetwork"] = "true",
        ["FFlagOptimizeNetworkRouting"] = "true",
        ["FFlagOptimizeNetworkTransport"] = "true",
        ["FFlagOptimizeServerTickRate"] = "true",
        ["FIntRakNetResendBufferArrayLength"] = "128"
    }
    for flag, val in pairs(FFlags) do
        ToggleFFlag(flag, val)
    end
end

local function ApplySimple()
    Config.Preset = "Simple"
    SaveConfig()
    
    -- Lighting
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = false end
        end
    end)
    
    -- FFlags
    ToggleFFlag("DFIntTaskSchedulerTargetFps", 144)
    ToggleFFlag("FFlagDebugDisplayFPS", true) -- Show FPS
    
    Notify("UwU FLAGS", "Simple Optimization Applied ✓", 3)
end

local function ApplyUltra()
    Config.Preset = "Ultra"
    SaveConfig()
    
    -- Extreme Visual Cleanup
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj.Enabled = false
            elseif obj:IsA("PostEffect") or obj:IsA("Explosion") or obj:IsA("Atmosphere") or obj:IsA("Sky") or obj:IsA("Clouds") then
                obj:Destroy()
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            end
        end)
    end
    
    -- FFlags & Hitreg
    ToggleFFlag("DFIntTaskSchedulerTargetFps", 9999)
    ToggleFFlag("FIntRenderShadowIntensity", 0)
    
    -- CPU Optimizations
    ToggleFFlag("FFlagRenderDebugCheckThreading2", true)
    ToggleFFlag("FFlagMainThreadYielding", true)
    ToggleFFlag("FFlagMovePrerenderV2", true)
    ToggleFFlag("FFlagParallelTaskScheduler", true)
    ToggleFFlag("FIntMainThreadPriority", 3)
    
    -- Best Ever / User Requests
    ToggleFFlag("FFlagDebugSkyGray", true) -- Grey Sky
    ToggleFFlag("FFlagDebugDisplayFPS", true) -- Show FPS
    ToggleFFlag("DFIntS2PhysicsSenderRate", 1) -- Lag Ball (Desync)
    
    -- User Provided List
    ToggleFFlag("FFlagHandleAltEnterFullscreenManually", false)
    ToggleFFlag("DFIntCSGLevelOfDetailSwitchingDistance", 0)
    ToggleFFlag("DFIntCSGLevelOfDetailSwitchingDistanceL12", 0)
    ToggleFFlag("DFIntCSGLevelOfDetailSwitchingDistanceL23", 0)
    ToggleFFlag("DFIntCSGLevelOfDetailSwitchingDistanceL34", 0)
    ToggleFFlag("DFFlagTextureQualityOverrideEnabled", true)
    ToggleFFlag("DFIntTextureQualityOverride", 1)
    ToggleFFlag("FIntDebugForceMSAASamples", 4)
    ToggleFFlag("DFFlagDisableDPIScale", true)
    ToggleFFlag("FFlagDebugGraphicsPreferD3D11", true)
    ToggleFFlag("DFFlagDebugPauseVoxelizer", true)
    ToggleFFlag("DFIntDebugFRMQualityLevelOverride", 1)
    ToggleFFlag("FIntFRMMaxGrassDistance", 0)
    ToggleFFlag("FIntFRMMinGrassDistance", 0)
    ToggleFFlag("FFlagDebugGraphicsPreferVulkan", false)
    ToggleFFlag("FFlagDebugGraphicsPreferOpenGL", false)
    ToggleFFlag("FIntGrassMovementReducedMotionFactor", 0)
    
    ApplyHitregFix()
    
    Notify("UwU FLAGS", "Ultra + Ultimate FFlags Applied ⚡", 3)
end

-- === UI CREATION (Glass Pill Style) ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UwUFlagsPro"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if LocalPlayer.PlayerGui:FindFirstChild("UwUFlagsPro") then
    LocalPlayer.PlayerGui.UwUFlagsPro:Destroy()
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.Size = UDim2.new(0, 400, 0, 250)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 100, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Blade Ball FastFlags"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 45)
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Select your preset for maximum performance"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
Subtitle.TextSize = 14

-- Simple Button
local SimpleBtn = Instance.new("TextButton")
SimpleBtn.Name = "SimpleBtn"
SimpleBtn.Parent = MainFrame
SimpleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SimpleBtn.BorderSizePixel = 0
SimpleBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
SimpleBtn.Size = UDim2.new(0, 150, 0, 100)
SimpleBtn.Font = Enum.Font.GothamBold
SimpleBtn.Text = "SIMPLE"
SimpleBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
SimpleBtn.TextSize = 18

local SimpleCorner = Instance.new("UICorner")
SimpleCorner.CornerRadius = UDim.new(0, 15)
SimpleCorner.Parent = SimpleBtn

-- Ultra Button
local UltraBtn = Instance.new("TextButton")
UltraBtn.Name = "UltraBtn"
UltraBtn.Parent = MainFrame
UltraBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
UltraBtn.BorderSizePixel = 0
UltraBtn.Position = UDim2.new(0.55, 0, 0.4, 0)
UltraBtn.Size = UDim2.new(0, 150, 0, 100)
UltraBtn.Font = Enum.Font.GothamBold
UltraBtn.Text = "ULTRA"
UltraBtn.TextColor3 = Color3.fromRGB(255, 100, 150)
UltraBtn.TextSize = 18

local UltraCorner = Instance.new("UICorner")
UltraCorner.CornerRadius = UDim.new(0, 15)
UltraCorner.Parent = UltraBtn

-- Interaction Handlers
SimpleBtn.MouseButton1Click:Connect(function()
    ApplySimple()
    MainFrame:TweenPosition(UDim2.new(0.5, -200, -0.5, 0), "In", "Back", 0.5, true)
    task.wait(0.5)
    ScreenGui:Destroy()
end)

UltraBtn.MouseButton1Click:Connect(function()
    ApplyUltra()
    MainFrame:TweenPosition(UDim2.new(0.5, -200, -0.5, 0), "In", "Back", 0.5, true)
    task.wait(0.5)
    ScreenGui:Destroy()
end)

-- Hover Effects
local function AddHover(btn, color)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = color:Lerp(Color3.new(0,0,0), 0.5)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end)
end

AddHover(SimpleBtn, Color3.fromRGB(100, 150, 255))
AddHover(UltraBtn, Color3.fromRGB(255, 100, 150))

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextSize = 20

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Parent to PlayerGui
ScreenGui.Parent = LocalPlayer.PlayerGui

-- Entrance Animation
MainFrame.Position = UDim2.new(0.5, -200, -0.5, 0)
MainFrame:TweenPosition(UDim2.new(0.5, -200, 0.5, -125), "Out", "Back", 0.6, true)

Notify("UwU FLAGS", "Blade Ball Pro FastFlags Loaded!", 3)
