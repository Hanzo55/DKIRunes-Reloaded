
--load slash commands
SlashCmdList["DKIRUNES"] = function()
	InterfaceOptionsFrame_OpenToCategory('DKIRunes')
end
SLASH_DKIRUNES1 = "/dkirunes"
SLASH_DKIRUNES2 = "/dki"

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
	reset:SetPoint("TOPLEFT", 10, -20)

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
	rotate:SetPoint('LEFT', lock, 'RIGHT', 115, 2)

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


function DKIRunes_ConfigChange()
	DKIRunes_BlizzardOptions:Hide();
	DKIRunes_BlizzardOptions:Show();
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
