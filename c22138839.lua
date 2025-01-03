--捕食植物バンクシアオーガ
---@param c Card
function c22138839.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c22138839.hspcon)
	e1:SetTarget(c22138839.hsptg)
	e1:SetOperation(c22138839.hspop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c22138839.ccon)
	e2:SetOperation(c22138839.cop)
	c:RegisterEffect(e2)
end
function c22138839.rfilter(c)
	return c:GetCounter(0x1041)>0 and c:IsReleasable(REASON_SPSUMMON)
end
function c22138839.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22138839.rfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c22138839.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c22138839.rfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c22138839.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
function c22138839.ccon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c22138839.cop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,nil,0x1041,1)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1041,1)
		if tc:IsLevelAbove(2) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetCondition(c22138839.lvcon)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
function c22138839.lvcon(e)
	return e:GetHandler():GetCounter(0x1041)>0
end
