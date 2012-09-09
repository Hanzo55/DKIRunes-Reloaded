--Readability == win

local RUNETYPE_BLOOD = 1;
local RUNETYPE_DEATH = 2;
local RUNETYPE_FROST = 3;
local RUNETYPE_CHROMATIC = 4;

local iconTextures = {};
iconTextures[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood-On.tga";
iconTextures[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death-On.tga";
iconTextures[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost-On.tga";
iconTextures[RUNETYPE_CHROMATIC] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-On.tga";

local runeTextures = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Blood-Off.tga",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Death-Off.tga",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost-Off.tga",
	[RUNETYPE_CHROMATIC] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-Off.tga",
}

local DKIRunes = {
	[RUNETYPE_BLOOD] = "Interface\\AddOns\\DKIRunes\\Blood_Runes",
	[RUNETYPE_FROST] = "Interface\\AddOns\\DKIRunes\\Frost_Runes",
	[RUNETYPE_DEATH] = "Interface\\AddOns\\DKIRunes\\Unholy_Runes",
	[RUNETYPE_CHROMATIC] = "Interface\\AddOns\\DKIRunes\\Death_Runes",
};

local DKIRuneLengths = {
	[RUNETYPE_BLOOD] = 69,
	[RUNETYPE_FROST] = 49,
	[RUNETYPE_DEATH] = 65,
	[RUNETYPE_CHROMATIC] = 67,
};

local runeOffset = {
	[1] = 60,
	[2] = 36,
	[5] = 12,
	[6] = -12,
	[3] = -36,
	[4] = -60,
}

local inCombat = 0;

-- Saved Variable
DKIRunes_Saved = {
	artStyle = 1;
	animate = true;
	cooldown = false;
	parent = "UIParent";
	point = "TOPLEFT";
	parentPoint = "TOPLEFT";
	x = -73;
	y = 25;
	scale = 0.8;
	rotate = 0;
	hero = false;
	heroSlide = 150;
	heroOrigin = 1;
	bar0 = 1;
	bar1 = 1;
	rpCounter = true;
	counterScale = 1;
	fade = false;
};

function LoadNewSavedVariables()
	if(DKIRunes_Saved.artStyle == nil) then
		DKIRunes_Saved.artStyle = 1;
	end
--	if(DKIRunes_Saved.animate == nil) then
--		DKIRunes_Saved.animate = true;
--	end
--	if(DKIRunes_Saved.cooldown == nil) then
--		DKIRunes_Saved.cooldown = false;
--	end
	if(DKIRunes_Saved.parent == nil) then
		DKIRunes_Saved.parent = "UIParent";
	end
	if(DKIRunes_Saved.point == nil) then
		DKIRunes_Saved.point = "TOPLEFT";
	end
	if(DKIRunes_Saved.parentPoint == nil) then
		DKIRunes_Saved.parentPoint = "TOPLEFT";
	end
	if(DKIRunes_Saved.x == nil) then
		DKIRunes_Saved.x = -73;
	end
	if(DKIRunes_Saved.y == nil) then
		DKIRunes_Saved.y = 25;
	end
	if(DKIRunes_Saved.scale == nil) then
		DKIRunes_Saved.scale = 0.8;
	end
	if(DKIRunes_Saved.rotate == nil) then
		DKIRunes_Saved.rotate = 0;
	end
--	if(DKIRunes_Saved.hero == nil) then
--		DKIRunes_Saved.hero = false;
--	end
	if(DKIRunes_Saved.heroSlide == nil) then
		DKIRunes_Saved.heroSlide = 150;
	end
	if(DKIRunes_Saved.heroOrigin == nil) then
		DKIRunes_Saved.heroOrigin = 1;
	end
	if(DKIRunes_Saved.bar0 == nil) then
		DKIRunes_Saved.bar0 = 1;
	end
	if(DKIRunes_Saved.bar1 == nil) then
		DKIRunes_Saved.bar1 = 1;
	end
--	if(DKIRunes_Saved.rpCounter == nil) then
--		DKIRunes_Saved.rpCounter = true;
--	end
	if(DKIRunes_Saved.counterScale == nil) then
		DKIRunes_Saved.counterScale = 1;
	end
--	if(DKIRunes_Saved.fade == nil) then
--		DKIRunes_Saved.fade = false;
--	end
end

function DKIRunes_OnLoad(self)
	
	RuneFrame:Hide();
	
	-- Disable rune frame if not a death knight.
	local _, class = UnitClass("player");
	
	
	if ( class ~= "DEATHKNIGHT" ) then
		self:Hide();
	end
	
	if ( GetCVarBool("predictedPower") and frequentUpdates ) then
		self:RegisterEvent("UNIT_RUNIC_POWER");
	end
	self:RegisterEvent("RUNE_POWER_UPDATE");
	self:RegisterEvent("RUNE_TYPE_UPDATE");
	self:RegisterEvent("RUNE_REGEN_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_ENTER_COMBAT");
	self:RegisterEvent("PLAYER_LEAVE_COMBAT");

	self:SetScript("OnEvent", DKIRunes_OnEvent);
	
	self.runes = {};

	DKIRunesFrame:SetMovable(false)
	DKIRunesFrame:EnableMouse(false)
	DKIRunesFrame:SetScript("OnMouseDown",function() DKIRunesFrame:StartMoving(); end)
	DKIRunesFrame:SetScript("OnMouseUp",function() DKIRunesFrame:StopMovingOrSizing() end)

end



function DKIRunes_OnEvent (self, event, ...)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		Rune1:SetFrameLevel(4);
		Rune2:SetFrameLevel(4);

		Rune3Rune:SetTexture(DKIRunes[RUNETYPE_DEATH]);
		Rune4Rune:SetTexture(DKIRunes[RUNETYPE_DEATH]);
		Rune3:SetFrameLevel(4);
		Rune4:SetFrameLevel(4);

		Rune5Rune:SetTexture(DKIRunes[RUNETYPE_FROST]);
		Rune6Rune:SetTexture(DKIRunes[RUNETYPE_FROST]);
		Rune5:SetFrameLevel(4);
		Rune6:SetFrameLevel(4);

		DKIRunesHorizontalBackdrop:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
		DKIRunesHorizontalBackdrop:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
		DKIRunesVerticalBackdrop:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
		DKIRunesVerticalBackdrop:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);

		DKIRunicPower:SetFontObject(CombatLogFont)
		DKIRunicPower:SetTextColor(0.0,1.0,1.0,1.0)
		DKIRunesRunicPower:Show();

	elseif ( event == "VARIABLES_LOADED" ) then
		LoadNewSavedVariables();
		DKIRunes_Rotate(false);
		RunicBar0_Set(DKIRunes_Saved.bar0)
		RunicBar1_Set(DKIRunes_Saved.bar1)
		DKIRunes_BarUpdate();
		DKIRunes_UpdateUI();
		DKIRunes_populateBlizzardOptions();
		DKIRunesFrame:SetAlpha(0.3);

	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		inCombat = 1;

	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		inCombat = 0;

	end
	
end

-- Update All
function DKIRunes_UpdateUI()
	DKIRunes_SetLocation();
	DKIRunes_UpdateArt();
end

-- Set Art
function DKIRunes_UpdateArt()
	DKIRunesFrame:SetScale(DKIRunes_Saved.scale);
	DKIRunesRunicPower:SetScale(DKIRunes_Saved.counterScale);
	DKIRunesEbonBlade:Hide();
	DKIRunesHorizontalBackdrop:Hide();
	DKIRunesVerticalBackdrop:Hide();

	if ( DKIRunes_Saved.artStyle == 1 ) then
		DKIRunesEbonBlade:Show();
		DKIRunesFrame:SetFrameLevel(0);
	elseif ( DKIRunes_Saved.artStyle == 2 ) then
		DKIRunesFrame:SetFrameLevel(2);
		if ( DKIRunes_Saved.rotate % 2 == 0 ) then
			DKIRunesHorizontalBackdrop:Show();
		else 
			DKIRunesVerticalBackdrop:Show();
		end
	else
		DKIRunesFrame:SetFrameLevel(2);
	end
end

function DKIRunes_BarUpdate()
	DKIRunicPower:Hide();
	DKIRunesFrame:SetAlpha(1.0);
	EbonBlade_Bar_0:Hide();
	EbonBlade_Bar_1:Hide();
	local runicPower = 181 * UnitMana("player") / UnitManaMax("player") ;
	local healthPoints = 181 * UnitHealth("player") / UnitHealthMax("player") ;
	local deathPoints = 181 * ( UnitHealthMax("player") - UnitHealth("player") ) / UnitHealthMax("player");

	if (DKIRunes_Saved.bar0 > 0) then
		local power0Value;
		if(DKIRunes_Saved.bar0 == 2) then
			power0Value = healthPoints;
		elseif(DKIRunes_Saved.bar0 == 3) then
			power0Value = deathPoints;
		else
			power0Value = runicPower;
		end
		if (DKIRunes_Saved.rotate % 2 == 1) then
			EbonBlade_Bar_0:SetHeight(power0Value);
		else
			EbonBlade_Bar_0:SetWidth(power0Value);
		end
		if(power0Value > 0) then
			EbonBlade_Bar_0:Show();
		end
	end

	if (DKIRunes_Saved.bar1 > 0) then
		local power1Value;
		if(DKIRunes_Saved.bar1 == 2) then
			power1Value = healthPoints;
		elseif(DKIRunes_Saved.bar1 == 3) then
			power1Value = deathPoints;
		else
			power1Value = runicPower;
		end
		if (DKIRunes_Saved.rotate % 2 == 1) then
			EbonBlade_Bar_1:SetHeight(power1Value);
		else
			EbonBlade_Bar_1:SetWidth(power1Value);
		end
		if(power1Value > 0) then
			EbonBlade_Bar_1:Show();
		end
	end

	if(DKIRunes_Saved.rpCounter and UnitMana("player") > 0) then
		DKIRunicPower:SetText(UnitMana("player"));
		DKIRunicPower:Show();
	end

	if(DKIRunes_Saved.fade and UnitMana("player") == 0 and inCombat == 0) then
		DKIRunesFrame:SetAlpha(0.3);
		EbonBlade_Bar_0:Hide();
		EbonBlade_Bar_1:Hide();
	end
end

function DKIRunes_SetLocation()
	DKIRunesFrame:ClearAllPoints()
	DKIRunesFrame:SetPoint(DKIRunes_Saved.point, DKIRunes_Saved.parent, DKIRunes_Saved.parentPoint, DKIRunes_Saved.x, DKIRunes_Saved.y);
end

function DKIRunes_OnUpdate(self, update)

	if(DKIRunesFrame:IsMouseEnabled()) then
		DKIRunes_Saved.point, relativeTo, DKIRunes_Saved.parentPoint, DKIRunes_Saved.x, DKIRunes_Saved.y = DKIRunesFrame:GetPoint();
	end

	for i=1, 6 do
		local runeType = GetRuneType(i);	
		local runeLength = DKIRuneLengths[runeType];
		local maxFrameX = math.fmod( runeLength, 8);
		local maxFrameY = math.floor( runeLength / 8 );
		DKIRunes_AnimateRune(i, runeLength, maxFrameX, maxFrameY);

		if ( getglobal("Rune"..i).flash and getglobal("Rune"..i).flash > 0 ) then
			DKIRunes_Rune_SetFrame(i, 0, 0);
			getglobal("Rune"..i).flash = getglobal("Rune"..i).flash - 1;

		end
	end

	DKIRunes_BarUpdate()

end

function DKIRunes_AnimateRune(rune, animationStart, maxFrameX, maxFrameY)
	local frameX, frameY = maxFrameX, maxFrameY;
	local start, duration, runeReady = GetRuneCooldown(rune);
	local percent = 1 - ((GetTime() - start)/duration);

	if ( runeReady or percent <= 0 ) then
		if ( getglobal("Rune"..rune).notReady ) then
			getglobal("Rune"..rune).flash = 2.0;
			getglobal("Rune"..rune).notReady = nil;
		end
		if (DKIRunes_Saved.hero) then
			if (DKIRunes_Saved.rotate % 2 == 1) then
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[rune] ) 
			else
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[rune], 0 ) 
			end
		end
	else
		
		local heroValue = percent * DKIRunes_Saved.heroSlide * DKIRunes_Saved.heroOrigin;

		getglobal("Rune"..rune).notReady = true;

		local rawFrame = animationStart;
		if (DKIRunes_Saved.animate) then
			rawFrame = math.floor( percent * animationStart);
			if ( rawFrame > animationStart ) then 
				rawFrame = animationStart;
			end
		else	
			rawFrame = animationStart - 2;
		end

		if(DKIRunes_Saved.cooldown) then
			local cooldown = getglobal("Rune"..rune.."Cooldown");
			local displayCooldown = (runeReady and 0) or 1;
			CooldownFrame_SetTimer(cooldown, start, duration, displayCooldown);
		end

		frameY = math.floor( rawFrame / 8 );
		frameX = math.fmod( rawFrame, 8);

		if ( frameY <= 0 ) then
			frameY = 0;
		end
		if ( percent <= 0 ) then
			frameX = 0;
		end

		if (DKIRunes_Saved.hero) then
			if (DKIRunes_Saved.rotate == 1 or DKIRunes_Saved.rotate == 2) then
				heroValue = -heroValue;
			end
			if (DKIRunes_Saved.rotate % 2 == 1) then
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', heroValue, runeOffset[rune] )
			else
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[rune], -heroValue ) 
			end
		end

	end

	DKIRunes_Rune_SetFrame(rune, frameX, frameY);

--	ChatFrame1:AddMessage("Start: "..start.." percent: "..tostring(percent).." aStart: "..animationStart.." x: "..tostring(frameX).." y: "..tostring(frameY).." maxx: "..tostring(maxFrameX).." maxy: "..tostring(maxFrameY) );


end

function DKIRunes_Rune_SetFrame(rune, frameX, frameY)
	--ChatFrame1:AddMessage(string.format("%s: (%s, %s)", rune, frameX, frameY));
	local width = 0.125;
	local height = 0.0625;
	local runeType = GetRuneType(rune);	
	local texture = DKIRunes[runeType];
	--ChatFrame1:AddMessage(string.format("FrameX: %s, FrameY: %s, Rune: %s", frameX, frameY, rune));

	getglobal("Rune"..rune):Show();
	getglobal("Rune"..rune.."Cooldown"):SetAlpha(0);
	getglobal("Rune"..rune.."Rune"):Show();
	getglobal("Rune"..rune.."Rune"):SetTexture(texture);
	getglobal("Rune"..rune.."Rune"):SetTexCoord(width * frameX, width * frameX + width, height * frameY, height * frameY + height);
end


function DKIRunes_populateBlizzardOptions()
	local frame = CreateFrame("frame", "DKIRunes_BlizzardOptions", UIParent);
	frame.name = "DKIRunes";
	frame:SetWidth(300);
	frame:SetHeight(200);
	frame:Show();

	local reset = CreateFrame("Button", "DKIRunesReset", frame, "OptionsButtonTemplate");
	reset:SetText("Reset to Default")
	reset:SetScript('OnClick', DKIRunes_Reset)
	reset:SetWidth(130);
	reset:SetHeight(24);
	reset:GetFontString():SetPoint("TOP", reset, "TOP", 0, -6)
	reset:SetPoint("TOPLEFT", 20, -20)

	local lock = CreateFrame("CheckButton", "FrameLock", frame, "OptionsCheckButtonTemplate");
	getglobal(lock:GetName().."Text"):SetText("Unlock Frame");
	lock:SetScript('OnShow', function(self) self:SetChecked(DKIRunesFrame:IsMouseEnabled()) end)
	lock:SetScript('OnClick', function(self) DKIRunes_Lock(self:GetChecked()) end)
	lock:SetPoint('LEFT', reset, 'RIGHT', 15, -2)

	local rotate = CreateFrame("Button", "RotateButton", frame, "OptionsButtonTemplate");
	rotate:SetText("Rotate")
	rotate:SetScript('OnClick', function() DKIRunes_Rotate(true) end)
	rotate:SetWidth(100);
	rotate:SetHeight(24);
	rotate:GetFontString():SetPoint("TOP", rotate, "TOP", 0, -6)
	rotate:SetPoint('LEFT', lock, 'RIGHT', 105, 2)

--[[	local wtf = CreateFrame("Button", "wtf", frame, "OptionsButtonTemplate");
	wtf:SetText("WTF?")
	wtf:SetScript('OnClick', DKIRunes_Debug)
	wtf:SetWidth(130);
	wtf:SetHeight(24);
	wtf:GetFontString():SetPoint("TOP", wtf, "TOP", 0, -6)
	wtf:SetPoint('LEFT', reset, 'RIGHT', 30, 0)
--]]
	local animateTitle = frame:CreateFontString("animateTitleString","ARTWORK","GameTooltipHeaderText");
	animateTitle:SetText("Rune Options")
	animateTitle:SetPoint('TOPLEFT', reset, 'BOTTOMLEFT', 0, -10)

	local animate = CreateFrame("CheckButton", "AnimateCheck", frame, "OptionsCheckButtonTemplate");
	getglobal(animate:GetName().."Text"):SetText("Flame Animation");
	animate:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.animate) end)
	animate:SetScript('OnClick', function(self) DKIRunes_Saved.animate = self:GetChecked() end)
	animate:SetPoint('TOPLEFT', animateTitle, 'BOTTOMLEFT', 20, -5)

	local cooldown = CreateFrame("CheckButton", "CooldownCheck", frame, "OptionsCheckButtonTemplate");
	getglobal(cooldown:GetName().."Text"):SetText("OmniCC Support");
	cooldown:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.cooldown) end)
	cooldown:SetScript('OnClick', function(self) DKIRunes_Saved.cooldown = self:GetChecked() end)
	cooldown:SetPoint('LEFT', animate, 'RIGHT', 120, 0)

	local graphicsTitle = frame:CreateFontString("graphicsTitleString","ARTWORK","GameTooltipHeaderText");
	graphicsTitle:SetText("Rune Frame Graphics")
	graphicsTitle:SetPoint('TOPLEFT', animate, 'BOTTOMLEFT', -20, -10)

	graphics = CreateFrame("Frame", "RuneFrameGraphics", frame, "UIDropDownMenuTemplate"); 
	graphics:SetPoint('TOPLEFT', graphicsTitle, 'BOTTOMLEFT', 5, -5)
	UIDropDownMenu_Initialize(graphics, Graphics_Initialise)

	local fade = CreateFrame("CheckButton", "AgroFade", frame, "OptionsCheckButtonTemplate");
	getglobal(fade:GetName().."Text"):SetText("Fade out of Combat");
	fade:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.fade) end)
	fade:SetScript('OnClick', function(self) DKIRunes_Saved.fade = self:GetChecked() end)
	fade:SetPoint('LEFT', graphics, 'RIGHT', 120, 0)

	local slider = CreateFrame("Slider", "ScaleSlider", frame, "OptionsSliderTemplate")
	slider:SetMinMaxValues(0.2, 2.0)
	slider:SetValueStep(0.05)
	slider:SetWidth(160)
	getglobal('ScaleSliderLow'):SetText("small")
	getglobal('ScaleSliderHigh'):SetText("large")
	slider:SetScript('OnShow', function(self) self:SetValue(DKIRunes_Saved.scale) end)
	slider:SetScript('OnValueChanged', Slider_ValueChanged)
	slider:SetPoint('TOPLEFT', graphics, 'BOTTOMLEFT', 18, -10)

	local slideTitle = frame:CreateFontString("slideTitleString","ARTWORK","GameFontNormal");
	slideTitle:SetText("Frame Scale")
	slideTitle:SetPoint('LEFT', slider, 'RIGHT', 10, 0)

	local rpTitle = frame:CreateFontString("rpTitleString","ARTWORK","GameTooltipHeaderText");
	rpTitle:SetText("Runic Power")
	rpTitle:SetPoint('TOPLEFT', graphicsTitle, 'BOTTOMLEFT', 0, -85)

--[[	local rpEnable = CreateFrame("CheckButton", "RPEnable", frame, "OptionsCheckButtonTemplate");
	getglobal(rpEnable:GetName().."Text"):SetText("Enabled");
	rpEnable:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.rp) end)
	rpEnable:SetScript('OnClick', function(self) DKIRunes_Saved.rp = self:GetChecked() end)
	rpEnable:SetPoint('TOPLEFT', rpTitle, 'BOTTOMLEFT', 5, -5)
--]]

	runicBar0 = CreateFrame("Frame", "RunicBar0", frame, "UIDropDownMenuTemplate"); 
	runicBar0:SetPoint('TOPLEFT', rpTitle, 'BOTTOMLEFT', 5, -5)
	UIDropDownMenu_Initialize(runicBar0, RunicBar0_Initialise)

	local runicBar0Title = frame:CreateFontString("runicBar0TitleString","ARTWORK","GameFontNormal");
	runicBar0Title:SetText("Port Side Bar")
	runicBar0Title:SetPoint('LEFT', runicBar0, 'RIGHT', 120, 0)

	runicBar1 = CreateFrame("Frame", "RunicBar1", frame, "UIDropDownMenuTemplate"); 
	runicBar1:SetPoint('TOP', runicBar0, 'BOTTOM', 0, -5)
	UIDropDownMenu_Initialize(runicBar1, RunicBar1_Initialise)

	local runicBar1Title = frame:CreateFontString("runicBar1TitleString","ARTWORK","GameFontNormal");
	runicBar1Title:SetText("Starboard Side Bar")
	runicBar1Title:SetPoint('LEFT', runicBar1, 'RIGHT', 120, 0)

	local rpCounterEnable = CreateFrame("CheckButton", "RPCounter", frame, "OptionsCheckButtonTemplate");
	getglobal(rpCounterEnable:GetName().."Text"):SetText("Numeric Display");
	rpCounterEnable:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.rpCounter) end)
	rpCounterEnable:SetScript('OnClick', function(self) DKIRunes_Saved.rpCounter = self:GetChecked() end)
	rpCounterEnable:SetPoint('TOP', runicBar1, 'BOTTOM', 10, -5)

	local counterSlider = CreateFrame("Slider", "CounterScaleSlider", frame, "OptionsSliderTemplate")
	counterSlider:SetMinMaxValues(0.2, 3.0)
	counterSlider:SetValueStep(0.05)
	counterSlider:SetWidth(60)
	getglobal('CounterScaleSliderLow'):SetText("small")
	getglobal('CounterScaleSliderHigh'):SetText("large")
	counterSlider:SetScript('OnShow', function(self) self:SetValue(DKIRunes_Saved.counterScale) end)
	counterSlider:SetScript('OnValueChanged', CounterSlider_ValueChanged)
	counterSlider:SetPoint('LEFT', rpCounterEnable, 'RIGHT', 120, 0)

	local heroTitle = frame:CreateFontString("heroTitleString","ARTWORK","GameTooltipHeaderText");
	heroTitle:SetText("Rune Slide")
	heroTitle:SetPoint('TOPLEFT', rpCounterEnable, 'BOTTOMLEFT', -20, -10)

	local heroEnable = CreateFrame("CheckButton", "HeroEnable", frame, "OptionsCheckButtonTemplate");
	getglobal(heroEnable:GetName().."Text"):SetText("Enabled");
	heroEnable:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.hero) end)
	heroEnable:SetScript('OnClick', function(self) DKIRunes_Saved.hero = self:GetChecked() end)
	heroEnable:SetPoint('TOPLEFT', heroTitle, 'BOTTOMLEFT', 20, -5)

	heroOrigin = CreateFrame("Frame", "HeroOrigin", frame, "UIDropDownMenuTemplate"); 
	heroOrigin:SetPoint('LEFT', heroEnable, 'RIGHT', 50, 0)
	UIDropDownMenu_Initialize(heroOrigin, HeroOrigin_Initialise)

	local heroOriginTitle = frame:CreateFontString("heroOriginTitleString","ARTWORK","GameFontNormal");
	heroOriginTitle:SetText("Slide Origin")
	heroOriginTitle:SetPoint('LEFT', heroOrigin, 'RIGHT', 115, 0)

	local heroSliderBackground = CreateFrame("Slider", "HeroSliderBackground", frame, "OptionsSliderTemplate")
	heroSliderBackground:SetMinMaxValues(0, 300)
	heroSliderBackground:SetValueStep(1)
	heroSliderBackground:SetWidth(225)
	getglobal('HeroSliderBackgroundLow'):SetText("0")
	getglobal('HeroSliderBackgroundHigh'):SetText(" ")
	heroSliderBackground:SetPoint('TOPLEFT', heroTitle, 'BOTTOMLEFT', 20, -35)
	heroSliderBackground:Disable()

	local heroSlider = CreateFrame("Slider", "HeroSlider", getglobal('HeroSliderBackground'), "OptionsSliderTemplate")
	heroSlider:SetMinMaxValues(50, 300)
	heroSlider:SetValueStep(1)
	heroSlider:SetWidth(175)
	getglobal('HeroSliderLow'):SetText("near")
	getglobal('HeroSliderHigh'):SetText("far")
	heroSlider:SetScript('OnShow', function(self) self:SetValue(DKIRunes_Saved.heroSlide) end)
	heroSlider:SetScript('OnValueChanged', HeroSlider_ValueChanged)
	heroSlider:SetPoint('TOPLEFT', heroTitle, 'BOTTOMLEFT', 70, -35)

	local heroSliderTitle = frame:CreateFontString("heroSliderTitleString","ARTWORK","GameFontNormal");
	heroSliderTitle:SetText("Slide Distance")
	heroSliderTitle:SetPoint('LEFT', heroSlider, 'RIGHT', 6, 0)

	InterfaceOptions_AddCategory(frame);

	DKIRunes_ConfigChange();
end


function DKIRunes_Rotate(spin)
	
	if(spin) then
		DKIRunes_Saved.rotate = DKIRunes_Saved.rotate + 1;
	end

	if (DKIRunes_Saved.rotate > 3) then 
		DKIRunes_Saved.rotate = 0;
	end

	EbonBlade_Bar_0:ClearAllPoints()
	EbonBlade_Bar_1:ClearAllPoints()

	if (DKIRunes_Saved.rotate == 1) then
		EbonBlade_Base:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0);
		EbonBlade_Bar_0:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0);
		EbonBlade_Bar_0:SetPoint('TOPLEFT', DKIRunesFrame, 'CENTER', 0, 86)
		EbonBlade_Bar_1:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0);
		EbonBlade_Bar_1:SetPoint('TOPRIGHT', DKIRunesFrame, 'CENTER', 0, 86)
		EbonBlade_Top:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0);
	elseif (DKIRunes_Saved.rotate == 2) then
		EbonBlade_Base:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0);
		EbonBlade_Bar_0:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0);
		EbonBlade_Bar_0:SetPoint('TOPRIGHT', DKIRunesFrame, 'CENTER', 86, 0)
		EbonBlade_Bar_1:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0);
		EbonBlade_Bar_1:SetPoint('BOTTOMRIGHT', DKIRunesFrame, 'CENTER', 86, 0)
		EbonBlade_Top:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0);
	elseif (DKIRunes_Saved.rotate == 3) then
		EbonBlade_Base:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1);
		EbonBlade_Bar_0:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1);
		EbonBlade_Bar_0:SetPoint('BOTTOMRIGHT', DKIRunesFrame, 'CENTER', 0, -86)
		EbonBlade_Bar_1:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1);
		EbonBlade_Bar_1:SetPoint('BOTTOMLEFT', DKIRunesFrame, 'CENTER', 0, -86)
		EbonBlade_Top:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1);
	else
		EbonBlade_Base:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1);
		EbonBlade_Bar_0:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1);
		EbonBlade_Bar_0:SetPoint('BOTTOMLEFT', DKIRunesFrame, 'CENTER', -86, 0)
		EbonBlade_Bar_1:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1);
		EbonBlade_Bar_1:SetPoint('TOPLEFT', DKIRunesFrame, 'CENTER', -86, 0)
		EbonBlade_Top:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1);
	end

	if (DKIRunes_Saved.rotate % 2 == 1) then
		EbonBlade_Base:SetWidth(256);
		EbonBlade_Base:SetHeight(512);
		EbonBlade_Bar_0:SetWidth(17);
		EbonBlade_Bar_1:SetWidth(17);
		EbonBlade_Top:SetWidth(256);
		EbonBlade_Top:SetHeight(512);
		getglobal("Rune1"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[1])
		getglobal("Rune2"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[2])
		getglobal("Rune5"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[5])
		getglobal("Rune6"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[6])
		getglobal("Rune3"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[3])
		getglobal("Rune4"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 0, runeOffset[4])
	else
		EbonBlade_Base:SetWidth(512);
		EbonBlade_Base:SetHeight(256);
		EbonBlade_Bar_0:SetHeight(17);
		EbonBlade_Bar_1:SetHeight(17);
		EbonBlade_Top:SetWidth(512);
		EbonBlade_Top:SetHeight(256);
		getglobal("Rune1"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[1], 0)
		getglobal("Rune2"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[2], 0)
		getglobal("Rune5"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[5], 0)
		getglobal("Rune6"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[6], 0)
		getglobal("Rune3"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[3], 0)
		getglobal("Rune4"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -runeOffset[4], 0)
	end

	DKIRunes_BarUpdate();
	FixRPCounterLocation()
	DKIRunes_UpdateArt();
	DKIRunes_UpdateUI();
end

function DKIRunes_ConfigChange()
	DKIRunes_BlizzardOptions:Hide();
	DKIRunes_BlizzardOptions:Show();
end

function DKIRunes_Reset(frame)
	DKIRunes_Saved.artStyle = 1;
	DKIRunes_Saved.animate = true;
	DKIRunes_Saved.cooldown = false;
	DKIRunes_Saved.parent = "UIParent";
	DKIRunes_Saved.point = "TOPLEFT";
	DKIRunes_Saved.parentPoint = "TOPLEFT";
	DKIRunes_Saved.x = -73;
	DKIRunes_Saved.y = 25;
	DKIRunes_Saved.scale = 0.8;
	DKIRunes_Saved.rotate = 0;
	DKIRunes_Rotate(false);
	DKIRunes_Saved.hero = false;
	DKIRunes_Saved.heroSlide = 150;
	DKIRunes_Saved.heroOrigin = 1;
	DKIRunes_Saved.bar0 = 1;
	RunicBar0_Set(DKIRunes_Saved.bar0)
	DKIRunes_Saved.bar1 = 1;
	RunicBar1_Set(DKIRunes_Saved.bar1)
	DKIRunes_Saved.rpCounter = true;
	DKIRunes_Saved.counterScale = 1;
	DKIRunes_Saved.fade = false;

	DKIRunesFrame:SetMovable(false)
	DKIRunesFrame:EnableMouse(false)

	DKIRunes_ConfigChange();
	DKIRunes_UpdateUI();

	UIDropDownMenu_Initialize(getglobal("RuneFrameGraphics"), Graphics_Initialise)
	UIDropDownMenu_Initialize(getglobal("HeroOrigin"), HeroOrigin_Initialise)
	UIDropDownMenu_Initialize(getglobal("RunicBar0"), RunicBar0_Initialise)
	UIDropDownMenu_Initialize(getglobal("RunicBar1"), RunicBar1_Initialise)

end

function DKIRunes_Lock(checked)
	DKIRunesFrame:SetMovable(checked)
	DKIRunesFrame:EnableMouse(checked)
	DKIRunes_Saved.point, relativeTo, DKIRunes_Saved.parentPoint, DKIRunes_Saved.x, DKIRunes_Saved.y = DKIRunesFrame:GetPoint();
end


function Graphics_Initialise()
	level = level or 1
	 
	local info = UIDropDownMenu_CreateInfo();
	 
	info.text = "none"; 
	info.value = 0; 
	info.func = function() Graphics_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.artStyle == 0); 
	UIDropDownMenu_AddButton(info, level); 
	 
	info.text = "Ebon Blade"; 
	info.value = 1; 
	info.func = function() Graphics_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.artStyle == 1); 
	UIDropDownMenu_AddButton(info, level);
	 
	info.text = "Simple Box"; 
	info.value = 2; 
	info.func = function() Graphics_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.artStyle == 2); 
	UIDropDownMenu_AddButton(info, level);

	UIDropDownMenu_SetSelectedValue(RuneFrameGraphics, DKIRunes_Saved.artStyle)
end

function Graphics_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	DKIRunes_Saved.artStyle = this.value;
	DKIRunes_UpdateUI();
end

function RunicBar0_Initialise()
	level = level or 1
	 
	local info = UIDropDownMenu_CreateInfo();
	 
	info.text = "none"; 
	info.value = 0; 
	info.func = function() RunicBar0_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar0 == 0); 
	UIDropDownMenu_AddButton(info, level); 
	 
	info.text = "Runic Power"; 
	info.value = 1; 
	info.func = function() RunicBar0_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar0 == 1); 
	UIDropDownMenu_AddButton(info, level);
	 
	info.text = "Health Points"; 
	info.value = 2; 
	info.func = function() RunicBar0_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar0 == 2); 
	UIDropDownMenu_AddButton(info, level);
	 
	info.text = "Anti-Health Points"; 
	info.value = 3; 
	info.func = function() RunicBar0_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar0 == 3); 
	UIDropDownMenu_AddButton(info, level);

	UIDropDownMenu_SetSelectedValue(RunicBar0, DKIRunes_Saved.bar0)
end

function RunicBar0_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	DKIRunes_Saved.bar0 = this.value;
	RunicBar0_Set(this.value)
	DKIRunes_UpdateUI();
end

function RunicBar0_Set(bar)
	if(bar == 0) then
		EbonBlade_Bar_0:Hide();
	else
		EbonBlade_Bar_0:Show();
	end
	if(bar == 2) then
		EbonBlade_Bar_0:SetTexture(0.0,1.0,0.0,0.75)
	elseif(bar == 3) then
		EbonBlade_Bar_0:SetTexture(1.0,0.0,0.0,0.75)
	else
		EbonBlade_Bar_0:SetTexture(0.0,0.82,1.0,0.75)
	end
end

function RunicBar1_Initialise()
	level = level or 1
	 
	local info = UIDropDownMenu_CreateInfo();
	 
	info.text = "none"; 
	info.value = 0; 
	info.func = function() RunicBar1_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar1 == 0); 
	UIDropDownMenu_AddButton(info, level); 
	 
	info.text = "Runic Power"; 
	info.value = 1; 
	info.func = function() RunicBar1_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar1 == 1); 
	UIDropDownMenu_AddButton(info, level);
	 
	info.text = "Health Points"; 
	info.value = 2; 
	info.func = function() RunicBar1_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar1 == 2); 
	UIDropDownMenu_AddButton(info, level);
	 
	info.text = "Anti-Health Points"; 
	info.value = 3; 
	info.func = function() RunicBar1_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.bar1 == 3); 
	UIDropDownMenu_AddButton(info, level);

	UIDropDownMenu_SetSelectedValue(RunicBar1, DKIRunes_Saved.bar1)
end

function RunicBar1_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	DKIRunes_Saved.bar1 = this.value;
	RunicBar1_Set(this.value)
	DKIRunes_UpdateUI();
end

function RunicBar1_Set(bar)
	if(bar == 0) then
		EbonBlade_Bar_1:Hide();
	else
		EbonBlade_Bar_1:Show();
	end
	if(bar == 2) then
		EbonBlade_Bar_1:SetTexture(0.0,1.0,0.0,0.75)
	elseif(bar == 3) then
		EbonBlade_Bar_1:SetTexture(1.0,0.0,0.0,0.75)
	else
		EbonBlade_Bar_1:SetTexture(0.0,0.82,1.0,0.75)
	end
end

function HeroOrigin_Initialise()
	level = level or 1
	 
	local info = UIDropDownMenu_CreateInfo();
	 
	info.text = "Port"; 
	info.value = -1; 
	info.func = function() HeroOrigin_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.heroOrigin == -1); 
	UIDropDownMenu_AddButton(info, level); 
	 
	info.text = "Starboard"; 
	info.value = 1; 
	info.func = function() HeroOrigin_OnClick() end; 
	info.owner = this:GetParent(); 
	info.checked = (DKIRunes_Saved.heroOrigin == 1); 
	UIDropDownMenu_AddButton(info, level);

	UIDropDownMenu_SetSelectedValue(HeroOrigin, DKIRunes_Saved.heroOrigin)
end

function HeroOrigin_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	DKIRunes_Saved.heroOrigin = this.value;
	DKIRunes_UpdateUI();
end

function Slider_ValueChanged(self, value)
	DKIRunes_Saved.scale = value;
	DKIRunes_UpdateUI();
end

function HeroSlider_ValueChanged(self, value)
	DKIRunes_Saved.heroSlide = value;
	DKIRunes_UpdateUI();
end

function CounterSlider_ValueChanged(self, value)
	DKIRunes_Saved.counterScale = value;
	FixRPCounterLocation();
	DKIRunes_UpdateUI();
end

function FixRPCounterLocation()
	if (DKIRunes_Saved.rotate == 1) then
		DKIRunicPower:SetPoint('CENTER', DKIRunesFrame, 'CENTER', -1, 101 / DKIRunes_Saved.counterScale)
	elseif (DKIRunes_Saved.rotate == 2) then
		DKIRunicPower:SetPoint('CENTER', DKIRunesFrame, 'CENTER', 100 / DKIRunes_Saved.counterScale, 0)
	elseif (DKIRunes_Saved.rotate == 3) then
		DKIRunicPower:SetPoint('CENTER', DKIRunesFrame, 'CENTER', -1, -101 / DKIRunes_Saved.counterScale)
	else
		DKIRunicPower:SetPoint('CENTER', DKIRunesFrame, 'CENTER', -101 / DKIRunes_Saved.counterScale, 0)
	end
end

function DKIRunes_Debug()
	DKIRunes_BarUpdate()
--	ChatFrame1:AddMessage(" style: "..tostring(DKIRunes_Saved.artStyle).." x: "..tostring(DKIRunes_Saved.x).." style: "..tostring(DKIRunes_Saved.y) );
end

--load slash commands
SlashCmdList["DKIRUNES"] = function()
	InterfaceOptionsFrame_OpenToCategory('DKIRunes')
end
SLASH_DKIRUNES1 = "/dkirunes"
SLASH_DKIRUNES2 = "/dki"