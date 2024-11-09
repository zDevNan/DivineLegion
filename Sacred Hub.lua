local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Crimson Hub", "BloodTheme")

local Tab = Window:NewTab("Create / Teleport")
local Section = Tab:NewSection("Create / Teleport")
Section:NewButton("Get Force Power", "POWER!!!", function()
local function a(b, c)
    local d = getfenv(c)
    local e =
        setmetatable(
        {},
        {__index = function(self, f)
                if f == "script" then
                    return b
                else
                    return d[f]
                end
            end}
    )
    setfenv(c, e)
    return c
end
local g = {}
local h = Instance.new("Model", game:GetService("Lighting"))
local i = Instance.new("Tool")
local j = Instance.new("Part")
local k = Instance.new("Script")
local l = Instance.new("LocalScript")
local m = sethiddenproperty or set_hidden_property
i.Name = "Telekinesis"
i.Parent = h
i.Grip = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0)
i.GripForward = Vector3.new(-0, -1, -0)
i.GripRight = Vector3.new(0, 0, 1)
i.GripUp = Vector3.new(1, 0, 0)
j.Name = "Handle"
j.Parent = i
j.CFrame = CFrame.new(-17.2635937, 15.4915619, 46, 0, 1, 0, 1, 0, 0, 0, 0, -1)
j.Orientation = Vector3.new(0, 180, 90)
j.Position = Vector3.new(-17.2635937, 15.4915619, 46)
j.Rotation = Vector3.new(-180, 0, -90)
j.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
j.Transparency = 1
j.Size = Vector3.new(1, 1.20000005, 1)
j.BottomSurface = Enum.SurfaceType.Weld
j.BrickColor = BrickColor.new("Really black")
j.Material = Enum.Material.Metal
j.TopSurface = Enum.SurfaceType.Smooth
j.brickColor = BrickColor.new("Really black")
k.Name = "LineConnect"
k.Parent = i
table.insert(
    g,
    a(
        k,
        function()
            wait()
            local n = script.Part2
            local o = script.Part1.Value
            local p = script.Part2.Value
            local q = script.Par.Value
            local color = script.Color
            local r = Instance.new("Part")
            r.TopSurface = 0
            r.BottomSurface = 0
            r.Reflectance = .5
            r.Name = "Laser"
            r.Locked = true
            r.CanCollide = false
            r.Anchored = true
            r.formFactor = 0
            r.Size = Vector3.new(1, 1, 1)
            local s = Instance.new("BlockMesh")
            s.Parent = r
            while true do
                if n.Value == nil then
                    break
                end
                if o == nil or p == nil or q == nil then
                    break
                end
                if o.Parent == nil or p.Parent == nil then
                    break
                end
                if q.Parent == nil then
                    break
                end
                local t = CFrame.new(o.Position, p.Position)
                local dist = (o.Position - p.Position).magnitude
                r.Parent = q
                r.BrickColor = color.Value.BrickColor
                r.Reflectance = color.Value.Reflectance
                r.Transparency = color.Value.Transparency
                r.CFrame = CFrame.new(o.Position + t.lookVector * dist / 2)
                r.CFrame = CFrame.new(r.Position, p.Position)
                s.Scale = Vector3.new(.25, .25, dist)
                wait()
            end
            r:remove()
            script:remove()
        end
    )
)
k.Disabled = true
l.Name = "MainScript"
l.Parent = i
table.insert(
    g,
    a(
        l,
        function()
            wait()
            tool = script.Parent
            lineconnect = tool.LineConnect
            object = nil
            mousedown = false
            found = false
            BP = Instance.new("BodyPosition")
            BP.maxForce = Vector3.new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge)
            BP.P = BP.P * 1.1
            dist = nil
            point = Instance.new("Part")
            point.Locked = true
            point.Anchored = true
            point.formFactor = 0
            point.Shape = 0
            point.BrickColor = BrickColor.Black()
            point.Size = Vector3.new(1, 1, 1)
            point.CanCollide = false
            local s = Instance.new("SpecialMesh")
            s.MeshType = "Sphere"
            s.Scale = Vector3.new(.7, .7, .7)
            s.Parent = point
            handle = tool.Handle
            front = tool.Handle
            color = tool.Handle
            objval = nil
            local u = false
            local v = BP:clone()
            v.maxForce = Vector3.new(30000, 30000, 30000)
            function LineConnect(o, p, q)
                local w = Instance.new("ObjectValue")
                w.Value = o
                w.Name = "Part1"
                local x = Instance.new("ObjectValue")
                x.Value = p
                x.Name = "Part2"
                local y = Instance.new("ObjectValue")
                y.Value = q
                y.Name = "Par"
                local z = Instance.new("ObjectValue")
                z.Value = color
                z.Name = "Color"
                local A = lineconnect:clone()
                A.Disabled = false
                w.Parent = A
                x.Parent = A
                y.Parent = A
                z.Parent = A
                A.Parent = workspace
                if p == object then
                    objval = x
                end
            end
            function onButton1Down(B)
                if mousedown == true then
                    return
                end
                mousedown = true
                coroutine.resume(
                    coroutine.create(
                        function()
                            local C = point:clone()
                            C.Parent = tool
                            LineConnect(front, C, workspace)
                            while mousedown == true do
                                C.Parent = tool
                                if object == nil then
                                    if B.Target == nil then
                                        local t = CFrame.new(front.Position, B.Hit.p)
                                        C.CFrame = CFrame.new(front.Position + t.lookVector * 1000)
                                    else
                                        C.CFrame = CFrame.new(B.Hit.p)
                                    end
                                else
                                    LineConnect(front, object, workspace)
                                    break
                                end
                                wait()
                            end
                            C:remove()
                        end
                    )
                )
                while mousedown == true do
                    if B.Target ~= nil then
                        local D = B.Target
                        if D.Anchored == false then
                            object = D
                            dist = (object.Position - front.Position).magnitude
                            break
                        end
                    end
                    wait()
                end
                while mousedown == true do
                    if object.Parent == nil then
                        break
                    end
                    local t = CFrame.new(front.Position, B.Hit.p)
                    BP.Parent = object
                    BP.position = front.Position + t.lookVector * dist
                    wait()
                end
                BP:remove()
                object = nil
                objval.Value = nil
            end
            function onKeyDown(E, B)
                local E = E:lower()
                local F = false
                if E == "q" then
                    if dist >= 5 then
                        dist = dist - 10
                    end
                end
                if E == "r" then
                    if object == nil then
                        return
                    end
                    for G, H in pairs(object:children()) do
                        if H.className == "BodyGyro" then
                            return nil
                        end
                    end
                    BG = Instance.new("BodyGyro")
                    BG.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    BG.cframe = CFrame.new(object.CFrame.p)
                    BG.Parent = object
                    repeat
                        wait()
                    until object.CFrame == CFrame.new(object.CFrame.p)
                    BG.Parent = nil
                    if object == nil then
                        return
                    end
                    for G, H in pairs(object:children()) do
                        if H.className == "BodyGyro" then
                            H.Parent = nil
                        end
                    end
                    object.Velocity = Vector3.new(0, 0, 0)
                    object.RotVelocity = Vector3.new(0, 0, 0)
                    object.Orientation = Vector3.new(0, 0, 0)
                end
                if E == "e" then
                    dist = dist + 10
                end
                if E == "t" then
                    if dist ~= 10 then
                        dist = 10
                    end
                end
                if E == "y" then
                    if dist ~= 200 then
                        dist = 200
                    end
                end
                if E == "=" then
                    BP.P = BP.P * 1.5
                end
                if E == "-" then
                    BP.P = BP.P * 0.5
                end
            end
            function onEquipped(B)
                keymouse = B
                local I = tool.Parent
                human = I.Humanoid
                human.Changed:connect(
                    function()
                        if human.Health == 0 then
                            mousedown = false
                            BP:remove()
                            point:remove()
                            tool:remove()
                        end
                    end
                )
                B.Button1Down:connect(
                    function()
                        onButton1Down(B)
                    end
                )
                B.Button1Up:connect(
                    function()
                        mousedown = false
                    end
                )
                B.KeyDown:connect(
                    function(E)
                        onKeyDown(E, B)
                    end
                )
                B.Icon = "rbxasset://textures\\GunCursor.png"
            end
            tool.Equipped:connect(onEquipped)
        end
    )
)
for J, H in pairs(h:GetChildren()) do
    H.Parent = game:GetService("Players").LocalPlayer.Backpack
    pcall(
        function()
            H:MakeJoints()
        end
    )
end
h:Destroy()
for J, H in pairs(g) do
    spawn(
        function()
            pcall(H)
        end
    )
end
end)

Section:NewToggle("Go Rest", "Sit", function(state)

    if state then
        Sit = state
while Sit == true do

wait()

	local char = game.Players.LocalPlayer.Character.HumanoidRootPart
	char.CFrame = CFrame.new(-181, 226, -1069)
	wait(0.01)
	char.CFrame = CFrame.new(-181, 226, -1073)
	wait(0.01)	
	char.CFrame = CFrame.new(-235, 226, -1127)
	wait(0.01)	
	char.CFrame = CFrame.new(-239, 226, -1127)
	wait(0.01)	
	char.CFrame = CFrame.new(-293, 226, -1069)
	wait(0.01)	
	char.CFrame = CFrame.new(-1276, 219, -1362)
	wait(0.01)	
	char.CFrame = CFrame.new(-1293, 219, -1369)
	wait(0.01)	
	char.CFrame = CFrame.new(1983, 218, 601)
	wait(0.01)	
	char.CFrame = CFrame.new(1976, 218, 608)
	wait(0.01)	
	char.CFrame = CFrame.new(1941, 218, 586)
	wait(0.01)	
	char.CFrame = CFrame.new(1941, 218, 572)
	wait(0.01)	
	char.CFrame = CFrame.new(1495, 280, 2167)
	wait(0.01)	
	char.CFrame = CFrame.new(1492, 280, 2196)
	wait(0.01)	

	
wait()

end
    else

       Sit = state
while Sit == true do

 print('Repeat Stopped')
wait()

end
end
end)


Section:NewTextBox("Go to Player", "Go to Player", function(txt)
    
local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
local p2 = txt
local pos = p1.CFrame

p1.CFrame = game.Players[p2].Character.HumanoidRootPart.CFrame

end)

Section:NewTextBox("Go and Back", "Go to Player and back", function(txt)
    
local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
local p2 = txt
local pos = p1.CFrame

p1.CFrame = game.Players[p2].Character.HumanoidRootPart.CFrame

wait(1)

p1.CFrame = pos

end)


Section:NewButton("Create Part", "Part for stand", function()

		local CharacterName = game.Players.LocalPlayer.Character
		local position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-15)
        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-169, 640, -54)

	    local b1 = Instance.new("Part")
	    b1.Shape = "Block"
	    b1.Material = "Neon"
	    b1.BrickColor = BrickColor.new("Hot Pink")
        b1.Anchored = true
	    b1.Parent = game.Workspace
	    b1.CFrame = CFrame.new(-169, 630, -54)
        b1.Size = Vector3.new(5, 0.1, 5)
wait(5)
        b1:Destroy()
end)

Section:NewButton("Create Part Perment", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-169, 12050, -54)

	    local b1 = Instance.new("Part")
	    b1.Shape = "Block"
	    b1.Material = "Neon"
	    b1.BrickColor = BrickColor.new("White")
        b1.Anchored = true
	    b1.Parent = game.Workspace
	    b1.CFrame = CFrame.new(-169, 12000, -54)
        b1.Size = Vector3.new(25, 0.1, 25)

end)

Section:NewButton("Go Part Perment", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-169, 12050, -54)

end)

Section:NewButton("Create Afk Waypoint", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-20478, 220, -20477)

	    local b1 = Instance.new("Part")
	    b1.Shape = "Block"
	    b1.Material = "Grass"
	    b1.BrickColor = BrickColor.new("Green")
        b1.Anchored = true
	    b1.Parent = game.Workspace
	    b1.CFrame = CFrame.new(-20478, 208, -20477)
        b1.Size = Vector3.new(25, 0.1, 25)

	    local b2 = Instance.new("Part")
	    b2.Shape = "Block"
	    b2.Material = "Grass"
	    b2.BrickColor = BrickColor.new("Green")
        b2.Anchored = true
	    b2.Parent = game.Workspace
	    b2.CFrame = CFrame.new(-20481, 208, 20479)
        b2.Size = Vector3.new(25, 0.1, 25)

	    local b3 = Instance.new("Part")
	    b3.Shape = "Block"
	    b3.Material = "Grass"
	    b3.BrickColor = BrickColor.new("Green")
        b3.Anchored = true
	    b3.Parent = game.Workspace
	    b3.CFrame = CFrame.new(20478, 208, 20479)
        b3.Size = Vector3.new(25, 0.1, 25)

	    local b4 = Instance.new("Part")
	    b4.Shape = "Block"
	    b4.Material = "Grass"
	    b4.BrickColor = BrickColor.new("Green")
        b4.Anchored = true
	    b4.Parent = game.Workspace
	    b4.CFrame = CFrame.new(20488, 208, -20478)
        b4.Size = Vector3.new(25, 0.1, 25)

end)

Section:NewButton("Go Afk Waypoint 1", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-20478, 220, -20477)

end)

Section:NewButton("Go Afk Waypoint 2", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-20481, 220, 20479)

end)

Section:NewButton("Go Afk Waypoint 3", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(20478, 220, 20479)

end)

Section:NewButton("Go Afk Waypoint 4", "Part for stand", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(20488, 220, -20478)

end)


Section:NewToggle("Loop go 4 waypoints", "Repeat your location", function(state)

    if state then
TpWLoop = state
while TpWLoop == true do

	wait(0.1)
 
	local char = game.Players.LocalPlayer.Character.HumanoidRootPart
	char.CFrame = CFrame.new(-20478, 212, -20477)
	wait(0.1)
	char.CFrame = CFrame.new(-20481, 212, 20479)
	wait(0.1)
	char.CFrame = CFrame.new(20478, 212, 20479)
	wait(0.1)
	char.CFrame = CFrame.new(20488, 212, -20478)
	wait(0.1)

end
    else

TpWLoop = state
while TpWLoop == true do

 print('Stop')
wait()

end
end
end)

Section:NewToggle("Parts under foot", "Repeat part under foot", function(state)

    if state then
PartLoop = state
while PartLoop == true do

	wait()
 
	local char = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,-3.125,0)
	    local b101 = Instance.new("Part")
	    b101.Shape = "Block"
	    b101.Material = "Wood"
	    b101.BrickColor = BrickColor.new("Hot Pink")
        b101.Anchored = true
	    b101.Parent = game.Workspace
	    b101.CFrame = char
        b101.Size = Vector3.new(10, 1, 10)
wait()
        b101:Destroy()

end
    else

PartLoop = state
while PartLoop == true do

 print('Stop')
wait()

end
end
end)


Section:NewButton("Create Somethings", "...", function()

	    local b31 = Instance.new("Part")
	    b31.Shape = "Block"
	    b31.Material = "Grass"
	    b31.BrickColor = BrickColor.new("Lime")
        b31.Anchored = true
	    b31.Parent = game.Workspace
	    b31.CFrame = CFrame.new(0, 208, 0)
        b31.Size = Vector3.new(200000, 7, 200000)

	    local b32 = Instance.new("Part")
	    b32.Shape = "Block"
	    b32.Material = "Grass"
	    b32.BrickColor = BrickColor.new("Lime")
        b32.Anchored = true
	    b32.Parent = game.Workspace
	    b32.CFrame = CFrame.new(1307, 208, 2190)
        b32.Size = Vector3.new(200000, 7, 200000)

	    local b33 = Instance.new("Part")
	    b33.Shape = "Block"
	    b33.Material = "Grass"
	    b33.BrickColor = BrickColor.new("Lime")
        b33.Anchored = true
	    b33.Parent = game.Workspace
	    b33.CFrame = CFrame.new(-2716, 208, -988)
        b33.Size = Vector3.new(200000, 7, 200000)

	    local b33 = Instance.new("Part")
	    b33.Shape = "Block"
	    b33.Material = "Grass"
	    b33.BrickColor = BrickColor.new("Lime")
        b33.Anchored = true
	    b33.Parent = game.Workspace
	    b33.CFrame = CFrame.new(-3355, 208, -3969)
        b33.Size = Vector3.new(200000, 7, 200000)

	    local b34 = Instance.new("Part")
	    b34.Shape = "Block"
	    b34.Material = "Grass"
	    b34.BrickColor = BrickColor.new("Lime")
        b34.Anchored = true
	    b34.Parent = game.Workspace
	    b34.CFrame = CFrame.new(1120, 208, -3250)
        b34.Size = Vector3.new(200000, 7, 200000)

	    local b35 = Instance.new("Part")
	    b35.Shape = "Block"
	    b35.Material = "Grass"
	    b35.BrickColor = BrickColor.new("Lime")
        b35.Anchored = true
	    b35.Parent = game.Workspace
	    b35.CFrame = CFrame.new(1425, 208, 912)
        b35.Size = Vector3.new(200000, 7, 200000)


	    local b36 = Instance.new("Part")
	    b36.Shape = "Block"
	    b36.Material = "Grass"
	    b36.BrickColor = BrickColor.new("Lime")
        b36.Anchored = true
	    b36.Parent = game.Workspace
	    b36.CFrame = CFrame.new(-3207, 208, -2451)
        b36.Size = Vector3.new(200000, 7, 200000)

	    local b37 = Instance.new("Part")
	    b37.Shape = "Block"
	    b37.Material = "Grass"
	    b37.BrickColor = BrickColor.new("Lime")
        b37.Anchored = true
	    b37.Parent = game.Workspace
	    b37.CFrame = CFrame.new(1798, 208, -604)
        b37.Size = Vector3.new(200000, 7, 200000)

	    local b38 = Instance.new("Part")
	    b38.Shape = "Block"
	    b38.Material = "Grass"
	    b38.BrickColor = BrickColor.new("Lime")
        b38.Anchored = true
	    b38.Parent = game.Workspace
	    b38.CFrame = CFrame.new(-1400, 208, 101)
        b38.Size = Vector3.new(200000, 7, 200000)

	    local b39 = Instance.new("Part")
	    b39.Shape = "Block"
	    b39.Material = "Grass"
	    b39.BrickColor = BrickColor.new("Lime")
        b39.Anchored = true
	    b39.Parent = game.Workspace
	    b39.CFrame = CFrame.new(-4864, 208, -6075)
        b39.Size = Vector3.new(200000, 7, 200000)

	    local b40 = Instance.new("Part")
	    b40.Shape = "Block"
	    b40.Material = "Grass"
	    b40.BrickColor = BrickColor.new("Lime")
        b40.Anchored = true
	    b40.Parent = game.Workspace
	    b40.CFrame = CFrame.new(-5283, 208, -7681)
        b40.Size = Vector3.new(200000, 7, 200000)

	    local b41 = Instance.new("Part")
	    b41.Shape = "Block"
	    b41.Material = "Grass"
	    b41.BrickColor = BrickColor.new("Lime")
        b41.Anchored = true
	    b41.Parent = game.Workspace
	    b41.CFrame = CFrame.new(-1284, 208, -1675)
        b41.Size = Vector3.new(200000, 7, 200000)

end)

Section:NewToggle("Random Teleport", "Repeat your location", function(state)

    if state then
LoopTp = state
while LoopTp == true do
	wait()
	
	local char = game.Players.LocalPlayer.Character.HumanoidRootPart
	local position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-15)
	local randompos = position*CFrame.new(math.random(-50,50),0,math.random(-50,50))
	local p2 = randompos
 
    char.CFrame = p2

wait()

end
    else

        TpLoop = state
LoopTp = state
while LoopTp == true do

 print('Stop')
wait()

end
end
end)

local Tab = Window:NewTab("Islands")
local Section = Tab:NewSection("Islands")

Section:NewButton("Cave Island", "Go Cave", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-127, 224, -979)

end)

Section:NewButton("Crab Island", "Go Crab Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-7, 232, -94)

end)

Section:NewButton("Mini Sand Island Near Fishing Island", "Go Sand Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-1223, 231, 616)

end)

Section:NewButton("Fishing Island", "Go Fishing Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-1672, 221, -300)

end)

Section:NewButton("Sam Island", "Go Sam Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-1281, 221, -1270)

end)


Section:NewButton("Orange House", "Go Orange House", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(717, 248, 1209)

end)


Section:NewButton("Bar", "Go Bar", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(1523, 284, 2137)

end)

Section:NewButton("House", "Go House", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(1163, 223, 3340)

end)

Section:NewButton("Pyramid", "Go Pyramid", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(117, 279, 4944)

end)

Section:NewButton("Snow Island", "Go Snow Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-2047, 258, 3390)

end)

Section:NewButton("Racing Island", "Go Racing Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-5100, 228, 2466)

end)

Section:NewButton("Forest Island", "Go Forest Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-6026, 405, -7)

end)


Section:NewButton("1 Tree Island", "Go Super Mini Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-4005, 219, -2191)

end)


Section:NewButton("Marine Island", "Go Marine Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-3135, 365, -4036)

end)


Section:NewButton("Purple Island", "Go Purple Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-5161, 530, -7794)

end)


Section:NewButton("Sand Castle", "Go Sand Castle", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(1081, 251, -3337)

end)



Section:NewButton("Empty Island 1", "Go Empty Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(156, 229, -2276)

end)



Section:NewButton("Empty Island 2", "Go Empty Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(2163, 226, -1945)

end)


Section:NewButton("Small Island", "Go Small Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(767, 221, -1374)

end)


Section:NewButton("Rock Island", "Go Rock Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(2054, 499, -601)

end)

Section:NewButton("Mansion Island", "Go Mansion Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(1851, 244, 851)

end)

Section:NewButton("Red Tree Island", "Go Red Tree Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(1180, 220, -278)

end)

Section:NewButton("Mini Rock Island", "Go Mini Rock Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-33, 236, 2152)

end)

Section:NewButton("Krizma Island", "Go Krizma Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-1118, 367, 1709)

end)

Section:NewButton("Trash Island", "Go Trash Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-2639, 260, 1103)

end)

Section:NewButton("Moon Island", "Go Moon Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(3198, 366, 1643)

end)

Section:NewButton("Vokun Island", "Go Vokun Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(4865, 543, 5144)

end)


Section:NewButton("Big Snow Island", "Go Big Snow Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(6913, 505, -1146)

end)


Section:NewButton("Boss Seacactus Island", "Go Big Snow Island", function()

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(-1542, 268, 10163)

end)


local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("Other")

Section:NewTextBox("Jump Power", "Jump Cheat", function(txt)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = (txt)
end)

Section:NewTextBox("Hip Height", "Jump Cheat", function(txt)
	game.Players.LocalPlayer.Character.Humanoid.HipHeight = (txt)
end)


Section:NewButton("Rejoin", "Rejoin Server", function()

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Rejoin = coroutine.create(function()
    local Success, ErrorMessage = pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)

    if ErrorMessage and not Success then
        warn(ErrorMessage)
    end
end)

coroutine.resume(Rejoin)  

end)

Section:NewButton("Hop Server", "Hop to low server", function()

    wait ()
local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/3237168/servers/Public?sortOrder=Asc&limit=100"))
for i,v in pairs(Servers.data) do
  if v.playing ~= v.maxPlayers then
      game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
  end
end
end)

Section:NewButton("Alt Del", "Delete!!!!", function()
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

Mouse.Button1Down:connect(function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
if not Mouse.Target then return end
Mouse.Target:Destroy()
end)
end)

Section:NewKeybind(" ", " ", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)

local Tab = Window:NewTab("Compass & Package")
local Section = Tab:NewSection("Compass")

Section:NewButton("Open Sam", "Open Sam", function()

fireclickdetector(game:GetService("Workspace").Merchants.QuestMerchant.Clickable.ClickDetector)

end)

Section:NewButton("equip to go compass", "go to compass", function()

local CharacterName = game.Players.LocalPlayer.Character
local a = CharacterName.Compass.Poser.Value

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(a)

end)

Section:NewButton("Go to compass", "go to compass", function()

local CharacterName = game.Players.LocalPlayer.Character
local pl2 = game:GetService("Players").LocalPlayer
local pl3 = pl2.Backpack.Compass.Poser.Value
local ply = game.Players.LocalPlayer.Character.HumanoidRootPart

ply.CFrame = CFrame.new(pl3)

end)

Section:NewToggle("Auto Find Compass", "go to compass", function(state)

    if state then
Compass = state
while Compass == true do
    
	wait(0.5)
	
local CharacterName = game.Players.LocalPlayer.Character
local pl2 = game:GetService("Players").LocalPlayer
local pl3 = pl2.Backpack.Compass.Poser.Value
local ply = game.Players.LocalPlayer.Character.HumanoidRootPart

ply.CFrame = CFrame.new(pl3)

end
    else

Compass = state
while Compass == true do

 print('Stop')
wait()

end
end
end)


Section:NewButton("Go Safe", "if u get rare or ultra rare", function()


    local char = game.Players.LocalPlayer.Character.HumanoidRootPart
     char.CFrame = CFrame.new(0,10000,0)

	    local b123 = Instance.new("Part")
	    b123.Shape = "Block"
	    b123.Material = "Neon"
	    b123.BrickColor = BrickColor.new("White")
        b123.Anchored = true
	    b123.Parent = game.Workspace
	    b123.CFrame = CFrame.new(0, 9979, 0)
        b123.Size = Vector3.new(25, 5, 25)
        
wait(1)

b123:Destroy()

    local char = game.Players.LocalPlayer.Character.HumanoidRootPart
     char.CFrame = CFrame.new(90, 266, -37)

end)

local Section = Tab:NewSection("Package")
Section:NewToggle("Auto Get Package", "get Package", function(state)

    if state then
Pack = state
while Pack == true do
    
	wait()

workspace.Merchants.QuestFishMerchant.Clickable.Retum:FireServer()


local CharacterName = game.Players.LocalPlayer.Character
local a = CharacterName.Package.Poser.Value

        local char = game.Players.LocalPlayer.Character.HumanoidRootPart
        char.CFrame = CFrame.new(a)

end
    else

Pack = state
while Pack == true do

 print('Stop')
wait()

end
end
end)


local Tab = Window:NewTab("Brings")
local Section = Tab:NewSection("Bring All Players")
Section:NewToggle("Players Bring", "loop bring players", function(state)

    if state then
PB = state
getgenv().loopbring = PB
while wait() and getgenv().loopbring do
for i,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil then
if v.Character:FindFirstChild("Humanoid") then
v.Character:FindFirstChildOfClass('Humanoid').Sit = false
end
wait()
if v.Name ~= game.Players.LocalPlayer.Name then
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,5)

end
end
end
end
    else

PB = state
getgenv().loopbring = PB

 print('Stop')
wait()

end
end)

Section:NewButton("Hitbox", "zoom players size", function()

local egg = 10

    
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
    
v.Character.HumanoidRootPart.Size = Vector3.new(egg, egg, egg)
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Cyan")
v.Character.HumanoidRootPart.Transparency = 0.4


end
end
end)

Section:NewToggle("Rainbow Hitbox", "Rainbow Hitbox", function(state)

    if state then
        RH = state
while RH == true do

wait()

for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then


v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Steel blue")
wait(0.01)
	 
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Bright violet")
wait(0.01)
	 
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Magenta")
wait(0.01)
	 
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Neon orange")
wait(0.01)
	 
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Bright yellow")
wait(0.01)
	 
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Lime green")
wait(0.01)

v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Toothpaste")
wait(0.01)

break;
end
end
end
    else

       RH = state
while RH == true do

 print('Repeat Stopped')
wait()

end
end
end)

Section:NewToggle("Falling", "For magma", function(state)

    if state then
        Uk = state
while Uk == true do

wait()

local char = game.Players.LocalPlayer.Character.HumanoidRootPart

char.CFrame = CFrame.new(0,1000000,0)

wait(0.5)

char.CFrame = CFrame.new(10000,100000,-10000)

wait(0.5)

char.CFrame = CFrame.new(20000,100000,-20000)

wait(0.5)

char.CFrame = CFrame.new(30000,100000,-30000)

end
    else

    Uk = state
while Uk == true do

 print('Repeat Stopped')
wait()

end
end
end)


local Section = Tab:NewSection("Brings")

Section:NewToggle("Auto Bring Fruit", "Bring Fruit", function(state)

    if state then
        Fbring = state
while Fbring == true do

wait()

local placeF = game:GetService("Workspace").Trees
for i, v in pairs(placeF:GetDescendants()) do
if v.Name == "ClickDetector" then

fireclickdetector(v)

end
end
end
    else

    Fbring = state
while Fbring == true do

 print('Repeat Stopped')

end
end
end)

Section:NewButton("Bring Fruit", "Bring Fruits", function()

local placeF = game:GetService("Workspace").Trees
for i, v in pairs(placeF:GetDescendants()) do
if v.Name == "ClickDetector" then

fireclickdetector(v)

end
end
end)

Section:NewButton("Delete Unknow Brings", "Delete Unknow Brings", function()

local ciderf = Workspace.IslandPirate.Cider.Handle
local juice = Workspace.IslandPirate.Juice.Handle
local lemonade = Workspace.IslandPirate.Lemonade.Handle
local smoothie = Workspace.IslandPirate.Smoothie.Handle

ciderf:Destroy()
juice:Destroy()
lemonade:Destroy()
smoothie:Destroy()

end)

Section:NewButton("Bring All", "Brings all fruit around the map", function()

local CharacterName = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local wrk = game.workspace

for  i, v in pairs(wrk:GetDescendants()) do
if v.Name == "Handle" then
    
    v.CFrame = CharacterName
    

end
end
end)


local Section = Tab:NewSection("All Barrels")
Section:NewToggle("Click All Barrels", "get items in barrels", function(state)

    if state then
bb = state
while bb == true do
    
wait()

local a = Workspace.Barrels.Barrels

for i, v in pairs(a:GetDescendants()) do
if v.Name == "ClickDetector" then

fireclickdetector(v)


end
end
end
    else

bb = state
while bb == true do

 print('Stop')
wait()

end
end
end)

local Section = Tab:NewSection("Everything")
Section:NewButton("Click All", "Brings all", function()


local CharacterName = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local a = Workspace

for i, v in pairs(a:GetDescendants()) do
if v.Name == "ClickDetector" then

fireclickdetector(v)

end
end
end)

Section:NewButton("Touch All", "Touch all", function()

for i,v in next, workspace:GetDescendants() do
	    if v:IsA'TouchTransmitter' then
	        table.insert(Tab,v)
	    end
	end
	local plr=game:GetService'Players'.LocalPlayer
	spawn(function()

	            for i,v in next,Tab do
	                if v:IsA'TouchTransmitter' then
	                    if firetouchinterest then
	                        firetouchinterest(plr.Character.HumanoidRootPart,v.Parent,0)
	                        wait()
	                        firetouchinterest(plr.Character.HumanoidRootPart,v.Parent,1)
	                    end
	                end
	        end
	end)
end)


Section:NewButton("Compass All Error", "Compass all", function()

local Part = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
local OtherPart = workspace.Compass.Handle
local Touching = 0
firetouchinterest(Part, OtherPart, Touching)

end)

local Tab = Window:NewTab("Check")
local Section = Tab:NewSection("Press F9 to view")
local Section = Tab:NewSection("Compass And Boxs")

Section:NewToggle("Check Compass And Boxs", "Checking...", function(state)
    if state then
        CheckC = state
while CheckC == true do

wait(0.7)


for i, player in pairs(game.Players:GetChildren()) do 
	    for i, backpack in pairs(player:GetChildren()) do
	        if backpack.Name == "Backpack" then 
	            for i, v in pairs(backpack:GetChildren()) do
	                if v.Name == ("Compass") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Common Box") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Uncommon Box") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Rare Box") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Ultra Rare Box") then
	                print("================================================================================")
	                print(player, v)

wait()

end
end
end
end
end
end
    else

       CheckC = state
while CheckC == true do

 print('Repeat Stopped')
wait()

end
end
end)

local Section = Tab:NewSection("Fruits Only Rare And Ultra")

Section:NewToggle("Check Fruits", "This only check Rare and Ultra Rare", function(state)
    if state then
        CheckF = state
while CheckF == true do

wait(0.1)


for i, player in pairs(game.Players:GetChildren()) do 
	    for i, backpack in pairs(player:GetChildren()) do
	        if backpack.Name == "Backpack" then 
	            for i, v in pairs(backpack:GetChildren()) do
	                if v.Name == ("Gravity Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Ope Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Venom Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Candy Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Hollow Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Chilly Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Gas Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Flare Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Light Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Smoke Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Sand Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Rumble Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Magma Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Snow Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Quake Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Phoenix Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Dark Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Vampire Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
end	                
end
end
end
end
wait(1)
    else

       CheckF = state
while CheckF == true do

 print('Repeat Stopped')
wait()

end
end
end)

local Section = Tab:NewSection("Fruits Only Common And Uncommon")

Section:NewToggle("Check Fruits", "This only check Common and Uncommon", function(state)
    if state then
        CheckrF = state
while CheckrF == true do

wait(0.1)


for i, player in pairs(game.Players:GetChildren()) do 
	    for i, backpack in pairs(player:GetChildren()) do
	        if backpack.Name == "Backpack" then 
	            for i, v in pairs(backpack:GetChildren()) do
	                if v.Name == ("Order Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Gum Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Love Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Bomb Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Smelt Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Diamond Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Barrier Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("String Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Hobby Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Slip Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Chop Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Clone Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Hot Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Clear Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Float Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Spring Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Swim Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
	               if v.Name == ("Spin Fruit") then
	                print("================================================================================")
	                print(player, v)
	               end
	               if v.Name == ("Luck Fruit") then
	                print("================================================================================")
	                print(player, v)
	               end
	               if v.Name == ("More Fruit") then
	                print("================================================================================")
	                print(player, v)
	               end
	               if v.Name == ("Return Fruit") then
	                print("================================================================================")
	                print(player, v)
	               end
	               if v.Name == ("Alice Fruit") then
	                print("================================================================================")
	                print(player, v)
	                end
end	                
end
end
end
end
wait(1)
    else

       CheckrF = state
while CheckrF == true do

 print('Repeat Stopped')
wait()

end
end
end)

local Section = Tab:NewSection("Check Players Devil Fruits Ate")
Section:NewTextBox("Check Players", "Check Devil Using", function(txt)

local CharacterName = game.Players.LocalPlayer.Character
local tarname1 = game:GetService("Workspace")[(txt)]
local tarname2 = game:GetService("Workspace")[(txt)]
local plyn = tarname1
local ues = ("using")
local df1 = tarname1.DevilFruit.Value
local df2 = tarname2.DevilFruit2.Value

print(plyn , ues , df1)
print(plyn , ues , df2)

end)

------
-- Cria a seção "God Eyes" --
local Section = Tab:NewSection("God Eyes")

-- Função para aplicar a visibilidade nos humanoides
local function applyVisibility()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("Humanoid") and v.Parent:FindFirstChild("Head") then
            v.NameDisplayDistance = 1e8 -- Define a distância máxima para exibir o nome
            v.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None -- Sempre visível, mesmo atrás de objetos
        end
    end
end

-- Botão para ativar a visão ilimitada de nomes
Section:NewButton("Unlimid Username Distance", "All Seeing Eye", function()
    -- Certifica-se de que o jogador e o personagem estão prontos
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    -- Aplica visibilidade inicial
    applyVisibility()

    -- Conecta um evento para aplicar a visibilidade sempre que um novo humanoide for adicionado
    game.Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Wait()
        applyVisibility()
    end)

    -- Aplicar visibilidade em humanoides que aparecerem depois
    game.Workspace.ChildAdded:Connect(function(child)
        if child:IsA("Model") and child:FindFirstChild("Humanoid") then
            applyVisibility()
        end
    end)
end)

------
local Section = Tab:NewSection("Jesus Mode")

-- Variável para armazenar o estado do Jesus Mode
local jesusModeEnabled = false

-- Botão para ativar o Jesus Mode
Section:NewButton("Toggle Jesus Mode", "Walk on Water Without Taking Damage", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    jesusModeEnabled = not jesusModeEnabled -- Alterna o estado

    if jesusModeEnabled then
        -- Ativa o Jesus Mode
        character.HumanoidRootPart.Anchored = true -- Impede que o personagem caia na água
        humanoid.PlatformStand = true -- Impede que o personagem se mova para baixo
        print("Jesus Mode Activated")
    else
        -- Desativa o Jesus Mode
        character.HumanoidRootPart.Anchored = false -- Permite que o personagem caia normalmente
        humanoid.PlatformStand = false -- Permite que o personagem se mova normalmente
        print("Jesus Mode Deactivated")
    end
end)

------
local Section = Tab:NewSection("Infinite Yield")
Section:NewButton("Run Infinite Yield", "???", function()
    
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

end)

local Tab = Window:NewTab("Events")
local Section = Tab:NewSection("Halloween")

Section:NewButton("Go to Pumpkkin", "???", function()
 local pumpkin = game:GetService("Workspace").WorldEvent.Halloween.Pumpkin
 local player = game.Players.LocalPlayer.Character.HumanoidRootPart
 
 player.CFrame = pumpkin.CFrame
 
end)

Section:NewButton("Click Pumpkin", "???", function()


local CharacterName = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local a = game:GetService("Workspace").WorldEvent.Halloween.Pumpkin

for i, v in pairs(a:GetDescendants()) do
if v.Name == "ClickDetector" then

fireclickdetector(v)

end
end
end)

Section:NewToggle("Auto Click Pumpkins", "???", function(state)

    if state then
BringAZom = state
while BringAZom == true do

wait(1)
local CharacterName = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local a = game:GetService("Workspace").WorldEvent.Halloween.Pumpkin

for i, v in pairs(a:GetDescendants()) do
if v.Name == "ClickDetector" then

fireclickdetector(v)

break;
end
end
end
  else

        BringAZom = state
while BringAZom == true do

 print('Repeat Stopped')
wait()

end
end
end)

Section:NewToggle("Bring Zombies", "???", function(state)

    if state then
BringZom = state
while BringZom == true do

wait()
	local CharacterName = game.Players.LocalPlayer.Character
	local position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-10)
    local zomine = game:GetService("Workspace").WorldEvent.Halloween.Zombies


for i, v in pairs(zomine:GetDescendants()) do
if v.Name == "Zombie" then
    
    v.HumanoidRootPart.CFrame = position



end
end
end
  else

        BringZom = state
while BringZom == true do

 print('Repeat Stopped')
wait()

end
end
end)

Section:NewToggle("Hitbox Zombies", "???", function(state)

    if state then
BringHZom = state
while BringHZom == true do

wait()
	local CharacterName = game.Players.LocalPlayer.Character
	local position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-5)
    local zomine = game:GetService("Workspace").WorldEvent.Halloween.Zombies
local egg = 10

for i, v in pairs(zomine:GetDescendants()) do
if v.Name == "Zombie" then
    
    v.HumanoidRootPart.Transparency = 0.5
    v.HumanoidRootPart.Size = Vector3.new(egg, egg, egg)


end
end
end
  else

        BringHZom = state
while BringHZom == true do

 print('Repeat Stopped')
wait()

end
end
end)


Section:NewButton("Anchored U Self", "???", function()
local Player = game.Players.LocalPlayer.Character

Player.Torso.Anchored = true
 
end)

Section:NewButton("UnAnchored U Self", "???", function()
local Player = game.Players.LocalPlayer.Character

Player.Torso.Anchored = false
 
end)

Section:NewButton("Sit Under Sea", "???", function()
local Player = game.Players.LocalPlayer.Character


Player.HumanoidRootPart.CFrame = CFrame.new(-331, -490, -565)
wait()
Player.Humanoid.Sit = true
Player.Torso.Anchored = true

end)

-- Cria a aba "Affinity" e a seção "Auto Affy"
local Tab = Window:NewTab("Affinity")
local Section = Tab:NewSection("Auto Affy")

-- Variável para controle do estado do Auto Affy
local autoAffyActive = false
local sliderValue = 1.0 -- Valor inicial do slider

-- Adiciona o slider de Auto Affy na seção
Section:NewSlider("Auto Affy", "Adjust Affinity Level", 10, 20, function(value)
    sliderValue = value / 10  -- Converte o valor do slider para a escala de 1.0 a 2.0
    print("Slider value:", sliderValue)
end)

-- Função para atualizar afinidade
local function updateAffinity()
    local player = game.Players.LocalPlayer
    if player then
        local playerId = player.UserId
        local userData = game.Workspace.UserData["User_" .. playerId]

        if userData and userData.Data then
            -- DFT1 Variables
            local AffMelee1 = userData.Data.DFT1Melee.Value
            local AffSniper1 = userData.Data.DFT1Sniper.Value
            local AffDefense1 = userData.Data.DFT1Defense.Value
            local AffSword1 = userData.Data.DFT1Sword.Value

            -- DFT2 Variables
            local AffMelee2 = userData.Data.DFT2Melee.Value
            local AffSniper2 = userData.Data.DFT2Sniper.Value
            local AffDefense2 = userData.Data.DFT2Defense.Value
            local AffSword2 = userData.Data.DFT2Sword.Value

            -- Check for DFT1
            if AffSniper1 >= sliderValue and AffSword1 >= sliderValue and AffMelee1 >= sliderValue and AffDefense1 >= sliderValue then
                script.Parent:Destroy()
            end

            -- Check for DFT2
            if AffSniper2 >= sliderValue and AffSword2 >= sliderValue and AffMelee2 >= sliderValue and AffDefense2 >= sliderValue then
                script.Parent:Destroy()
            end

            local args1 = {
                [1] = "DFT1",
                [2] = (AffDefense1 >= sliderValue) and 0/0 or false,
                [3] = (AffMelee1 >= sliderValue) and 0/0 or false,
                [4] = (AffSniper1 >= sliderValue) and 0/0 or false,
                [5] = (AffSword1 >= sliderValue) and 0/0 or false,
                [6] = "Gems"
            }

            local args2 = {
                [1] = "DFT2",
                [2] = (AffDefense2 >= sliderValue) and 0/0 or false,
                [3] = (AffMelee2 >= sliderValue) and 0/0 or false,
                [4] = (AffSniper2 >= sliderValue) and 0/0 or false,
                [5] = (AffSword2 >= sliderValue) and 0/0 or false,
                [6] = "Gems"
            }

            workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args1))
            workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args2))
        end
    end
end

-- Botão para ativar/desativar o Auto Affy
Section:NewToggle("Toggle Auto Affy", "Activate or deactivate auto affinity adjustment", function(state)
    autoAffyActive = state
    if autoAffyActive then
        while autoAffyActive do
            updateAffinity()
            wait(8) -- Espera 8 segundos entre as atualizações
        end
    end
end)

-- Botão FastRoll que executa o updateAffinity 5 vezes
Section:NewButton("FastRoll", "Executes the affinity update 5 times based on slider value", function()
    for i = 1, 5 do
        updateAffinity()
        wait(2) -- Espera 2 segundos entre cada execução
    end
end)

-- Cria a aba "Farm Kill" e a seção correspondente
local Tab = Window:NewTab("Farm Kill")
local Section = Tab:NewSection("Player and NPC Farm")

-- Função para matar jogadores
Section:NewButton("Kill Player", "Kills all players", function()
    local LP = game.Players.LocalPlayer
    local RunService = game:GetService("RunService")

    -- Equipar a ferramenta "Cannon Ball" se estiver no Backpack
    RunService.Heartbeat:Connect(function()
        if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
            LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
        end
    end)

    -- Ataca todos os jogadores no workspace
    RunService.Heartbeat:Connect(function()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Anchored = true
                v.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                if LP.Character:FindFirstChild("Cannon Ball") then
                    local args = { v.Character.HumanoidRootPart.CFrame }
                    LP.Character["Cannon Ball"].RemoteEvent:FireServer(unpack(args))
                    wait(1)
                end
            end
        end
    end)
end)

-- Função para matar NPCs
Section:NewButton("Kill NPC", "Kills all NPCs", function()
    local LP = game.Players.LocalPlayer
    local RunService = game:GetService("RunService")

    -- Equipar a ferramenta "Cannon Ball" se estiver no Backpack
    RunService.Heartbeat:Connect(function()
        if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
            LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
        end
    end)

    -- Ataca todos os NPCs no workspace.Enemies
    RunService.Heartbeat:Connect(function()
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                v.HumanoidRootPart.Anchored = true
                v.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
                if LP.Character:FindFirstChild("Cannon Ball") then
                    local args = { v.HumanoidRootPart.CFrame }
                    LP.Character["Cannon Ball"].RemoteEvent:FireServer(unpack(args))
                end
            end
        end
    end)
end)
