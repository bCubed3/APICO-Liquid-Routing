function util_define_all()
    if (util_define_extractor() == "Success" and util_define_entangled_canister() == "Success") then return "Success" end
    return nil
end

function util_define_extractor()
    -- define the extractor object
    local  define_obj = api_define_menu_object({
        id = "extractor",
        name = "Liquid Extractor",
        category = "Tools",
        tooltip = "Extracts liquid from nearby containers into its internal tank.",
        shop_key = false,
        shop_buy = 0,
        shop_sell = 0,
        layout = {
            {7, 43, "Liquid Input", {"canister1", "canister2"}},
            {30, 43, "Liquid Output", {"canister1", "canister2"}},
            --{7, 17, "LiquidX"},
            --{30, 17, "Liquid"},
            {7, 69},
            {30, 69}
        },
        buttons = {"Help", "Move", "Target", "Close"},
        info = {},
        tools = {"mouse1", "hammer1"},
        placeable = true
    }, "sprites/pipe_controller.png", "sprites/extractor_gui.png", {
        define = "extractor_define",
        draw = "extractor_draw",
        change = "extractor_change"
    })

    recipe = {
        { item = "planks1", amount = 2}
    }
    define_recipe = api_define_recipe("crafting", MOD_NAME .. "_extractor", recipe, 1)
    if (define_obj == "Success" and define_recipe == "Success") then return "Success" end
    return nil
end

function util_define_entangled_canister()
    -- define the extract pipe object
    local define_obj = api_define_item({
        id = "entangled_canister",
        name = "Quantum Entangled Canister",
        category = "Tools",
        tooltip = "Extracts fluid from a container into the pipe system",
        shop_key = false,
        shop_buy = 0,
        shop_sell = 0,
        singular = false
    }, "sprites/pipe.png")

    recipe = {
        { item = "planks1", amount = 1}
    }
    define_recipe = api_define_recipe("tools", MOD_NAME .. "_entangled_canister", recipe, 2)
    if (define_obj == "Success" and define_recipe == "Success") then return "Success" end
    return nil
end

-- menu_id is the id of the extractor
-- source_id is the id of the source to be drained
-- tank is the id of the tank in the source
function util_tank_drain(menu_id, source_id, speed)
    source_level = api_gp(source_id, "tank_amount")
    api_log("util", source_level)
    if source_level < speed then
        api_sp(source_id, "tank_amount", 0)
        return source_level
    end
    api_sp(source_id, "tank_amount", source_level - speed)
    return speed
end