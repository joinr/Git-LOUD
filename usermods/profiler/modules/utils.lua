
--- table.deepcopy(t) returns a copy of t with all sub-tables also copied.
function DeepCopy(t,backrefs)
    if type(t)=='table' then
        if backrefs==nil then backrefs = {} end

        local b = backrefs[t]
        if b then
            return b
        end

        local r = {}
        backrefs[t] = r
        for k,v in t do
            r[k] = DeepCopy(v,backrefs)
        end
        return r
    else
        return t
    end
end