function Print(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
end

function PrintRed(msg)
	Print(msg, 1.0, 0.2, 0.2)
end

function PrintWhite(msg)
	Print(msg, 1.0, 1.0, 1.0)
end

SLASH_RDT1 = "/rdt"
SlashCmdList["RDT"] = function(msg)
	--local name = RangeDetector:GetName()
	--local height = RangeDetector:GetHeight()
	--local width = RangeDetector:GetWidth()
	--local point, relativeTo, relativePoint, xOfs, yOfs = RangeDetector:GetPoint()
	MenuFrame:Show()
end

SLASH_RELOAD1 = "/reload"
SlashCmdList["RELOAD"] = function (msg)
	ReloadUI();
end

eventEmitter = CreateFrame("Frame", "EventEmitter")
eventEmitter.Events = {TARGET_CHANGED = {}, TARGET_LOST ={}}
eventEmitter.HasTarget = false
function eventEmitter:AddSubscriber(event, sub, callback, arg)
	self.Events[event][sub] = {callback = callback, arg = arg}
end
function eventEmitter:EmitEvent(event)
	if eventEmitter.HasTarget then
		for _, subscriber in pairs(self.Events[event]) do
			subscriber.callback(subscriber.arg)
		end
	end
end
eventEmitter:SetScript("OnUpdate", 
	function()
		if UnitExists("playertarget") then
			eventEmitter:EmitEvent("TARGET_CHANGED")
			eventEmitter.HasTarget = true
		else
			eventEmitter:EmitEvent("TARGET_LOST")
			eventEmitter.HasTarget = false
		end
	end
)
