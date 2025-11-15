local Interlinked = {
    NotificationGui = Instance.new("ScreenGui"),
    Container = Instance.new("Frame"),
    Frame = Instance.new("Frame"),
    FrameCorner = Instance.new("UICorner"),
    InnerFrame = Instance.new("Frame"),
    InnerFrameCorner = Instance.new("UICorner"),
    ContentFrame = Instance.new("Frame"),
    ContentFrameCorner = Instance.new("UICorner"),
    Title = Instance.new("TextLabel"),
    TitlePadding = Instance.new("UIPadding"),
    Bar = Instance.new("Frame"),
    Description = Instance.new("TextLabel"),
    DescriptionPadding = Instance.new("UIPadding"),
    Stroke = Instance.new("UIStroke"),
    Layout = Instance.new("UIListLayout")
}

Interlinked.NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Interlinked.NotificationGui.Name = "InterlinkedNotification"
Interlinked.NotificationGui.Parent = game:GetService("CoreGui")

Interlinked.Container.BackgroundTransparency = 1
Interlinked.Container.Position = UDim2.new(0.4148, 0, 0.00694, 0)
Interlinked.Container.Size = UDim2.new(0.17, 0, 0.9, 0)
Interlinked.Container.Parent = Interlinked.NotificationGui

Interlinked.Layout.Padding = UDim.new(0.01, 0)
Interlinked.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Interlinked.Layout.SortOrder = Enum.SortOrder.LayoutOrder
Interlinked.Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
Interlinked.Layout.Parent = Interlinked.Container

Interlinked.Frame.AnchorPoint = Vector2.new(0.5, 0.9)
Interlinked.Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Interlinked.Frame.Position = UDim2.new(0.5, 0, 0.9, 0)
Interlinked.Frame.Size = UDim2.new(0, 300, 0, 75)
Interlinked.Frame.Visible = false
Interlinked.Frame.Parent = Interlinked.Container

Interlinked.FrameCorner.Parent = Interlinked.Frame

Interlinked.InnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Interlinked.InnerFrame.BackgroundColor3 = Color3.fromRGB(53, 74, 109)
Interlinked.InnerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
Interlinked.InnerFrame.Size = UDim2.new(1, -2, 1, -2)
Interlinked.InnerFrame.Parent = Interlinked.Frame

Interlinked.InnerFrameCorner.Parent = Interlinked.InnerFrame

Interlinked.ContentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Interlinked.ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Interlinked.ContentFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
Interlinked.ContentFrame.Size = UDim2.new(1, -2, 1, -2)
Interlinked.ContentFrame.Parent = Interlinked.InnerFrame

Interlinked.ContentFrameCorner.Parent = Interlinked.ContentFrame

Interlinked.Title.Name = "Title"
Interlinked.Title.Font = Enum.Font.RobotoMono
Interlinked.Title.Text = "Notification Title"
Interlinked.Title.TextColor3 = Color3.fromRGB(195, 195, 195)
Interlinked.Title.TextSize = 18
Interlinked.Title.RichText = true
Interlinked.Title.TextXAlignment = Enum.TextXAlignment.Left
Interlinked.Title.BackgroundTransparency = 1
Interlinked.Title.Position = UDim2.new(0, 8, 0.05, 0)
Interlinked.Title.Size = UDim2.new(1, -16, 0.3, 0)
Interlinked.Title.Parent = Interlinked.ContentFrame

Interlinked.TitlePadding.Parent = Interlinked.Title

Interlinked.Bar.AnchorPoint = Vector2.new(0.5, 0.35)
Interlinked.Bar.BackgroundColor3 = Color3.fromRGB(53, 74, 109)
Interlinked.Bar.BorderSizePixel = 0
Interlinked.Bar.Position = UDim2.new(0.5, 0, 0.38, 0)
Interlinked.Bar.Size = UDim2.new(1, -12, 0, 1)
Interlinked.Bar.Parent = Interlinked.ContentFrame

Interlinked.Description.Name = "Description"
Interlinked.Description.Font = Enum.Font.RobotoMono
Interlinked.Description.Text = "Notification Description"
Interlinked.Description.RichText = true
Interlinked.Description.TextColor3 = Color3.fromRGB(195, 195, 195)
Interlinked.Description.TextSize = 16
Interlinked.Description.TextXAlignment = Enum.TextXAlignment.Left
Interlinked.Description.TextYAlignment = Enum.TextYAlignment.Top
Interlinked.Description.BackgroundTransparency = 1
Interlinked.Description.Position = UDim2.new(0, 8, 0.45, 0)
Interlinked.Description.Size = UDim2.new(1, -16, 0.5, -10)
Interlinked.Description.TextWrapped = true
Interlinked.Description.Parent = Interlinked.ContentFrame

Interlinked.DescriptionPadding.Parent = Interlinked.Description

Interlinked.Stroke.Color = Color3.fromRGB(35, 35, 35)
Interlinked.Stroke.Parent = Interlinked.Frame

local TweenService = game:GetService("TweenService")

local function Notify(_, duration, title, description)
    task.spawn(function()
        duration = duration or 3

        local Clone = Interlinked.Frame:Clone()
        Clone.Visible = true
        Clone.Parent = Interlinked.Container

        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://6026984224"
        Sound.Volume = 0.4
        Sound.Parent = Clone
        Sound:Play()

        local Frame = Clone
        local Inner = Frame:FindFirstChildOfClass("Frame")
        local Content = Inner and Inner:FindFirstChildOfClass("Frame")
        local Title = Content and Content:FindFirstChild("Title")
        local Desc = Content and Content:FindFirstChild("Description")
        local Bar = Content and Content:FindFirstChild("Bar")

        Title.Text = title or "Notification"
        Desc.Text = description or ""

        Frame.Size = UDim2.new(0, 10, 0, 10)

        local grow = TweenService:Create(Frame, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 340, 0, 90)
        })

        local settle = TweenService:Create(Frame, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 300, 0, 75)
        })

        grow:Play()
        grow.Completed:Wait()
        settle:Play()

        task.wait(duration)

        local fade = TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })

        fade:Play()
        fade.Completed:Wait()
        Clone:Destroy()
    end)
end

return {
    Notify = Notify
}
