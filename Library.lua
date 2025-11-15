local Converted = {
	["_getvalorxyznotification"] = Instance.new("ScreenGui"),
	["_Container"] = Instance.new("Frame"),
	["_Frame"] = Instance.new("Frame"),
	["_UICorner"] = Instance.new("UICorner"),
	["_Frame1"] = Instance.new("Frame"),
	["_UICorner1"] = Instance.new("UICorner"),
	["_Frame2"] = Instance.new("Frame"),
	["_UICorner2"] = Instance.new("UICorner"),
	["_title"] = Instance.new("TextLabel"),
	["_UIPadding"] = Instance.new("UIPadding"),
	["_bar1"] = Instance.new("Frame"),
	["_text"] = Instance.new("TextLabel"),
	["_UIPadding1"] = Instance.new("UIPadding"),
	["_UIStroke"] = Instance.new("UIStroke"),
	["_UIListLayout"] = Instance.new("UIListLayout")
}

Converted["_getvalorxyznotification"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["_getvalorxyznotification"].Name = "getvalorxyznotification"
Converted["_getvalorxyznotification"].Parent = game:GetService("CoreGui")

Converted["_Container"].BackgroundTransparency = 1
Converted["_Container"].Position = UDim2.new(0.4148, 0, 0.00694, 0)
Converted["_Container"].Size = UDim2.new(0.17, 0, 0.9, 0)
Converted["_Container"].Parent = Converted["_getvalorxyznotification"]

Converted["_UIListLayout"].Padding = UDim.new(0.01, 0)
Converted["_UIListLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout"].VerticalAlignment = Enum.VerticalAlignment.Bottom
Converted["_UIListLayout"].Parent = Converted["_Container"]

Converted["_Frame"].AnchorPoint = Vector2.new(0.5, 0.9)
Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["_Frame"].Position = UDim2.new(0.5, 0, 0.9, 0)
Converted["_Frame"].Size = UDim2.new(0, 300, 0, 75)
Converted["_Frame"].Visible = false
Converted["_Frame"].Parent = Converted["_Container"]

Converted["_UICorner"].Parent = Converted["_Frame"]

Converted["_Frame1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame1"].BackgroundColor3 = Color3.fromRGB(53, 74, 109)
Converted["_Frame1"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame1"].Size = UDim2.new(1, -2, 1, -2)
Converted["_Frame1"].Parent = Converted["_Frame"]

Converted["_UICorner1"].Parent = Converted["_Frame1"]

Converted["_Frame2"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame2"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["_Frame2"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame2"].Size = UDim2.new(1, -2, 1, -2)
Converted["_Frame2"].Parent = Converted["_Frame1"]

Converted["_UICorner2"].Parent = Converted["_Frame2"]

Converted["_title"].Name = "Title"
Converted["_title"].Font = Enum.Font.RobotoMono
Converted["_title"].Text = "notification title"
Converted["_title"].TextColor3 = Color3.fromRGB(195, 195, 195)
Converted["_title"].TextSize = 18
Converted["_title"].RichText = true
Converted["_title"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_title"].BackgroundTransparency = 1
Converted["_title"].AnchorPoint = Vector2.new(0, 0)
Converted["_title"].Position = UDim2.new(0, 8, 0.05, 0)
Converted["_title"].Size = UDim2.new(1, -16, 0.3, 0)
Converted["_title"].Parent = Converted["_Frame2"]

Converted["_UIPadding"].PaddingLeft = UDim.new(0, 0)
Converted["_UIPadding"].Parent = Converted["_title"]

Converted["_bar1"].AnchorPoint = Vector2.new(0.5, 0.35)
Converted["_bar1"].BackgroundColor3 = Color3.fromRGB(53, 74, 109)
Converted["_bar1"].BorderSizePixel = 0
Converted["_bar1"].Position = UDim2.new(0.5, 0, 0.38, 0)
Converted["_bar1"].Size = UDim2.new(1, -12, 0, 1)
Converted["_bar1"].Parent = Converted["_Frame2"]

Converted["_text"].Name = "Desc"
Converted["_text"].Font = Enum.Font.RobotoMono
Converted["_text"].Text = "you have enabled sniper db"
Converted["_text"].RichText = true
Converted["_text"].TextColor3 = Color3.fromRGB(195, 195, 195)
Converted["_text"].TextSize = 16
Converted["_text"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_text"].TextYAlignment = Enum.TextYAlignment.Top
Converted["_text"].BackgroundTransparency = 1
Converted["_text"].AnchorPoint = Vector2.new(0, 0)
Converted["_text"].Position = UDim2.new(0, 8, 0.45, 0)
Converted["_text"].Size = UDim2.new(1, -16, 0.5, -10)
Converted["_text"].TextWrapped = true
Converted["_text"].Parent = Converted["_Frame2"]

Converted["_UIPadding1"].PaddingLeft = UDim.new(0, 0)
Converted["_UIPadding1"].Parent = Converted["_text"]

Converted["_UIStroke"].Color = Color3.fromRGB(35, 35, 35)
Converted["_UIStroke"].Parent = Converted["_Frame"]

local TweenService = game:GetService("TweenService")

local function Notify(_, duration, title, description)
	task.spawn(function()
		duration = duration or 3
		local Clone = Converted["_Frame"]:Clone()
		Clone.Visible = true
		Clone.Parent = Converted["_Container"]

		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://6026984224"
		Sound.Volume = 0.4
		Sound.Parent = Clone
		Sound:Play()

		local Frame = Clone
		local Frame1 = Frame:FindFirstChildOfClass("Frame")
		local Frame2 = Frame1 and Frame1:FindFirstChildOfClass("Frame")
		local Title = Frame2 and Frame2:FindFirstChild("Title")
		local Text = Frame2 and Frame2:FindFirstChild("Desc")
		local Bar = Frame2 and Frame2:FindFirstChild("bar1")

		Title = Title or Frame:FindFirstChildWhichIsA("TextLabel")
		Text = Text or Frame:FindFirstChildWhichIsA("TextLabel", true)

		if Title and Text then
			Title.Text = title or "Notification"
			Text.Text = description or ""
		end

		Frame.Size = UDim2.new(0, 10, 0, 10)
		if Frame.BackgroundTransparency then Frame.BackgroundTransparency = 1 end
		if Frame1 and Frame1.BackgroundTransparency then Frame1.BackgroundTransparency = 1 end
		if Frame2 and Frame2.BackgroundTransparency then Frame2.BackgroundTransparency = 1 end
		if Bar and Bar.BackgroundTransparency then Bar.BackgroundTransparency = 1 end
		if Title and Title.TextTransparency then Title.TextTransparency = 1 end
		if Text and Text.TextTransparency then Text.TextTransparency = 1 end

		local grow = TweenService:Create(Frame, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(0, 340, 0, 90), BackgroundTransparency = 0 })
		local settle = TweenService:Create(Frame, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), { Size = UDim2.new(0, 300, 0, 75) })
		grow:Play()
		grow.Completed:Wait()
		settle:Play()

		if Frame1 then TweenService:Create(Frame1, TweenInfo.new(0.22), { BackgroundTransparency = 0 }):Play() end
		if Frame2 then TweenService:Create(Frame2, TweenInfo.new(0.22), { BackgroundTransparency = 0 }):Play() end
		if Title then TweenService:Create(Title, TweenInfo.new(0.22), { TextTransparency = 0 }):Play() end
		if Text then TweenService:Create(Text, TweenInfo.new(0.22), { TextTransparency = 0 }):Play() end
		if Bar then TweenService:Create(Bar, TweenInfo.new(0.22), { BackgroundTransparency = 0 }):Play() end

		task.wait(duration)

		local fadeFrame = TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
		if Frame1 then TweenService:Create(Frame1, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play() end
		if Frame2 then TweenService:Create(Frame2, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play() end
		if Bar then TweenService:Create(Bar, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play() end
		if Title then TweenService:Create(Title, TweenInfo.new(0.2), { TextTransparency = 1 }):Play() end
		if Text then TweenService:Create(Text, TweenInfo.new(0.2), { TextTransparency = 1 }):Play() end
		fadeFrame:Play()
		fadeFrame.Completed:Wait()
		Clone:Destroy()
	end)
end

return {
	Notify = Notify
}
