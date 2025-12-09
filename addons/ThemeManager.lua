local ThemeManager = {}
ThemeManager.Folder = "TestScriptHub"
ThemeManager.SaveFolder = "LinoriaLibSettings"
ThemeManager.BuiltInThemes = {
    ["Default"] = {
        0, {
            FontColor = "ffffff",
            MainColor = "141414",
            AccentColor = "5a4fff",
            BackgroundColor = "0f0f0f",
            OutlineColor = "262626",
            VideoLink = ""
        }
    },
}

local Http = game:GetService("HttpService")

local function readfile_safe(path)
    if isfile and isfile(path) then
        return readfile(path)
    end
end

local function writefile_safe(path, text)
    if writefile then
        writefile(path, text)
    end
end

local function applyVideo(link)
    if typeof(getgenv().ApplyBackgroundVideo) == "function" then
        getgenv().ApplyBackgroundVideo(link)
    end
end

function ThemeManager:SetLibrary(lib)
    self.Library = lib
end

function ThemeManager:SetFolder(folder)
    self.Folder = folder
end

function ThemeManager:CreateFolder()
    if not isfolder(self.SaveFolder) then
        makefolder(self.SaveFolder)
    end
    if not isfolder(self.SaveFolder .. "/" .. self.Folder) then
        makefolder(self.SaveFolder .. "/" .. self.Folder)
    end
end

function ThemeManager:GetThemeFile(name)
    return self.SaveFolder .. "/" .. self.Folder .. "/" .. name .. ".json"
end

function ThemeManager:SaveTheme(name)
    self:CreateFolder()

    local theme = {
        Info = { Version = 1 },
        Data = {}
    }

    for _, field in next, self:GetOptionNames() do
        local val = self.Library.Options[field].Value
        if field == "VideoLink" then
            theme.Data[field] = val
        else
            theme.Data[field] = string.format("%02x%02x%02x", val.R*255, val.G*255, val.B*255)
        end
    end

    writefile_safe(self:GetThemeFile(name), Http:JSONEncode(theme))
end

function ThemeManager:LoadTheme(name)
    local file = readfile_safe(self:GetThemeFile(name))
    if not file then return end

    local decoded = Http:JSONDecode(file)
    local data = decoded.Data

    for _, field in next, self:GetOptionNames() do
        if field == "VideoLink" then
            self.Library.Options[field]:SetValue(data[field] or "", true)
            applyVideo(data[field])
        else
            local hex = data[field] or "ffffff"
            self.Library.Options[field]:SetValueRGB(Color3.fromHex(hex), true)
        end
    end

    self:ApplyOptionColors()
end

function ThemeManager:SaveDefault(name)
    writefile_safe(self.SaveFolder .. "/" .. self.Folder .. "/default.txt", name)
end

function ThemeManager:LoadDefault()
    local path = self.SaveFolder .. "/" .. self.Folder .. "/default.txt"
    local file = readfile_safe(path)
    if file then
        self:LoadTheme(file)
        if self.Library.Options.ThemeManager_ThemeList then
            self.Library.Options.ThemeManager_ThemeList:SetValue(file, true)
        end
    end
end

function ThemeManager:GetOptionNames()
    return { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink" }
end

function ThemeManager:ApplyOptionColors()
    for _, field in next, self:GetOptionNames() do
        local v = self.Library.Options[field].Value
        self.Library[field] = v
    end
    self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor)
    self.Library:UpdateColorsUsingRegistry()
end

function ThemeManager:CreateThemeManager(group)
    local themeList = group:AddDropdown("ThemeManager_ThemeList", { Text = "Theme", Values = self:GetThemeList(), AllowNull = true })
    local btnLoad = group:AddButton("Load Theme", function()
        if themeList.Value then
            self:LoadTheme(themeList.Value)
        end
    end)

    local btnSave = group:AddButton("Save Theme", function()
        if themeList.Value then
            self:SaveTheme(themeList.Value)
        end
    end)

    group:AddButton("Save as Default", function()
        if themeList.Value then
            self:SaveDefault(themeList.Value)
        end
    end)

    group:AddButton("Refresh List", function()
        themeList.Values = self:GetThemeList()
        themeList:SetValues()
    end)

    for _, field in next, self:GetOptionNames() do
        self.Library.Options[field]:OnChanged(function()
            self:ApplyOptionColors()
        end)
    end

    self:LoadDefault()
end

function ThemeManager:GetThemeList()
    self:CreateFolder()

    local list = {}
    for _, v in next, listfiles(self.SaveFolder .. "/" .. self.Folder) do
        local name = v:match("([^/]+)%.json$")
        if name then
            table.insert(list, name)
        end
    end

    for themeName in next, self.BuiltInThemes do
        table.insert(list, themeName)
    end

    table.sort(list)
    return list
end

return ThemeManager
