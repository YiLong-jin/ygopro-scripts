--魔轟神ディアネイラ
---@param c Card
function c53199020.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53199020,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c53199020.otcon)
	e1:SetOperation(c53199020.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	--change effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c53199020.chcon1)
	e2:SetOperation(c53199020.chop1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c53199020.chcon2)
	e3:SetOperation(c53199020.chop2)
	c:RegisterEffect(e3)
end
function c53199020.otfilter(c,tp)
	return c:IsSetCard(0x35) and (c:IsControler(tp) or c:IsFaceup())
end
function c53199020.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c53199020.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	return c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1,1,mg)
end
function c53199020.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c53199020.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function c53199020.chcon1(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and re:GetHandler():GetType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c53199020.chop1(e,tp,eg,ep,ev,re,r,rp)
	re:GetHandler():RegisterFlagEffect(53199020,RESET_CHAIN,0,1)
end
function c53199020.chcon2(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():GetFlagEffect(53199020)>0
end
function c53199020.chop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c53199020.rep_op)
end
function c53199020.rep_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,53199020)
	Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
end
