-- Blade Ball Fast Flags Script
-- UwU FLAGS - Performance Optimization

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- Notification Function
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- Fast Flags Configuration
local FastFlags = {
    Simple = {
        -- Basic Performance Flags
        ["FFlagDebugRenderForceTechnologyVoxel"] = "false",
        ["DFFlagDebugRenderForceTechnologyVoxel"] = "false",
        ["FFlagRenderFixFog"] = "false",
        ["DFIntDebugFRMQualityLevelOverride"] = "1",
        ["DFFlagDebugPauseVoxelizer"] = "true",
        ["FFlagGlobalWindRendering"] = "false",
        ["FIntRenderShadowIntensity"] = "0",
        ["DFIntTextureCompositorActiveJobs"] = "1",
        ["DFIntCSGLevelOfDetailSwitchingDistance"] = "0",
        ["DFIntCSGLevelOfDetailSwitchingDistanceL12"] = "0",
        ["DFIntCSGLevelOfDetailSwitchingDistanceL23"] = "0",
        ["DFIntCSGLevelOfDetailSwitchingDistanceL34"] = "0",
        ["FIntTerrainArraySliceSize"] = "4",
        ["FIntFRMMinGrassDistance"] = "0",
        ["FIntFRMMaxGrassDistance"] = "0",
        ["FIntRenderGrassDetailStrands"] = "0",
        ["FIntRenderGrassHeightScaler"] = "0",
    },
    
    Ultra = {
        -- Aggressive Performance Flags
        ["FFlagDebugRenderForceTechnologyVoxel"] = "false",
        ["DFFlagDebugRenderForceTechnologyVoxel"] = "false",
        ["FFlagRenderFixFog"] = "false",
        ["DFIntDebugFRMQualityLevelOverride"] = "1",
        ["DFFlagDebugPauseVoxelizer"] = "true",
        ["FFlagGlobalWindRendering"] = "false",
        ["FIntRenderShadowIntensity"] = "0",
        ["DFIntTextureCompositorActiveJobs"] = "1",
        ["DFIntCSGLevelOfDetailSwitchingDistance"] = "0",
        ["DFIntCSGLevelOfDetailSwitchingDistanceL12"] = "0",
        ["DFIntCSGLevelOfDetailSwitchingDistanceL23"] = "0",
        ["DFIntCSGLevelOfDetailSwitchingDistanceL34"] = "0",
        ["FIntTerrainArraySliceSize"] = "4",
        ["FIntFRMMinGrassDistance"] = "0",
        ["FIntFRMMaxGrassDistance"] = "0",
        ["FIntRenderGrassDetailStrands"] = "0",
        ["FIntRenderGrassHeightScaler"] = "0",
        -- Ultra Additional Flags
        ["FFlagDisablePostFx"] = "true",
        ["FIntDebugTextureManagerSkipMips"] = "8",
        ["DFIntTimestepArbiterThresholdCFLThou"] = "300",
        ["DFFlagVideoCaptureServiceEnabled"] = "false",
        ["FFlagEnableInGameMenuChromeABTest3"] = "false",
        ["FFlagEnableReportAbuseMenuRoactABTest2"] = "false",
        ["FFlagEnableInGameMenuModernization"] = "false",
        ["DFIntTaskSchedulerTargetFps"] = "240",
        ["FFlagTaskSchedulerLimitTargetFpsTo2402"] = "false",
        ["DFIntDefaultTimeoutTimeMs"] = "10000",
        ["DFIntHttpCurlConnectionCacheSize"] = "134217728",
        ["DFIntConnectionMTUSize"] = "MTU_1492",
        ["DFIntUserIdPlayerNameCacheSize"] = "100000",
        ["DFIntUserIdPlayerNameLifetimeSeconds"] = "86400",
    }
}

-- Apply Fast Flags Function
local function ApplyFastFlags(preset)
    local flags = FastFlags[preset]
    if not flags then
        Notify("Error", "Invalid preset: " .. tostring(preset), 5)
        return false
    end
    
    local success = 0
    local failed = 0
    
    for flag, value in pairs(flags) do
        local ok, err = pcall(function()
            if type(value) == "string" then
                if value == "true" then
                    setfflag(flag, true)
                elseif value == "false" then
                    setfflag(flag, false)
                else
                    setfflag(flag, value)
                end
            else
                setfflag(flag, value)
            end
        end)
        
        if ok then
            success = success + 1
        else
            failed = failed + 1
        end
    end
    
    return success, failed
end

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UwUFlagsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Check if GUI already exists
if LocalPlayer.PlayerGui:FindFirstChild("UwUFlagsGui") then
    LocalPlayer.PlayerGui.UwUFlagsGui:Destroy()
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
MainFrame.Size = UDim2.new(0, 700, 0, 400)

-- UI Corner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Font = Enum.Font.GothamBold
Title.Text = "UwU FLAGS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 48
Title.TextStrokeTransparency = 0.8

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 80)
Subtitle.Size = UDim2.new(1, 0, 0, 30)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Select your optimization preset"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
Subtitle.TextSize = 18

-- Premium Button (Top Right)
local PremiumBtn = Instance.new("TextButton")
PremiumBtn.Name = "PremiumBtn"
PremiumBtn.Parent = MainFrame
PremiumBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
PremiumBtn.BorderSizePixel = 0
PremiumBtn.Position = UDim2.new(1, -120, 0, 20)
PremiumBtn.Size = UDim2.new(0, 100, 0, 35)
PremiumBtn.Font = Enum.Font.GothamBold
PremiumBtn.Text = "PREMIUM"
PremiumBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
PremiumBtn.TextSize = 14

local PremiumCorner = Instance.new("UICorner")
PremiumCorner.CornerRadius = UDim.new(0, 6)
PremiumCorner.Parent = PremiumBtn

local PremiumStroke = Instance.new("UIStroke")
PremiumStroke.Color = Color3.fromRGB(100, 150, 255)
PremiumStroke.Thickness = 2
PremiumStroke.Parent = PremiumBtn

-- Simple FastFlag Button
local SimpleBtn = Instance.new("TextButton")
SimpleBtn.Name = "SimpleBtn"
SimpleBtn.Parent = MainFrame
SimpleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SimpleBtn.BorderSizePixel = 0
SimpleBtn.Position = UDim2.new(0.05, 0, 0, 150)
SimpleBtn.Size = UDim2.new(0.9, 0, 0, 80)
SimpleBtn.Font = Enum.Font.GothamBold
SimpleBtn.Text = ""
SimpleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SimpleBtn.TextSize = 24

local SimpleCorner = Instance.new("UICorner")
SimpleCorner.CornerRadius = UDim.new(0, 10)
SimpleCorner.Parent = SimpleBtn

local SimpleStroke = Instance.new("UIStroke")
SimpleStroke.Color = Color3.fromRGB(100, 150, 255)
SimpleStroke.Thickness = 2
SimpleStroke.Parent = SimpleBtn

-- Simple Icon
local SimpleIcon = Instance.new("ImageLabel")
SimpleIcon.Name = "Icon"
SimpleIcon.Parent = SimpleBtn
SimpleIcon.BackgroundTransparency = 1
SimpleIcon.Position = UDim2.new(0, 20, 0.5, -20)
SimpleIcon.Size = UDim2.new(0, 40, 0, 40)
SimpleIcon.Image = "rbxassetid://7733964640" -- Cloud download icon
SimpleIcon.ImageColor3 = Color3.fromRGB(100, 150, 255)

-- Simple Label
local SimpleLabel = Instance.new("TextLabel")
SimpleLabel.Name = "Label"
SimpleLabel.Parent = SimpleBtn
SimpleLabel.BackgroundTransparency = 1
SimpleLabel.Position = UDim2.new(0, 80, 0, 0)
SimpleLabel.Size = UDim2.new(1, -100, 1, 0)
SimpleLabel.Font = Enum.Font.GothamBold
SimpleLabel.Text = "Simple FastFlag"
SimpleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SimpleLabel.TextSize = 24
SimpleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Simple Arrow
local SimpleArrow = Instance.new("TextLabel")
SimpleArrow.Name = "Arrow"
SimpleArrow.Parent = SimpleBtn
SimpleArrow.BackgroundTransparency = 1
SimpleArrow.Position = UDim2.new(1, -40, 0.5, -15)
SimpleArrow.Size = UDim2.new(0, 30, 0, 30)
SimpleArrow.Font = Enum.Font.GothamBold
SimpleArrow.Text = "→"
SimpleArrow.TextColor3 = Color3.fromRGB(150, 150, 160)
SimpleArrow.TextSize = 28

-- Ultra FastFlag Button
local UltraBtn = Instance.new("TextButton")
UltraBtn.Name = "UltraBtn"
UltraBtn.Parent = MainFrame
UltraBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
UltraBtn.BorderSizePixel = 0
UltraBtn.Position = UDim2.new(0.05, 0, 0, 250)
UltraBtn.Size = UDim2.new(0.9, 0, 0, 80)
UltraBtn.Font = Enum.Font.GothamBold
UltraBtn.Text = ""
UltraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UltraBtn.TextSize = 24

local UltraCorner = Instance.new("UICorner")
UltraCorner.CornerRadius = UDim.new(0, 10)
UltraCorner.Parent = UltraBtn

local UltraStroke = Instance.new("UIStroke")
UltraStroke.Color = Color3.fromRGB(255, 100, 150)
UltraStroke.Thickness = 2
UltraStroke.Parent = UltraBtn

-- Ultra Icon
local UltraIcon = Instance.new("ImageLabel")
UltraIcon.Name = "Icon"
UltraIcon.Parent = UltraBtn
UltraIcon.BackgroundTransparency = 1
UltraIcon.Position = UDim2.new(0, 20, 0.5, -20)
UltraIcon.Size = UDim2.new(0, 40, 0, 40)
UltraIcon.Image = "rbxassetid://7733964640" -- Cloud download icon
UltraIcon.ImageColor3 = Color3.fromRGB(255, 100, 150)

-- Ultra Label
local UltraLabel = Instance.new("TextLabel")
UltraLabel.Name = "Label"
UltraLabel.Parent = UltraBtn
UltraLabel.BackgroundTransparency = 1
UltraLabel.Position = UDim2.new(0, 80, 0, 0)
UltraLabel.Size = UDim2.new(1, -100, 1, 0)
UltraLabel.Font = Enum.Font.GothamBold
UltraLabel.Text = "Ultra FastFlag"
UltraLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UltraLabel.TextSize = 24
UltraLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ultra Arrow
local UltraArrow = Instance.new("TextLabel")
UltraArrow.Name = "Arrow"
UltraArrow.Parent = UltraBtn
UltraArrow.BackgroundTransparency = 1
UltraArrow.Position = UDim2.new(1, -40, 0.5, -15)
UltraArrow.Size = UDim2.new(0, 30, 0, 30)
UltraArrow.Font = Enum.Font.GothamBold
UltraArrow.Text = "→"
UltraArrow.TextColor3 = Color3.fromRGB(150, 150, 160)
UltraArrow.TextSize = 28

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Name = "Footer"
Footer.Parent = MainFrame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0, 0, 1, -40)
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Font = Enum.Font.Gotham
Footer.Text = "UwU Flag Applicator"
Footer.TextColor3 = Color3.fromRGB(100, 150, 255)
Footer.TextSize = 14

-- Button Hover Effects
local function AddHoverEffect(button)
    button.MouseEnter:Connect(function()
        button:TweenSize(UDim2.new(0.92, 0, 0, 85), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end)
    
    button.MouseLeave:Connect(function()
        button:TweenSize(UDim2.new(0.9, 0, 0, 80), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end)
end

AddHoverEffect(SimpleBtn)
AddHoverEffect(UltraBtn)

-- Button Click Handlers
SimpleBtn.MouseButton1Click:Connect(function()
    Notify("UwU FLAGS", "Applying Simple FastFlags...", 3)
    task.wait(0.5)
    
    local success, failed = ApplyFastFlags("Simple")
    if success then
        Notify("Success!", "Applied " .. success .. " flags ✓", 5)
        MainFrame:TweenPosition(UDim2.new(0.5, -350, -0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.5, true)
        task.wait(0.5)
        ScreenGui:Destroy()
    else
        Notify("Error", "Failed to apply flags", 5)
    end
end)

UltraBtn.MouseButton1Click:Connect(function()
    Notify("UwU FLAGS", "Applying Ultra FastFlags...", 3)
    task.wait(0.5)
    
    local success, failed = ApplyFastFlags("Ultra")
    if success then
        Notify("Success!", "Applied " .. success .. " flags ✓", 5)
        MainFrame:TweenPosition(UDim2.new(0.5, -350, -0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.5, true)
        task.wait(0.5)
        ScreenGui:Destroy()
    else
        Notify("Error", "Failed to apply flags", 5)
    end
end)

PremiumBtn.MouseButton1Click:Connect(function()
    Notify("Premium", "Premium features coming soon!", 3)
end)

-- Draggable Frame
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Parent to PlayerGui
ScreenGui.Parent = LocalPlayer.PlayerGui

-- Entrance Animation
MainFrame.Position = UDim2.new(0.5, -350, -0.5, 0)
MainFrame:TweenPosition(UDim2.new(0.5, -350, 0.5, -200), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.6, true)

-- Initial Notification
Notify("UwU FLAGS", "Fast Flags GUI Loaded!", 3)
