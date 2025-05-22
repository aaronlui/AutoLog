local frame = CreateFrame("Frame")
frame:RegisterEvent("CHALLENGE_MODE_START")
frame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
frame:RegisterEvent("CHALLENGE_MODE_RESET")

frame:SetScript("OnEvent", function(self, event)
    if event == "CHALLENGE_MODE_START" then
        LoggingCombat(true)
        print("|cFF00FF00AutoLog:|r 大秘境开始，已开启战斗记录")
    elseif event == "CHALLENGE_MODE_COMPLETED" or event == "CHALLENGE_MODE_RESET" then
        LoggingCombat(false)
        print("|cFF00FF00AutoLog:|r 大秘境结束，已关闭战斗记录")
    end
end)