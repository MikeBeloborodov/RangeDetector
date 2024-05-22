hasAddonBeenLoaded = false

SLASH_RDT1 = "/rdt"
SlashCmdList["RDT"] = function(msg)
	MenuFrame:Show()
	RangeDetector:Show()
end

SLASH_RELOAD1 = "/reload"
SlashCmdList["RELOAD"] = function (msg)
	ReloadUI();
end

function RangeDetector_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("ADDON_LOADED")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
end

function RangeDetector_OnEvent()
	if event == "PLAYER_TARGET_CHANGED" then
		if UnitExists("target") and not UnitIsFriend("target", "player") and UnitHealth("target") ~= 0 then
			this:Show()
		else
			this:Hide()
		end
	end

	if event == "ADDON_LOADED" and not hasAddonBeenLoaded then
		if rdt_slot then
			this.slot = rdt_slot
		else
			this.slot = 0
			rdt_slot = 0
		end

		if rdt_x and rdt_y then
			this.ofsx = rdt_x
			this.ofsy = rdt_y
		else
			this.ofsx = 0
			this.ofsy = 0
			rdt_x = 0
			rdt_y = 0
		end

		if rdt_size then
			this.size = rdt_size
		else
			this.size = 30
			rdt_size = 30
		end

		this:ClearAllPoints()
		this:SetPoint("CENTER", UIParent, "CENTER", this.ofsx, this.ofxy)
		this:SetWidth(this.size)
		this:SetHeight(this.size)

		hasAddonBeenLoaded = true
	end
end

function RangeDetector_OnUpdate()
	if IsActionInRange(RangeDetector.slot) == 1 then
		RangeDetector_bg:SetTexture(0, 1, 0, 0.5);
	else
		RangeDetector_bg:SetTexture(1, 0, 0, 0.5);
	end
end

function RangeDetector_OnDragStop()
	this:StopMovingOrSizing()
			
	local point, relativeTo, relativePoint, xOfs, yOfs = this:GetPoint()
	rdt_x = xOfs
	rdt_y = yOfs
	this.ofsx = xOfs
	this.ofsy = yOfs
end

function MenuFrame_OnValueChanged()
	local newValue = this:GetValue()
	RangeDetector:SetWidth(newValue)
	RangeDetector:SetHeight(newValue)
	RangeDetector.size = tonumber(newValue)
	rdt_size = tonumber(newValue)
end

function MenuFrameButton_OnClose()
	MenuFrame:Hide();
	RangeDetector:Hide();
end