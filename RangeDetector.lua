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
	local name = RangeDetector:GetName()
	local height = RangeDetector:GetHeight()
	local width = RangeDetector:GetWidth()
	local point, relativeTo, relativePoint, xOfs, yOfs = RangeDetector:GetPoint()
	PrintRed("name: " .. tostring(name))
	PrintRed("height: " .. tostring(height))
	PrintRed("width: " .. tostring(width))
	PrintRed("point: " .. tostring(point))
	PrintRed("relativeTo: " .. tostring(relativeTo))
	PrintRed("relativePoint: " .. tostring(relativePoint))
	PrintRed("xOfs: " .. tostring(xOfs))
	PrintRed("yOfs: " .. tostring(yOfs))

	if (msg) then
		RangeDetector:ClearAllPoints()
		RangeDetector:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
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
	for _, subscriber in pairs(self.Events[event]) do
		subscriber.callback(subscriber.arg)
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
