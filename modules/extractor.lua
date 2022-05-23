DRAIN_SPEED = 50

function extractor_define(menu_id)
    api_dp(menu_id, "extract_filter", "resin")
    coord = {
        x = api_gp(menu_id, "obj_x"),
        y = api_gp(menu_id, "obj_y")
    }
    api_dp(menu_id, "coord", coord)
    fields = {"extract_filter", "coord"}
    api_dp(menu_id, "_fields", fields)
    api_define_tank(menu_id, 500, 1000, "resin", 30, 14, "small")
    api_set_immortal(api_gp(menu_id, "obj"), true)
    table.insert(EXTRACTORS, menu_id)
end

function extractor_change(menu_id)
    in_slot = api_get_slot(menu_id, 1)
    out_slot = api_get_slot(menu_id, 2)
    if out_slot["item"] == "canister1" or out_slot["item"] == "canister2" then
        api_slot_drain(menu_id, 2)
    end

    if in_slot["item"] == "canister1" or in_slot["item"] == "canister2" then
        api_sp(menu_id, "extract_filter", in_slot["stats"]["type"])
        if tank_amt == 0 then
            api_sp(menu_id, "tank_type", in_slot["stats"]["type"])
        end
    end
    
end

function extractor_draw(menu_id)
    api_draw_tank(api_gp(menu_id, "tank_gui"))
end

function extractor_process(menu_id)
    -- get the extractor's filter
    filter = api_gp(menu_id, "extract_filter")
    if api_gp(menu_id, "tank_amount") == 0 and filter ~= api_gp(menu_id, "tank_type") then
        api_sp(menu_id, "tank_type", filter)
    end
    -- if there's no filter, do nothing
    if filter ~= "" then
        coord = api_gp(menu_id, "coord")
        -- get nearby menu objects
        nearby = api_get_menu_objects(64, nil, coord)
        for n=1,#nearby do
            api_set_immortal(nearby[n]["id"], true)
            -- if the object is self, do nothing
            if nearby[n]["menu_id"] ~= menu_id and nearby[n]["item"] ~= MOD_NAME .. "extractor" then
                oid = nearby[n]["oid"]
                nearby_menu_id = nearby[n]["menu_id"]
                -- check that there is a tank (todo : make sure the tank has liquid in it)
                tank_amt = api_gp(nearby_menu_id, "tank_amount")
                if tank_amt ~= nil then
                    tank_type = api_gp(nearby_menu_id, "tank_type")
                    self_tank_amt = api_gp(menu_id, "tank_amount")
                    self_tank_max = api_gp(menu_id, "tank_max")
                    self_tank_type = api_gp(menu_id, "tank_type")
                    if tank_amt ~= 0 and (tank_type == filter) and (tank_type == self_tank_type) then
                        if self_tank_max - self_tank_amt < DRAIN_SPEED then
                           api_sp(menu_id, "tank_amount", api_gp(menu_id, "tank_amount") + util_tank_drain(menu_id, nearby_menu_id, self_tank_max - self_tank_amt))
                        else
                            api_sp(menu_id, "tank_amount", api_gp(menu_id, "tank_amount") + util_tank_drain(menu_id, nearby_menu_id, DRAIN_SPEED))
                        end
                    end
                end
            end
        end
    end
end