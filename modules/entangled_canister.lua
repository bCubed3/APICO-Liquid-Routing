function entangled_canister_process(prev_level)
    objs = api_get_menu_objects()
    player_objs = api_get_player_instance()
    cans = {}
    change = 0
    for n=1,#objs do
        m_id = objs[n]["menu_id"]
        match = api_slot_match(m_id, {MOD_NAME .. "_canister3"})
        len = #match
        if len ~= 0 then
            for i=1,len do
                can = match[i]
                api_log("can", can["stats"]["amount"])
                change = change + (can["stats"]["amount"] - prev_level)
                table.insert(cans, can)
            end
        end
    end
    api_log("change", change)
    for n=1,#cans do
        cans[n]["stats"]["amount"] = prev_level + change
        api_log("slot_set", api_slot_set(cans[n]["id"], cans[n]["item"], 1, cans[n]["stats"]))
        api_log("slot", cans[n]["stats"])
    end
    
    return prev_level + change
end