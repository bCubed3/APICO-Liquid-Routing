function extractor_define(menu_id)
    coord = {
        x = api_gp(menu_id, "obj_x"),
        y = api_gp(menu_id, "obj_y")
      }
    api_dp(menu_id, "coord", coord)
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
    api_log(in_slot)
end

function extractor_draw(menu_id)
    api_draw_tank(api_gp(menu_id, "tank_gui"))
end