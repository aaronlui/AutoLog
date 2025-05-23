-- 配置变量
local addonName = "AutoLog"
local isEnabled = true
local isLogging = false  -- 跟踪当前是否正在记录战斗日志

-- 创建框架
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHALLENGE_MODE_START")
frame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
frame:RegisterEvent("CHALLENGE_MODE_RESET")
frame:RegisterEvent("PLAYER_LOGIN")

-- 战斗记录控制函数
local function SetLogging(enable)
    if enable and not isLogging then
        LoggingCombat(true)
        isLogging = true
        print(string.format("|cFF00FF00%s:|r 已开启战斗记录", addonName))
    elseif not enable and isLogging then
        LoggingCombat(false)
        isLogging = false
        print(string.format("|cFF00FF00%s:|r 已关闭战斗记录", addonName))
    end
end

-- 斜杠命令处理函数
local function HandleSlashCommands(msg)
    if msg == "toggle" then
        isEnabled = not isEnabled
        print(string.format("|cFF00FF00%s:|r 自动记录功能已%s", addonName, isEnabled and "启用" or "禁用"))
        -- 如果禁用插件，确保关闭当前记录
        if not isEnabled and isLogging then
            SetLogging(false)
        end
    else
        print(string.format("|cFF00FF00%s:|r 命令用法：", addonName))
        print("  /alog toggle - 开启/关闭自动记录")
    end
end

-- 注册斜杠命令
SLASH_AUTOLOG1 = "/alog"
SlashCmdList["AUTOLOG"] = HandleSlashCommands

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        print(string.format("|cFF00FF00%s:|r 插件已加载。使用 /alog 查看命令。", addonName))
    elseif event == "CHALLENGE_MODE_START" then
        if isEnabled then
            SetLogging(true)
        end
    elseif event == "CHALLENGE_MODE_COMPLETED" or event == "CHALLENGE_MODE_RESET" then
        if isEnabled then
            SetLogging(false)
        end
    end
end)