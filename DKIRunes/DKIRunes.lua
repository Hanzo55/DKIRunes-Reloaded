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
	[1] = 0,
	[2] = 24,
	[5] = 48,
	[6] = 72,
	[3] = 96,
	[4] = 120,
}

-- Saved Variable
DKIRunes_Saved = {
	artStyle = 1;
	animate = true;
	cooldown = false;
	parent = "PlayerFrame";
	point = "TOP";
	parentPoint = "BOTTOM";
	x = 62;
	y = 152;
	scale = 0.8;
	rotate = 0;
	hero = false;
	heroSlide = 150;
	heroOrigin = 1;
};

function DKIRunes_OnLoad(self)
	
	PetFrame:ClearAllPoints();
	PetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 60, -82);
	RuneFrame:Hide();
	

	-- Disable rune frame if not a death knight.
	local _, class = UnitClass("player");
	
	if ( class ~= "DEATHKNIGHT" ) then
		self:Hide();
	end
	
	self:RegisterEvent("RUNE_POWER_UPDATE");
	self:RegisterEvent("RUNE_TYPE_UPDATE");
	self:RegisterEvent("RUNE_REGEN_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("VARIABLES_LOADED");

	self:SetScript("OnEvent", DKIRunes_OnEvent);
	
	self.runes = {};

	DKIRunesFrame:SetMovable(false)
	DKIRunesFrame:EnableMouse(false)
	DKIRunesFrame:SetScript("OnMouseDown",function() DKIRunesFrame:StartMoving(); end)
	DKIRunesFrame:SetScript("OnMouseUp",function() DKIRunesFrame:StopMovingOrSizing() end)

	DKIRunesHorizontalBackdrop:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	DKIRunesHorizontalBackdrop:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
	DKIRunesVerticalBackdrop:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	DKIRunesVerticalBackdrop:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);

end


function DKIRunes_OnEvent (self, event, ...)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		Rune1Rune:SetTexCoord(0.75, 1.00, 0.75, 1.00);
		Rune2Rune:SetTexCoord(0.75, 1.00, 0.75, 1.00);

		Rune3Rune:SetTexture(DKIRunes[RUNETYPE_DEATH]);
		Rune4Rune:SetTexture(DKIRunes[RUNETYPE_DEATH]);
		Rune3Rune:SetTexCoord(0.75, 1.00, 0.75, 1.00);
		Rune4Rune:SetTexCoord(0.75, 1.00, 0.75, 1.00);

		Rune5Rune:SetTexture(DKIRunes[RUNETYPE_FROST]);
		Rune6Rune:SetTexture(DKIRunes[RUNETYPE_FROST]);
		Rune5Rune:SetTexCoord(0.75, 1.00, 0.75, 1.00);
		Rune6Rune:SetTexCoord(0.75, 1.00, 0.75, 1.00);

	elseif ( event == "VARIABLES_LOADED" ) then
		DKIRunes_Rotate(false);
		DKIRunes_UpdateUI();
		DKIRunes_populateBlizzardOptions();
	end
end

-- Update All
function DKIRunes_UpdateUI()
	DKIRunes_SetLocation()
	DKIRunes_UpdateArt();
end

-- Set Art
function DKIRunes_UpdateArt()
	DKIRunesFrame:SetScale(DKIRunes_Saved.scale);
	EbonBlade:Hide();
	DKIRunesHorizontalBackdrop:Hide();
	DKIRunesVerticalBackdrop:Hide();

	if ( DKIRunes_Saved.artStyle == 1 ) then
		EbonBlade:Show();
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

function DKIRunes_SetLocation()
	DKIRunesFrame:ClearAllPoints()
	DKIRunesFrame:Show();
	DKIRunesFrame:SetPoint(DKIRunes_Saved.point, DKIRunes_Saved.parent, DKIRunes_Saved.parentPoint, DKIRunes_Saved.x, DKIRunes_Saved.y);
end

function DKIRunes_OnUpdate(self, update)

	if(DKIRunesFrame:IsMouseEnabled()) then
		DKIRunes_Saved.point, relativeTo, DKIRunes_Saved.parentPoint, DKIRunes_Saved.x, DKIRunes_Saved.y = DKIRunesFrame:GetPoint();
		DKIRunes_Saved.parent = "UIParent";
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
end

function DKIRunes_AnimateRune(rune, animationStart, maxFrameX, maxFrameY)
	local frameX, frameY = maxFrameX, maxFrameY;
	local start, duration, runeReady = GetRuneCooldown(rune);
	local percent = 1 - ((GetTime() - start)/duration);
	local heroValue = percent * DKIRunes_Saved.heroSlide * DKIRunes_Saved.heroOrigin;

	if ( runeReady ) then
		if ( getglobal("Rune"..rune).notReady ) then
			getglobal("Rune"..rune).flash = 2.0;
			getglobal("Rune"..rune).notReady = nil;
		end
		if (DKIRunes_Saved.hero) then
			if (DKIRunes_Saved.rotate % 2 == 1) then
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, (-68 - runeOffset[rune]) ) 
			else
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', (-60 + runeOffset[rune]), 0 ) 
			end
		end
	else

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
		--ChatFrame1:AddMessage("Start: "..start.." percent: "..tostring(percent).." aStart: "..animationStart.." raw: "..rawFrame.." x: "..tostring(frameX).." y: "..tostring(frameY).." maxx: "..tostring(maxFrameX).." maxy: "..tostring(maxFrameY) );

		if (DKIRunes_Saved.hero) then
			if (DKIRunes_Saved.rotate == 1 or DKIRunes_Saved.rotate == 2) then
				heroValue = - heroValue;
			end
			if (DKIRunes_Saved.rotate % 2 == 1) then
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', (-128 + heroValue), (-68 - runeOffset[rune]) )
			else
				getglobal("Rune"..rune):SetPoint('CENTER', DKIRunesFrame, 'CENTER', (-60 + runeOffset[rune]), (0 - heroValue) ) 
			end
		end
	end

	DKIRunes_Rune_SetFrame(rune, frameX, frameY);


end

function DKIRunes_Rune_SetFrame(rune, frameX, frameY)
	--ChatFrame1:AddMessage(string.format("%s: (%s, %s)", rune, frameX, frameY));
	local width = 0.125;
	local height = 0.0625;
	local runeType = GetRuneType(rune);	
	local texture = DKIRunes[runeType];
	--ChatFrame1:AddMessage(string.format("FrameX: %s, FrameY: %s, Rune: %s", frameX, frameY, rune));

	getglobal("Rune"..rune):Show();
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
	getglobal(cooldown:GetName().."Text"):SetText("Blizzard Cooldowns (OmniCC Support)");
	cooldown:SetScript('OnShow', function(self) self:SetChecked(DKIRunes_Saved.cooldown) end)
	cooldown:SetScript('OnClick', function(self) DKIRunes_Saved.cooldown = self:GetChecked() end)
	cooldown:SetPoint('TOPLEFT', animate, 'BOTTOMLEFT', 0, 0)

	local graphicsTitle = frame:CreateFontString("graphicsTitleString","ARTWORK","GameTooltipHeaderText");
	graphicsTitle:SetText("Rune Frame Graphics")
	graphicsTitle:SetPoint('TOPLEFT', cooldown, 'BOTTOMLEFT', -20, -10)

	graphics = CreateFrame("Frame", "RuneFrameGraphics", frame, "UIDropDownMenuTemplate"); 
	graphics:SetPoint('TOPLEFT', graphicsTitle, 'BOTTOMLEFT', 5, -5)
	UIDropDownMenu_Initialize(graphics, Graphics_Initialise)

	local lock = CreateFrame("CheckButton", "FrameLock", frame, "OptionsCheckButtonTemplate");
	getglobal(lock:GetName().."Text"):SetText("Unlock Frame");
	lock:SetScript('OnShow', function(self) self:SetChecked(DKIRunesFrame:IsMouseEnabled()) end)
	lock:SetScript('OnClick', function(self) DKIRunes_Lock(self:GetChecked()) end)
	lock:SetPoint('LEFT', graphics, 'RIGHT', 120, 0)

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

	local rotate = CreateFrame("Button", "RotateButton", frame, "OptionsButtonTemplate");
	rotate:SetText("Rotate")
	rotate:SetScript('OnClick', function() DKIRunes_Rotate(true) end)
	rotate:SetWidth(130);
	rotate:SetHeight(24);
	rotate:GetFontString():SetPoint("TOP", rotate, "TOP", 0, -6)
	rotate:SetPoint('TOPLEFT', slider, 'BOTTOMLEFT', 0, -20)

	local heroTitle = frame:CreateFontString("heroTitleString","ARTWORK","GameTooltipHeaderText");
	heroTitle:SetText("Rune Slide")
	heroTitle:SetPoint('TOPLEFT', rotate, 'BOTTOMLEFT', -20, -10)

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
	getglobal('HeroSliderLow'):SetText("50")
	getglobal('HeroSliderHigh'):SetText("300")
	heroSlider:SetScript('OnShow', function(self) self:SetValue(DKIRunes_Saved.heroSlide) end)
	heroSlider:SetScript('OnValueChanged', HeroSlider_ValueChanged)
	heroSlider:SetPoint('TOPLEFT', heroTitle, 'BOTTOMLEFT', 70, -35)

	local heroSliderTitle = frame:CreateFontString("heroSliderTitleString","ARTWORK","GameFontNormal");
	heroSliderTitle:SetText("Slide Distance")
	heroSliderTitle:SetPoint('LEFT', heroSlider, 'RIGHT', 6, 0)

	InterfaceOptions_AddCategory(frame);

	DKIRunes_ConfigChange();
end


function DKIRunes_Rotate(relocate)
	
	if(relocate) then
		DKIRunes_Saved.rotate = DKIRunes_Saved.rotate + 1;
	end
	
	if (DKIRunes_Saved.rotate > 3) then 
		DKIRunes_Saved.rotate = 0;
	end

	if (DKIRunes_Saved.rotate == 1) then
		EbonBlade:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0);
	elseif (DKIRunes_Saved.rotate == 2) then
		EbonBlade:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0);
	elseif (DKIRunes_Saved.rotate == 3) then
		EbonBlade:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1);
	else
		EbonBlade:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1);
	end

	if (DKIRunes_Saved.rotate % 2 == 1) then
		if(relocate) then
			DKIRunes_Saved.x = DKIRunes_Saved.x + 128;
			DKIRunes_Saved.y = DKIRunes_Saved.y + 128;
		end
		EbonBlade:SetWidth(256);
		EbonBlade:SetHeight(512);
		getglobal("Rune1"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, -68)
		getglobal("Rune2"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, -92)
		getglobal("Rune5"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, -116)
		getglobal("Rune6"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, -140)
		getglobal("Rune3"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, -164)
		getglobal("Rune4"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -128, -188)
	else
		if(relocate) then
			DKIRunes_Saved.x = DKIRunes_Saved.x - 128;
			DKIRunes_Saved.y = DKIRunes_Saved.y - 128;
		end
		EbonBlade:SetWidth(512);
		EbonBlade:SetHeight(256);
		getglobal("Rune1"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -60, 0)
		getglobal("Rune2"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -36, 0)
		getglobal("Rune5"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', -12, 0)
		getglobal("Rune6"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 12, 0)
		getglobal("Rune3"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 36, 0)
		getglobal("Rune4"):SetPoint('CENTER', DKIRunesFrame, 'CENTER', 60, 0)
	end

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
	DKIRunes_Saved.parent = "PlayerFrame";
	DKIRunes_Saved.point = "TOPLEFT";
	DKIRunes_Saved.parentPoint = "TOPLEFT";
	DKIRunes_Saved.x = 78;
	DKIRunes_Saved.y = 158;
	DKIRunes_Saved.scale = 0.8;
	DKIRunes_Saved.rotate = -1;
	DKIRunes_Rotate(true);
	DKIRunes_Saved.hero = false;
	DKIRunes_Saved.heroSlide = 150;
	DKIRunes_Saved.heroOrigin = 1;
	
	DKIRunesFrame:SetMovable(false)
	DKIRunesFrame:EnableMouse(false)

	DKIRunes_UpdateUI();
	DKIRunes_ConfigChange();
end

function DKIRunes_Lock(checked)
	DKIRunesFrame:SetMovable(checked)
	DKIRunesFrame:EnableMouse(checked)
	DKIRunes_Saved.point, relativeTo, DKIRunes_Saved.parentPoint, DKIRunes_Saved.x, DKIRunes_Saved.y = DKIRunesFrame:GetPoint();
	DKIRunes_Saved.parent = relativeTo:GetName();
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

	UIDropDownMenu_SetSelectedValue(getglobal("RuneFrameGraphics"), DKIRunes_Saved.artStyle)
end

function Graphics_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	DKIRunes_Saved.artStyle = this.value;
	DKIRunes_UpdateUI();
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

function DKIRunes_Debug()
	ChatFrame1:AddMessage(" style: "..tostring(DKIRunes_Saved.artStyle).." x: "..tostring(DKIRunes_Saved.x).." style: "..tostring(DKIRunes_Saved.y) );
end


--[[
function DKIRunes_SlashCommand(cmd, self)
	DKIRunes_Reset(	DKIRunesFrame);
end


SLASH_DKIRUNES1 = "/dkirunes";
SlashCmdList["DKIRUNES"] = DKIRunes_SlashCommand;
--]]
