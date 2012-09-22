local DISEASETYPE_BLOODPLAGUE = 1;
local DISEASETYPE_FROSTFEVER = 2;
local DISEASETYPE_SCARLETFEVER = 4;

local DKIDisease_Ring = "Interface\\AddOns\\DKIDiseases\\ring"

local DKIDisease_Ring_Colors = {
	[DISEASETYPE_BLOODPLAGUE] = "Interface\\AddOns\\DKIDiseases\\BP_ring_color",
	[DISEASETYPE_FROSTFEVER] = "Interface\\AddOns\\DKIDiseases\\FF_ring_color",
	[DISEASETYPE_SCARLETFEVER] = "Interface\\AddOns\\DKIDiseases\\SF_ring_color",
};

local DKIDisease_Icons = {
	[DISEASETYPE_BLOODPLAGUE] = "Interface\\AddOns\\DKIDiseases\\BP_icon",
	[DISEASETYPE_FROSTFEVER] = "Interface\\AddOns\\DKIDiseases\\FF_icon",
	[DISEASETYPE_SCARLETFEVER] = "Interface\\AddOns\\DKIDiseases\\SF_icon",
};

local DKIDisease_Icon_Colors = {
	[DISEASETYPE_BLOODPLAGUE] = "Interface\\AddOns\\DKIDiseases\\BP_icon_color",
	[DISEASETYPE_FROSTFEVER] = "Interface\\AddOns\\DKIDiseases\\FF_icon_color",
	[DISEASETYPE_SCARLETFEVER] = "Interface\\AddOns\\DKIDiseases\\SF_icon_color",
};

local DKIDisease_Bars = {
	[DISEASETYPE_BLOODPLAGUE] = "Interface\\AddOns\\DKIDiseases\\BP_bar",
	[DISEASETYPE_FROSTFEVER] = "Interface\\AddOns\\DKIDiseases\\FF_bar",
	[DISEASETYPE_SCARLETFEVER] = "Interface\\AddOns\\DKIDiseases\\SF_bar",
};


local DKIDisease_Inner_Bars = {
	[DISEASETYPE_BLOODPLAGUE] = "Interface\\AddOns\\DKIDiseases\\BP_inner_bar",
	[DISEASETYPE_FROSTFEVER] = "Interface\\AddOns\\DKIDiseases\\FF_inner_bar",
	[DISEASETYPE_SCARLETFEVER] = "Interface\\AddOns\\DKIDiseases\\SF_inner_bar",
};

local DKIDiseaseStrata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"FULLSCREEN",
	"FULLSCREEN_DIALOG",
	"TOOLTIP"
	}

DKIDiseasesFrame = CreateFrame("Frame", "DKIDiseasesFrame", UIParent)

diseaseIcon = {}

diseaseIcon[0] = {}

diseaseIcon[0][0] = CreateFrame("Frame", "DKIDiseasesIcon00", DKIDiseasesFrame)
diseaseIcon[0][1] = CreateFrame("Frame", "DKIDiseasesIcon01", diseaseIcon[0][0])
diseaseIcon[0][2] = CreateFrame("Frame", "DKIDiseasesIcon02", diseaseIcon[0][0])
diseaseIcon[0][3] = CreateFrame("Frame", "DKIDiseasesIcon03", diseaseIcon[0][0])

diseaseIconFont = {}

diseaseIconFont[0] = {}

diseaseIconFont[0][2] = diseaseIcon[0][2]:CreateFontString("DKIDiseasesIconFont02","OVERLAY","GameTooltipText")
diseaseIconFont[0][3] = diseaseIcon[0][3]:CreateFontString("DKIDiseasesIconFont03","OVERLAY","GameTooltipText")

diseaseIcon[1] = {}

diseaseIcon[1][0] = CreateFrame("Frame", "DKIDiseasesIcon10", DKIDiseasesFrame)
diseaseIcon[1][1] = CreateFrame("Frame", "DKIDiseasesIcon11", diseaseIcon[1][0])
diseaseIcon[1][2] = CreateFrame("Frame", "DKIDiseasesIcon12", diseaseIcon[1][0])

diseaseIconFont[1] = {}
diseaseIconFont[1][2] = diseaseIcon[1][2]:CreateFontString("DKIDiseasesIconFont12","OVERLAY","GameTooltipText")

diseaseIcon[1][3] = CreateFrame("Frame", "DKIDiseasesIcon13", diseaseIcon[1][0])
diseaseIconFont[1][3] = diseaseIcon[1][3]:CreateFontString("DKIDiseasesIconFont13","OVERLAY","GameTooltipText")

diseaseIcon[2] = {}

diseaseIcon[2][0] = CreateFrame("Frame", "DKIDiseasesIcon20", DKIDiseasesFrame)
diseaseIcon[2][1] = CreateFrame("Frame", "DKIDiseasesIcon21", diseaseIcon[2][0])
diseaseIcon[2][2] = CreateFrame("Frame", "DKIDiseasesIcon22", diseaseIcon[2][0])

diseaseIconFont[2] = {}
diseaseIconFont[2][2] = diseaseIcon[2][2]:CreateFontString("DKIDiseasesIconFont22","OVERLAY","GameTooltipText")

diseaseIcon[2][3] = CreateFrame("Frame", "DKIDiseasesIcon23", diseaseIcon[2][0])
diseaseIconFont[2][3] = diseaseIcon[2][3]:CreateFontString("DKIDiseasesIconFont23","OVERLAY","GameTooltipText")

diseaseIcon[3] = {}

diseaseIcon[3][0] = CreateFrame("Frame", "DKIDiseasesIcon30", DKIDiseasesFrame)
diseaseIcon[3][1] = CreateFrame("Frame", "DKIDiseasesIcon31", diseaseIcon[3][0])
diseaseIcon[3][2] = CreateFrame("Frame", "DKIDiseasesIcon32", diseaseIcon[3][0])

diseaseIconFont[3] = {}
diseaseIconFont[3][2] = diseaseIcon[3][2]:CreateFontString("DKIDiseasesIconFont32","OVERLAY","GameTooltipText")

diseaseIcon[3][3] = CreateFrame("Frame", "DKIDiseasesIcon33", diseaseIcon[3][0])
diseaseIconFont[3][3] = diseaseIcon[3][3]:CreateFontString("DKIDiseasesIconFont33","OVERLAY","GameTooltipText")

local diseaseIconTexture = {}

diseaseIconTexture[0] = {}

diseaseIconTexture[0][0] = {}

diseaseIconTexture[0][0][0] = diseaseIcon[0][0]:CreateTexture("DKIDiseasesIcon000", "BACKGROUND")
diseaseIconTexture[0][0][1] = diseaseIcon[0][0]:CreateTexture("DKIDiseasesIcon001", "BORDER")

diseaseIconTexture[0][1] = {}

diseaseIconTexture[0][1][0] = diseaseIcon[0][1]:CreateTexture("DKIDiseasesIcon010", "ARTWORK")
diseaseIconTexture[0][1][1] = diseaseIcon[0][1]:CreateTexture("DKIDiseasesIcon011", "OVERLAY")

diseaseIconTexture[1] = {}

diseaseIconTexture[1][0] = {}

diseaseIconTexture[1][0][0] = diseaseIcon[1][0]:CreateTexture("DKIDiseasesIcon100", "BACKGROUND")
diseaseIconTexture[1][0][1] = diseaseIcon[1][0]:CreateTexture("DKIDiseasesIcon101", "BORDER")

diseaseIconTexture[1][1] = {}

diseaseIconTexture[1][1][0] = diseaseIcon[1][1]:CreateTexture("DKIDiseasesIcon110", "ARTWORK")
diseaseIconTexture[1][1][1] = diseaseIcon[1][1]:CreateTexture("DKIDiseasesIcon111", "OVERLAY")

diseaseIconTexture[2] = {}

diseaseIconTexture[2][0] = {}

diseaseIconTexture[2][0][0] = diseaseIcon[2][0]:CreateTexture("DKIDiseasesIcon200", "BACKGROUND")
diseaseIconTexture[2][0][1] = diseaseIcon[2][0]:CreateTexture("DKIDiseasesIcon201", "BORDER")

diseaseIconTexture[2][1] = {}

diseaseIconTexture[2][1][0] = diseaseIcon[2][1]:CreateTexture("DKIDiseasesIcon210", "ARTWORK")
diseaseIconTexture[2][1][1] = diseaseIcon[2][1]:CreateTexture("DKIDiseasesIcon211", "OVERLAY")

diseaseIconTexture[3] = {}

diseaseIconTexture[3][0] = {}

diseaseIconTexture[3][0][0] = diseaseIcon[3][0]:CreateTexture("DKIDiseasesIcon300", "BACKGROUND")
diseaseIconTexture[3][0][1] = diseaseIcon[3][0]:CreateTexture("DKIDiseasesIcon301", "BORDER")

diseaseIconTexture[3][1] = {}

diseaseIconTexture[3][1][0] = diseaseIcon[3][1]:CreateTexture("DKIDiseasesIcon310", "ARTWORK")
diseaseIconTexture[3][1][1] = diseaseIcon[3][1]:CreateTexture("DKIDiseasesIcon311", "OVERLAY")


local diseaseBar = {}

diseaseBar[0] = CreateFrame("Frame", "DKIDiseasesBar0", DKIDiseasesFrame)
diseaseBar[1] = CreateFrame("Frame", "DKIDiseasesBar1", DKIDiseasesFrame)
diseaseBar[2] = CreateFrame("Frame", "DKIDiseasesBar2", DKIDiseasesFrame)
diseaseBar[3] = CreateFrame("Frame", "DKIDiseasesBar3", DKIDiseasesFrame)

local diseaseBarTexture = {}

diseaseBarTexture[0] = {}

diseaseBarTexture[0][0] = diseaseBar[0]:CreateTexture("DKIDiseasesBar00", "BACKGROUND")
diseaseBarTexture[0][1] = diseaseBar[0]:CreateTexture("DKIDiseasesBar01", "BORDER")

diseaseBarTexture[1] = {}

diseaseBarTexture[1][0] = diseaseBar[1]:CreateTexture("DKIDiseasesBar10", "BACKGROUND")
diseaseBarTexture[1][1] = diseaseBar[1]:CreateTexture("DKIDiseasesBar11", "BORDER")

diseaseBarTexture[2] = {}

diseaseBarTexture[2][0] = diseaseBar[2]:CreateTexture("DKIDiseasesBar20", "BACKGROUND")
diseaseBarTexture[2][1] = diseaseBar[2]:CreateTexture("DKIDiseasesBar21", "BORDER")

diseaseBarTexture[3] = {}

diseaseBarTexture[3][0] = diseaseBar[3]:CreateTexture("DKIDiseasesBar30", "BACKGROUND")
diseaseBarTexture[3][1] = diseaseBar[3]:CreateTexture("DKIDiseasesBar31", "BORDER")

local pestTime = nil
local diseaseDuration = 30	--HANZO: v5.0.4: diseases are baseline 30s now. No more Epidemic talent.
local pest = {}
local ap = {}
--local IncludeEW = nil
local demo0Time = nil
local demo1Time = nil
local inCombat = 0
--local bar3 = 0;
local IncludeEP = nil
local IncludeSF = nil
local variablesLoaded;

-- Saved Variables
DKIDiseases_Saved = {
	ep = true;
	sf = true;
};

function DKIDiseases_LoadNewSavedVariables()

	if(DKIDiseases_Saved.point == nil) then
		DKIDiseases_Saved.point = {};
	end
	if(DKIDiseases_Saved.parentPoint == nil) then
		DKIDiseases_Saved.parentPoint = {};
	end
	if(DKIDiseases_Saved.relativeTo == nil) then
		DKIDiseases_Saved.relativeTo = {};
	end
	if(DKIDiseases_Saved.x == nil) then
		DKIDiseases_Saved.x = {};
	end
	if(DKIDiseases_Saved.y == nil) then
		DKIDiseases_Saved.y = {};
	end
	if(DKIDiseases_Saved.iconScale == nil) then
		DKIDiseases_Saved.iconScale = 0.7;
	end
	if(DKIDiseases_Saved.barScale == nil) then
		DKIDiseases_Saved.barScale = 0.7;
	end
	if(DKIDiseases_Saved.barLength == nil) then
		DKIDiseases_Saved.barLength = 255;
	end
	if(DKIDiseases_Saved.barOffset == nil) then
		DKIDiseases_Saved.barOffset = 12;
	end
	if(DKIDiseases_Saved.ringTrack == nil) then
		DKIDiseases_Saved.ringTrack = 2;
	end
	if(DKIDiseases_Saved.ringSil == nil) then
		DKIDiseases_Saved.ringSil = 2;
	end
	if(DKIDiseases_Saved.iconTrack == nil) then
		DKIDiseases_Saved.iconTrack = 1;
	end
	if(DKIDiseases_Saved.iconSil == nil) then
		DKIDiseases_Saved.iconSil = 2;
	end
	if(DKIDiseases_Saved.bladeTrack == nil) then
		DKIDiseases_Saved.bladeTrack = 1;
	end
	if(DKIDiseases_Saved.bladeAlpha == nil) then
		DKIDiseases_Saved.bladeAlpha = 1;
	end
	if(DKIDiseases_Saved.barTrack == nil) then
		DKIDiseases_Saved.barTrack = 2;
	end
	if(DKIDiseases_Saved.barAlpha == nil) then
		DKIDiseases_Saved.barAlpha = 0.8;
	end
	if(DKIDiseases_Saved.diseaseTimerLoc == nil) then
		DKIDiseases_Saved.diseaseTimerLoc = 0;
	end
	if(DKIDiseases_Saved.pestilenceTimerLoc == nil) then
		DKIDiseases_Saved.pestilenceTimerLoc = 0;
	end
	if(DKIDiseases_Saved.timerScale == nil) then
		DKIDiseases_Saved.timerScale = 1.45;
	end
	if(DKIDiseases_Saved.timerOffset == nil) then
		DKIDiseases_Saved.timerOffset = -3;
	end
	if(DKIDiseases_Saved.strata == nil) then
		DKIDiseases_Saved.strata = 1;
	end
	if(DKIDiseases_Saved.rotate == nil) then
		DKIDiseases_Saved.rotate = 0;
	end	

end

function DKIDiseases_OnLoad(self)

	-- Disable rune frame if not a death knight.
	local _, class = UnitClass("player");
	if ( class ~= "DEATHKNIGHT" ) then
		for i=0, 3 do
			diseaseIcon[i][0]:Hide();
			diseaseIcon[i][1]:Hide();
			diseaseBar[i]:Hide();
		end
	else
		self:RegisterEvent("VARIABLES_LOADED");
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		self:RegisterEvent("CHARACTER_POINTS_CHANGED");
		self:RegisterEvent("PLAYER_ENTER_COMBAT");
		self:RegisterEvent("PLAYER_LEAVE_COMBAT");
		self:RegisterEvent("PLAYER_ENTERING_WORLD");
		self:RegisterEvent("PLAYER_ALIVE");
		self:RegisterEvent("PLAYER_TALENT_UPDATE");

		DKIDiseasesFrame:SetScript("OnEvent", DKIDiseases_OnEvent)
		DKIDiseasesFrame:SetScript("OnUpdate", DKIDiseases_OnUpdate)
		
		for i=0, 3 do
			DKIDiseases_FrameOnLoad(diseaseIcon[i][0]);
		end
	end
end

function DKIDiseases_FrameOnLoad(frame)
	frame:SetScript("OnMouseDown",function() frame:StartMoving(); end)
	frame:SetScript("OnMouseUp",function() frame:StopMovingOrSizing(); end)
	frame:SetMovable(false)
	frame:EnableMouse(false)
end

function DKIDiseases_OnEvent(self, event, ...)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		InitDisease(0, DISEASETYPE_BLOODPLAGUE);
		InitDisease(1, DISEASETYPE_FROSTFEVER);
		
	elseif ( event == "VARIABLES_LOADED" ) then
		DKIDiseases_LoadNewSavedVariables();
		DKIDiseases_populateBlizzardOptions(diseaseIcon, diseaseBar);

	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") then
		DKIDiseases_UNIT_SPELLCAST_SUCCEEDED(...)

	elseif (event == "CHARACTER_POINTS_CHANGED") then
		DKIDiseases_Talents_Check();

	elseif ( event == "PLAYER_ALIVE" ) then
		DKIDiseases_Talents_Check();

	elseif ( event == "PLAYER_TALENT_UPDATE" ) then
		DKIDiseases_Talents_Check();

	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		inCombat = 1;

	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		inCombat = 0;

	end
	
end

function DKIDiseases_UpdateUI()
	InitDisease(0, DISEASETYPE_BLOODPLAGUE);
	InitDisease(1, DISEASETYPE_FROSTFEVER);
	DKIDiseases_Talents_Check();

	for id=0, 3 do
		if(DKIDiseases_Saved.ringSil == 2) then
			diseaseIconTexture[id][0][0]:Show();
		else
			diseaseIconTexture[id][0][0]:Hide();
		end
		diseaseIconTexture[id][0][1]:Hide();
		if(DKIDiseases_Saved.iconSil == 2) then
			diseaseIconTexture[id][1][0]:Show();
		else
			diseaseIconTexture[id][1][0]:Hide();
		end
		diseaseIconTexture[id][1][1]:Hide();
	end

end

function InitDisease(id, index)
	if(DKIDiseases_Saved.y[id] == nil) then
		DKIDiseases_ResetLocation(id);
	end
	
	diseaseIcon[id][0]:ClearAllPoints()
	diseaseIcon[id][0]:SetPoint(DKIDiseases_Saved.point[id], DKIDiseases_Saved.relativeTo[id], DKIDiseases_Saved.parentPoint[id], DKIDiseases_Saved.x[id], DKIDiseases_Saved.y[id])
--	diseaseIcon[id][0]:SetFrameStrata(DKIDiseaseStrata[DKIDiseases_Saved.strata]);
        diseaseIcon[id][0]:SetFrameLevel(2)
        diseaseIcon[id][0]:SetWidth(40)
        diseaseIcon[id][0]:SetHeight(40)
        diseaseIcon[id][0]:SetScale(DKIDiseases_Saved.iconScale)
	diseaseIconTexture[id][0][0]:SetTexture(DKIDisease_Ring);
        diseaseIconTexture[id][0][0]:SetAllPoints(diseaseIcon[id][0])
	diseaseIconTexture[id][0][0]:SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125)
	if(DKIDiseases_Saved.ringSil < 2) then
		diseaseIconTexture[id][0][0]:Hide();
	end
	diseaseIconTexture[id][0][1]:SetTexture(DKIDisease_Ring_Colors[index]);
        diseaseIconTexture[id][0][1]:SetAllPoints(diseaseIcon[id][0])
	diseaseIconTexture[id][0][1]:SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125)
        diseaseIconTexture[id][0][1]:Hide();
        diseaseIcon[id][0]:Show();

	diseaseIcon[id][1]:ClearAllPoints()
	diseaseIcon[id][1]:SetPoint("CENTER", diseaseIcon[id][0], "CENTER", 0, 0)
        diseaseIcon[id][1]:SetFrameLevel(2)
        diseaseIcon[id][1]:SetWidth(28)
        diseaseIcon[id][1]:SetHeight(28)
	diseaseIconTexture[id][1][0]:SetTexture(DKIDisease_Icons[index]);
        diseaseIconTexture[id][1][0]:SetAllPoints(diseaseIcon[id][1])
	diseaseIconTexture[id][1][0]:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)
	if(DKIDiseases_Saved.iconSil < 2) then
		diseaseIconTexture[id][1][0]:Hide();
	end
	diseaseIconTexture[id][1][1]:SetTexture(DKIDisease_Icon_Colors[index]);
        diseaseIconTexture[id][1][1]:SetAllPoints(diseaseIcon[id][1])
	diseaseIconTexture[id][1][1]:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)
        diseaseIconTexture[id][1][1]:Hide();
        diseaseIcon[id][1]:Show();

	diseaseIcon[id][2]:ClearAllPoints()
        diseaseIcon[id][2]:SetFrameLevel(3)
        diseaseIcon[id][2]:SetWidth(40)
        diseaseIcon[id][2]:SetHeight(40)
	diseaseIconFont[id][2]:SetFontObject(CombatLogFont)
	diseaseIconFont[id][2]:SetTextColor(1.0,1.0,1.0,1.0)
	diseaseIconFont[id][2]:SetPoint('CENTER', diseaseIcon[id][2], 'CENTER', 0, 0)
	diseaseIconFont[id][2]:Show();

	diseaseIcon[id][3]:ClearAllPoints()
        diseaseIcon[id][3]:SetFrameLevel(3)
        diseaseIcon[id][3]:SetWidth(40)
        diseaseIcon[id][3]:SetHeight(40)
	diseaseIconFont[id][3]:SetFontObject(CombatLogFont)
	diseaseIconFont[id][3]:SetTextColor(1.0,1.0,1.0,1.0)
	diseaseIconFont[id][3]:SetPoint('CENTER', diseaseIcon[id][3], 'CENTER', 0, 0)
	diseaseIconFont[id][3]:Show();

	diseaseBar[id]:ClearAllPoints()
	if (DKIDiseases_Saved.rotate == 1) then
		diseaseBar[id]:SetPoint("TOP", diseaseIcon[id][0], "CENTER", 0, -DKIDiseases_Saved.barOffset)
		diseaseBarTexture[id][0]:SetTexCoord(1, 1, 2, 1, 1, 0, 2, 0);
		diseaseBarTexture[id][0]:SetPoint("TOP", diseaseBar[id], "TOP", 0, 0)
		diseaseBarTexture[id][1]:SetTexCoord(1, 1, 2, 1, 1, 0, 2, 0);
		diseaseBarTexture[id][1]:SetPoint("TOP", diseaseBar[id], "TOP", 0, 0)
	elseif (DKIDiseases_Saved.rotate == 2) then
		diseaseBar[id]:SetPoint("RIGHT", diseaseIcon[id][0], "CENTER", -DKIDiseases_Saved.barOffset, 0)
		diseaseBarTexture[id][0]:SetTexCoord(2, 1, 2, 0, 1, 1, 1, 0);
		diseaseBarTexture[id][0]:SetPoint("RIGHT", diseaseBar[id], "RIGHT", 0, 0)
		diseaseBarTexture[id][1]:SetTexCoord(2, 1, 2, 0, 1, 1, 1, 0);
		diseaseBarTexture[id][1]:SetPoint("RIGHT", diseaseBar[id], "RIGHT", 0, 0)
	elseif (DKIDiseases_Saved.rotate == 3) then
		diseaseBar[id]:SetPoint("BOTTOM", diseaseIcon[id][0], "CENTER", 0, DKIDiseases_Saved.barOffset)
		diseaseBarTexture[id][0]:SetTexCoord(2, 0, 1, 0, 2, 1, 1, 1);
		diseaseBarTexture[id][0]:SetPoint("BOTTOM", diseaseBar[id], "BOTTOM", 0, 0)
		diseaseBarTexture[id][1]:SetTexCoord(2, 0, 1, 0, 2, 1, 1, 1);
		diseaseBarTexture[id][1]:SetPoint("BOTTOM", diseaseBar[id], "BOTTOM", 0, 0)
	else
		diseaseBar[id]:SetPoint("LEFT", diseaseIcon[id][0], "CENTER", DKIDiseases_Saved.barOffset, 0)
		diseaseBarTexture[id][0]:SetTexCoord(1, 0, 1, 1, 2, 0, 2, 1);
		diseaseBarTexture[id][0]:SetPoint("LEFT", diseaseBar[id], "LEFT", 0, 0)
		diseaseBarTexture[id][1]:SetTexCoord(1, 0, 1, 1, 2, 0, 2, 1);
		diseaseBarTexture[id][1]:SetPoint("LEFT", diseaseBar[id], "LEFT", 0, 0)
	end
--	diseaseBar[id]:SetFrameStrata(DKIDiseaseStrata[DKIDiseases_Saved.strata]);
	diseaseBar[id]:SetFrameLevel(1)
	if (DKIDiseases_Saved.rotate % 2 == 1) then
		diseaseBar[id]:SetWidth(32)
		diseaseBar[id]:SetHeight(256)
	else
		diseaseBar[id]:SetWidth(256)
		diseaseBar[id]:SetHeight(32)
	end
        diseaseBar[id]:SetScale(DKIDiseases_Saved.barScale)
	diseaseBarTexture[id][0]:SetTexture(DKIDisease_Inner_Bars[index]);
        diseaseBarTexture[id][0]:SetAllPoints(diseaseBar[id])
	diseaseBarTexture[id][0]:SetAlpha(DKIDiseases_Saved.barAlpha);
	diseaseBarTexture[id][1]:SetTexture(DKIDisease_Bars[index]);
        diseaseBarTexture[id][1]:SetAllPoints(diseaseBar[id])
	diseaseBarTexture[id][1]:SetAlpha(DKIDiseases_Saved.bladeAlpha);
	diseaseBarTexture[id][0]:Show();
        diseaseBarTexture[id][1]:Show();
        diseaseBar[id]:Show();
end

--function DKIDiseases:UNIT_SPELLCAST_SENT( player, spell, rank, target)
--	ChatFrame1:AddMessage("SENT player: "..tostring(player).." spell: "..tostring(spell).." target: "..tostring(target));
--end

function DKIDiseases_Talents_Check()
	
	local talents = GetSpecialization();
	
	if (talents ~= nil) then
	
		-- HANZO: If it is a Blood DK...
		if (talents == 1 and DKIDiseases_Saved.sf) then

			InitDisease(3, DISEASETYPE_SCARLETFEVER);

			-- HANZO: global flag for scarlet fever ON			
			IncludeSF = true;

		else

			diseaseIcon[3][0]:Hide();
			diseaseIcon[3][1]:Hide();
			diseaseBar[3]:Hide();
			
			-- HANZO: global flag for scarlet fever OFF
			IncludeSF = false;
					
		end
		
	else
	
		-- HANZO: If DK is in the middle of respeccing, shut this stuff off
		diseaseIcon[3][0]:Hide();
		diseaseIcon[3][1]:Hide();
		diseaseBar[3]:Hide();
			
		-- HANZO: global flag for scarlet fever OFF
		IncludeSF = false;
	
	end

end

function DKIDiseases_UNIT_SPELLCAST_SUCCEEDED( player, spell, rank )
	
	-- Pestilence
	if(player == "player" and spell == GetSpellInfo(50842)) then
		pestTime = GetTime();
		DKIDiseases_UpdateIconAndBar(55078, 0);
		DKIDiseases_UpdateIconAndBar(59921, 1);	
		pestTime = nil;
	end
	
	-- Plague Strike
	if(player == "player" and spell == GetSpellInfo(45462)) then
		local apBase, posBuff, negBuff = UnitAttackPower("player");
		ap[0] = apBase + posBuff + negBuff;
		if(IncludeSF) then
			DKIDiseases_UpdateIconAndBar(115798, 3, true); --HANZO: Pass the spell id for Weakened Blows in MoP
		end		
	end
	
	-- Icy Touch
	if(player == "player" and spell == GetSpellInfo(45477)) then
		local apBase, posBuff, negBuff = UnitAttackPower("player");
		ap[1] = apBase + posBuff + negBuff;
	end
	
	-- Howling Blast (which, if glyphed, would infect with Frost Fever)
	if(player == "player" and spell == GetSpellInfo(49184)) then
			local apBase, posBuff, negBuff = UnitAttackPower("player");
			ap[1] = apBase + posBuff + negBuff;
			DKIDiseases_UpdateIconAndBar(59921, 1, true);
	end
	
	-- Festering Strike
	if (player == "player" and (spell == GetSpellInfo(85948))) then
		local apBase, posBuff, negBuff = UnitAttackPower("player");
		ap[0] = apBase + posBuff + negBuff;	
		ap[1] = apBase + posBuff + negBuff;
	end
	
	--HANZO ** NEW for 5.0.4 **
	-- Unholy Blight applies Frost Fever *and* Blood Plague
	if (player == "player" and (spell == GetSpellInfo(115994))) then
		local apBase, posBuff, negBuff = UnitAttackPower("player");
		ap[1] = apBase + posBuff + negBuff;
		DKIDiseases_UpdateIconAndBar(55078, 0);
		DKIDiseases_UpdateIconAndBar(59921, 1);	
	end

end

function GetSpellID(spell)

    local name

    for i = 1, 100000 do
        name = GetSpellInfo(i)

        if name == spell then
ChatFrame1:AddMessage("id: "..i);
            return i

        end

    end

end

function DKIDiseases_OnUpdate(self, update)
	if(diseaseIcon[0][0]:IsMouseEnabled()) then
		for i=0, 3 do
			DKIDiseases_GetLocation(i);
		end
	end

	DKIDiseases_UpdateIconsAndBars(); 
 	DKIDiseases_UpdateDemoIconsAndBars(nil, nil); 
end

function DKIDiseases_GetLocation(i)
	local relativeTo;
	DKIDiseases_Saved.point[i], relativeTo, DKIDiseases_Saved.parentPoint[i], DKIDiseases_Saved.x[i], DKIDiseases_Saved.y[i] = diseaseIcon[i][0]:GetPoint();
	if(relativeTo) then
		DKIDiseases_Saved.relativeTo[i] = relativeTo:GetName();
	else
		DKIDiseases_Saved.relativeTo[i] = relativeTo;
	end
end

function DKIDiseases_UpdateIconsAndBars()
	DKIDiseases_UpdateIconAndBar(55078, 0); -- BLOOD PLAGUE
	DKIDiseases_UpdateIconAndBar(59921, 1); -- FROST FEVER

	-- HANZO: Scarlet Fever now causes Weakened Blows to be applied to targets with Blood Plague
	if(IncludeSF) then
		DKIDiseases_UpdateIconAndBar(115798, 3); -- WEAKENED BLOWS
	end
	
	--	id = GetSpellID("Frost Fever");
--	ChatFrame1:AddMessage("WTF: "..tostring(id));
--	id = GetSpellID("Blood Plague");
--	ChatFrame1:AddMessage("WTF: "..tostring(id));
--	id = GetSpellID("Crypt Fever");
--	ChatFrame1:AddMessage("WTF: "..tostring(id));
--	id = GetSpellID("Ebon Plague");
--	ChatFrame1:AddMessage("WTF: "..tostring(id));
--	id = GetSpellID("Pestilence");
--	ChatFrame1:AddMessage("WTF: "..tostring(id));
end

function DKIDiseases_UpdateDemoIconsAndBars(demo0Input, demo1Input)
	local speed = 5;
	if(demo0Input) then
		demo0Time = demo0Input;
	end
	if(demo1Input) then
		demo1Time = demo1Input;
	end

	if(demo0Time) then
		local delta =  ( (demo0Time + speed) - GetTime() ) / speed;
		if(delta <= 0) then
			demo0Time = nil;
			for id=0, 3 do
				DKIDiseases_Animate(id, 0, speed, 4)
			end
		else
			for id=0, 3 do
				DKIDiseases_Animate(id, delta, speed, 1)
				DKIDiseases_Animate(id, 1, speed, 4)
			end
		end
	end

	if(demo1Time) then
		local delta =  ( (demo1Time + speed) - GetTime() ) / speed;
		for id=0, 3 do
			DKIDiseases_Animate(id, delta, speed, 2)
			DKIDiseases_Animate(id, 1, speed, 5)
		end
		if(delta <= 0) then
			demo1Time = nil;
			for id=0, 3 do
				DKIDiseases_Animate(id, 0, speed, 5)
			end
		end
	end

end

function DKIDiseases_UpdateIconAndBar(debuff, id)
	DKIDiseases_UpdateIconAndBar(debuff, id, false)
end

function DKIDiseases_UpdateIconAndBar(debuff, id, forcePest)
 	local i = GetSpellInfo(debuff);
   	local _, _, _, _, _, duration, endTime, isMine = UnitDebuff('target', i)
	local apBase, posBuff, negBuff = UnitAttackPower("player");

	if(not duration or duration > 60) then
		duration = diseaseDuration;
	end
	--ChatFrame1:AddMessage("endtime: "..tostring(endTime).." isMine: "..tostring(endTime));
	
	if(endTime and isMine == "player") then
		local delta =  ( endTime - GetTime() ) / duration;
		DKIDiseases_Animate(id, delta, duration, 1)

		if(delta > 0) then
			DKIDiseases_Animate(id, 1, duration, 4)
		else
			DKIDiseases_Animate(id, 0, duration, 4)
		end
		
		if(pestTime) then
			pest[id] = pestTime + duration;
		end

		if(ap[id]) then
			local currentAp = apBase + posBuff + negBuff
			local delta = (ap[id] / currentAp) ^ 2
			if (currentAp <= ap[id]) then
				delta = 1
			end
			if (delta < 0.1) then
				delta = 0.1
			end
			DKIDiseases_Animate(id, delta, duration, 3)
		end
	else
		DKIDiseases_Animate(id, 0, duration, 1)
		DKIDiseases_Animate(id, 0, duration, 3)
		DKIDiseases_Animate(id, 0, duration, 4)
	end

	if(forcePest) then
		pest[id] = GetTime() + duration;
	end

	if(pest[id]) then
--	ChatFrame1:AddMessage("pid:"..pest[id].."/time:"..GetTime().."/dur:"..diseaseDuration);
		local delta =  ( pest[id] - GetTime() ) / duration;
		DKIDiseases_Animate(id, delta, duration, 2)
		DKIDiseases_Animate(id, 1, duration, 5)

		if(delta <= 0) then
			pest[id] = nil
			DKIDiseases_Animate(id, 0, duration, 5)
		end
	end	

end

function DKIDiseases_Animate(id, delta, duration, track)

	diseaseIconTexture[id][0][0]:SetAlpha(1.0);
	diseaseIconTexture[id][0][1]:SetAlpha(1.0);

	diseaseIconTexture[id][1][0]:SetAlpha(1.0);
	diseaseIconTexture[id][1][1]:SetAlpha(1.0);

	diseaseBarTexture[id][0]:SetAlpha(DKIDiseases_Saved.barAlpha);
	diseaseBarTexture[id][1]:SetAlpha(DKIDiseases_Saved.bladeAlpha);

	if(DKIDiseases_Saved.ringTrack == track) then
		if(delta > 0 and DKIDiseases_Saved.ringSil > 0) then
			diseaseIconTexture[id][0][0]:Show();
		elseif(DKIDiseases_Saved.ringSil < 2) then
			diseaseIconTexture[id][0][0]:Hide();
		end
		DKIDiseases_SetIconAnimation(id, 0, delta, 0.1875, 0.8125, 0.625, 40)
	end

	if(DKIDiseases_Saved.iconTrack == track) then
		if(delta > 0 and DKIDiseases_Saved.iconSil > 0) then
			diseaseIconTexture[id][1][0]:Show();
		elseif(DKIDiseases_Saved.iconSil < 2) then
			diseaseIconTexture[id][1][0]:Hide();
		end
		DKIDiseases_SetIconAnimation(id, 1, delta, 0.0625, 0.9375, 0.875, 28)
	end

	if(DKIDiseases_Saved.barTrack == track) then
		DKIDiseases_SetBarAnimation(id, 0, delta)
	end

	if(DKIDiseases_Saved.bladeTrack == track) then
		DKIDiseases_SetBarAnimation(id, 1, delta)
	end

	if(track == 1) then
		local text = floor(delta*duration+0.99);
		if(DKIDiseases_Saved.diseaseTimerLoc > 0 and text > 0 ) then
			FixDKIDTimerLocation(2, DKIDiseases_Saved.diseaseTimerLoc);
			diseaseIconFont[id][2]:SetText(text);
			diseaseIcon[id][2]:Show();
		else
			diseaseIcon[id][2]:Hide();
		end
	end

	if(track == 2) then
		local text = floor(delta*duration+0.99);
		if(DKIDiseases_Saved.pestilenceTimerLoc > 0 and text > 0 ) then
			FixDKIDTimerLocation(3, DKIDiseases_Saved.pestilenceTimerLoc);
			diseaseIconFont[id][3]:SetText(text);
			diseaseIcon[id][3]:Show();
		else
			diseaseIcon[id][3]:Hide();
		end
	end

	if(DKIDiseases_Saved.fade and inCombat == 0) then
		diseaseIconTexture[id][0][0]:SetAlpha(0.3);
		diseaseIconTexture[id][0][1]:SetAlpha(0.3);
		diseaseIconTexture[id][1][0]:SetAlpha(0.3);
		diseaseIconTexture[id][1][1]:SetAlpha(0.3);
		diseaseBarTexture[id][0]:SetAlpha(0.3);
		diseaseBarTexture[id][1]:SetAlpha(0.3);
	end
end

function DKIDiseases_SetIconAnimation(id, bar, delta, xOffset, yOffset, deltaOffset, size)
	if(delta > 0) then
		diseaseIconTexture[id][bar][1]:SetTexCoord(xOffset, yOffset, xOffset + deltaOffset*(1 - delta), yOffset + deltaOffset*(1 - delta))
		diseaseIconTexture[id][bar][1]:ClearAllPoints()
		diseaseIconTexture[id][bar][1]:SetPoint("TOP", diseaseIcon[id][bar], "TOP", 0, -size*(1 - delta))	
		diseaseIconTexture[id][bar][1]:SetPoint("BOTTOM", diseaseIcon[id][bar], "BOTTOM", 0, -size*(1 - delta))
		diseaseIconTexture[id][bar][1]:SetPoint("LEFT", diseaseIcon[id][bar], "LEFT")
		diseaseIconTexture[id][bar][1]:SetPoint("RIGHT", diseaseIcon[id][bar], "RIGHT")
		diseaseIconTexture[id][bar][1]:Show();
	else
		diseaseIconTexture[id][bar][1]:Hide();
	end
end

function DKIDiseases_SetBarAnimation(id, bar, delta)
	local barLengthRatio = DKIDiseases_Saved.barLength * delta / 255;
	local a = 1 - barLengthRatio;
	local b = 2 - barLengthRatio;
	if(delta > 0) then
		if (DKIDiseases_Saved.rotate == 1) then
			diseaseBarTexture[id][bar]:SetTexCoord(a, 1, b, 1, a, 0, b, 0);
		elseif (DKIDiseases_Saved.rotate == 2) then
			diseaseBarTexture[id][bar]:SetTexCoord(b, 1, b, 0, a, 1, a, 0);
		elseif (DKIDiseases_Saved.rotate == 3) then
			diseaseBarTexture[id][bar]:SetTexCoord(b, 0, a, 0, b, 1, a, 1);
		else
			diseaseBarTexture[id][bar]:SetTexCoord(a, 0, a, 1, b, 0, b, 1);
		end
		diseaseBarTexture[id][bar]:Show();
	else
		diseaseBarTexture[id][bar]:Hide();
	end
end

function DKIDiseases_Rotate()
	
	DKIDiseases_Saved.rotate = DKIDiseases_Saved.rotate + 1;
	if (DKIDiseases_Saved.rotate > 3) then 
		DKIDiseases_Saved.rotate = 0;
	end

	DKIDiseases_UpdateUI()

end

function DKIDiseases_Reset()
	
	DKIDiseases_Saved.iconScale = 0.7;
	DKIDiseases_Saved.barScale = 0.7;
	DKIDiseases_Saved.barLength = 255;
	DKIDiseases_Saved.barOffset = 12;
	DKIDiseases_Saved.ringTrack = 2;
	DKIDiseases_Saved.ringSil = 2;
	DKIDiseases_Saved.iconTrack = 1;
	DKIDiseases_Saved.iconSil = 2;
	DKIDiseases_Saved.bladeTrack = 1;
	DKIDiseases_Saved.bladeAlpha = 1;
	DKIDiseases_Saved.barTrack = 2;
	DKIDiseases_Saved.barAlpha = 0.8;
	DKIDiseases_Saved.diseaseTimerLoc = 0;
	DKIDiseases_Saved.pestilenceTimerLoc = 0;
	DKIDiseases_Saved.timerScale = 1.45;
	DKIDiseases_Saved.timerOffset = -3;
	DKIDiseases_Saved.strata = 1;
	DKIDiseases_Saved.fade = false;
	DKIDiseases_Saved.rotate = 0;
	DKIDiseases_Saved.ep = true;
	DKIDiseases_Saved.sf = true;
	
	for i=0, 3 do
		diseaseIcon[i][0]:SetMovable(false)
		diseaseIcon[i][0]:EnableMouse(false)
		diseaseBar[i]:SetMovable(false)
		diseaseBar[i]:EnableMouse(false)
	end

	DKIDiseases_ConfigChange();
	
	for i=0, 3 do	
		DKIDiseases_ResetLocation(i);
	end

--ChatFrame1:AddMessage("point:"..DKIDiseases_Saved.point[0].." rel:"..DKIDiseases_Saved.relativeTo[0].." par:"..DKIDiseases_Saved.parentPoint[0].." savedX:"..tostring(DKIDiseases_Saved.x[0]).." savedY:"..tostring(DKIDiseases_Saved.y[0]));

	UIDropDownMenu_Initialize(_G["RingTrack"], RingTrack_Initialise)
	UIDropDownMenu_Initialize(_G["RingTrackSil"], RingTrackSil_Initialise)
	UIDropDownMenu_Initialize(_G["IconTrack"], IconTrack_Initialise)
	UIDropDownMenu_Initialize(_G["IconTrackSil"], IconTrackSil_Initialise)
	UIDropDownMenu_Initialize(_G["BladeTrack"], BladeTrack_Initialise)
	UIDropDownMenu_Initialize(_G["BarTrack"], BarTrack_Initialise)
	UIDropDownMenu_Initialize(_G["DKIDTimerLoc"], DKIDTimerLoc_Initialise)
	UIDropDownMenu_Initialize(_G["DKIPTimerLoc"], DKIPTimerLoc_Initialise)

	DKIDiseases_UpdateUI();

end

function DKIDiseases_ResetLocation(i)
	local relativeTo;			

	diseaseIcon[i][0]:ClearAllPoints()

	local j = i;
	if (i == 3) then
		j = 2
	end
	
	if(DKIRunesFrame) then
		diseaseIcon[i][0]:SetPoint("TOP", DKIRunesFrame, "CENTER", -117, -32 - j*40);
	else
		diseaseIcon[i][0]:SetPoint("TOP", UIParent, "CENTER", -117, -80 - j*40);
	end

	DKIDiseases_GetLocation(i);

	FixDKIDTimerLocation(2, DKIDiseases_Saved.diseaseTimerLoc);
	FixDKIDTimerLocation(3, DKIDiseases_Saved.pestilenceTimerLoc);
end

function FixDKIDTimerLocation(frame, var)
	for i=0, 3 do
		diseaseIcon[i][frame]:ClearAllPoints()
		if(var == 1) then
			diseaseIcon[i][frame]:SetPoint('CENTER', diseaseIcon[i][0], 'CENTER', -1, 0)
		elseif(var == 2) then
			diseaseIcon[i][frame]:SetPoint('CENTER', diseaseIcon[i][0], 'CENTER', -1, DKIDiseases_Saved.timerOffset + 40/DKIDiseases_Saved.timerScale)
		elseif(var == 3) then
			diseaseIcon[i][frame]:SetPoint('CENTER', diseaseIcon[i][0], 'CENTER', -1 + DKIDiseases_Saved.timerOffset + 40/DKIDiseases_Saved.timerScale, 0)
		elseif(var == 4) then
			diseaseIcon[i][frame]:SetPoint('CENTER', diseaseIcon[i][0], 'CENTER', -1, -DKIDiseases_Saved.timerOffset -40/DKIDiseases_Saved.timerScale)
		else
			diseaseIcon[i][frame]:SetPoint('CENTER', diseaseIcon[i][0], 'CENTER', -1 - DKIDiseases_Saved.timerOffset - 40/DKIDiseases_Saved.timerScale, 0)
		end
		diseaseIcon[i][frame]:SetScale(DKIDiseases_Saved.timerScale);
		diseaseIcon[i][frame]:SetScale(DKIDiseases_Saved.timerScale);
	end
end

DKIDiseases_OnLoad(DKIDiseasesFrame)
