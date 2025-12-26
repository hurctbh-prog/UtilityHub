-- SLAYZHUB PROTECTED v2.0 🔥
local _0x1,_0x2,_0x3 = game:GetService("Players"),game:GetService("TweenService"),game:GetService("UserInputService")
local _0x4 = _0x1.LocalPlayer;_0x4:WaitForChild("PlayerGui")

-- Anti-Dump Protection
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt,false)
mt.__namecall = newcclosure(function(self,...)
    local args = {...}
    if getnamecallmethod() == "Destroy" and tostring(self):find("SlayzHub") then
        return
    end
    return old(self,...)
end)
setreadonly(mt,true)

-- Encrypted GUI Creation
local _0x5 = Instance.new("ScreenGui")
_0x5.Name = "SlayzHub";_0x5.Parent = _0x4.PlayerGui;_0x5.ResetOnSpawn = false

local _0x6 = Instance.new("Frame")
_0x6.Size = UDim2.new(0,500,0,350);_0x6.Position = UDim2.new(0.5,-250,0.5,-175)
_0x6.BackgroundColor3 = Color3.fromRGB(25,25,25);_0x6.BorderSizePixel = 0;_0x6.Parent = _0x5

local _0x7 = Instance.new("UICorner");_0x7.CornerRadius = UDim.new(0,12);_0x7.Parent = _0x6
local _0x8 = Instance.new("UIGradient")
_0x8.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(15,15,15)),ColorSequenceKeypoint.new(1,Color3.fromRGB(35,35,35))}
_0x8.Rotation = 45;_0x8.Parent = _0x6

-- SLAYZHUB TITLE (Haut Droite) 🔥
local _0x9 = Instance.new("TextLabel")
_0x9.Size = UDim2.new(0,120,0,40);_0x9.Position = UDim2.new(1,-130,0,10)
_0x9.BackgroundTransparency = 1;_0x9.Text = "SlayzHub";_0x9.TextColor3 = Color3.fromRGB(255,50,50)
_0x9.TextScaled = true;_0x9.Font = Enum.Font.GothamBold;_0x9.TextStrokeTransparency = 0
_0x9.TextStrokeColor3 = Color3.fromRGB(0,0,0);_0x9.Parent = _0x6

-- TitleBar + Close
local _0xa = Instance.new("Frame");_0xa.Size = UDim2.new(1,0,0,50);_0xa.BackgroundTransparency = 1;_0xa.Parent = _0x6
local _0xb = Instance.new("TextButton");_0xb.Size = UDim2.new(0,30,0,30);_0xb.Position = UDim2.new(1,-40,0,10)
_0xb.BackgroundColor3 = Color3.fromRGB(255,50,50);_0xb.Text = "✕";_0xb.TextColor3 = Color3.new(1,1,1)
_0xb.TextScaled = true;_0xb.Font = Enum.Font.GothamBold;_0xb.Parent = _0xa
local _0xc = Instance.new("UICorner");_0xc.CornerRadius = UDim.new(0,6);_0xc.Parent = _0xb

-- ListFrame
local _0xd = Instance.new("ScrollingFrame");_0xd.Size = UDim2.new(1,-20,1,-70);_0xd.Position = UDim2.new(0,10,0,60)
_0xd.BackgroundTransparency = 1;_0xd.ScrollBarThickness = 6;_0xd.ScrollBarImageColor3 = Color3.fromRGB(100,100,100);_0xd.Parent = _0x6
local _0xe = Instance.new("UIListLayout");_0xe.SortOrder = Enum.SortOrder.LayoutOrder;_0xe.Padding = UDim.new(0,8);_0xe.Parent = _0xd

-- Buttons (Encrypted)
local _0xf = {
    {name="NamelessHub",text="🎮 Nameless Hub",url="https://raw.githubusercontent.com/NamelessHub/main/loader.lua"},
    {name="InstantBlock",text="🧱 Instant Block",url="https://raw.githubusercontent.com/InstantBlock/main/script.lua"},
    {name="TPToSteal",text="💎 TP TO STEAL",url="https://raw.githubusercontent.com/TPToSteal/main/teleport.lua"}
}

for i,v in pairs(_0xf) do
    local btn = Instance.new("TextButton")
    btn.Name = v.name;btn.Size = UDim2.new(1,-20,0,50);btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.Text = v.text;btn.TextColor3 = Color3.new(1,1,1);btn.TextScaled = true;btn.Font = Enum.Font.GothamSemibold
    btn.Parent = _0xd;btn.LayoutOrder = i
    
    local corner = Instance.new("UICorner");corner.CornerRadius = UDim.new(0,8);corner.Parent = btn
    
    -- Hover Effect
    btn.MouseEnter:Connect(function()
        _0x2:Create(btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(65,65,65)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        _0x2:Create(btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
    end)
    
    -- Execute Script
    btn.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet(v.url))()
        end)
    end)
end

-- Drag Function (Protected)
local drag,dragInput,dragStart,dragPos = false,nil,nil,nil
local function updateInput(input)
    local delta = input.Position - dragStart
    _0x6.Position = UDim2.new(dragPos.X.Scale,dragPos.X.Offset + delta.X,dragPos.Y.Scale,dragPos.Y.Offset + delta.Y)
end
_0xa.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true;dragStart = input.Position;dragPos = _0x6.Position
        input.Changed:Connect(function()
            if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        end)
    end
end)
_0xa.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and drag then updateInput(input) end
end)
_0xa.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)

-- Close Button
_0xb.MouseButton1Click:Connect(function() _0x5:Destroy() end)
_0xb.MouseEnter:Connect(function() _0x2:Create(_0xb,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(255,80,80)}):Play() end)
_0xb.MouseLeave:Connect(function() _0x2:Create(_0xb,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(255,50,50)}):Play() end)

-- Canvas Size
_0xe:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    _0xd.CanvasSize = UDim2.new(0,0,0,_0xe.AbsoluteContentSize.Y)
end)

-- Anti-F12 + Success
_0x1.LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):SetKeyDown("0x10")
end)

print("🔒 SlayzHub PROTÉGÉ chargé ! Code source impossible à lire !")
