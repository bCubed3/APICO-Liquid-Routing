function util_define_all()
    if (util_define_extractor() == "Success" and util_define_entangled_canister() == "Success") then return "Success" end
    return nil
end

function util_define_extractor()
    -- define the pipe object
    local  define_pipe_obj = api_define_menu_object({
        id = "extractor",
        name = "Liquid Extractor",
        category = "Tools",
        tooltip = "Extracts liquid from nearby containers into its internal tank.",
        shop_key = false,
        shop_buy = 0,
        shop_sell = 0,
        layout = {
        {19,29, "Fluid"}
        },
        buttons = {"Help", "Target", "Close"},
        info = {},
        tools = {"mouse1", "hammer1"},
        placeable = true
    }, "sprites/pipe.png", "sprites/pipe_ui.png", {
        define = "pipe_define"
    })

    recipe = {
        { item = "planks1", amount = 2}
    }
    define_recipe = api_define_recipe("crafting", MOD_NAME .. "_extractor", recipe, 1)
    if (define_pipe_obj == "Success" and define_recipe == "Success") then return "Success" end
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