MOD_NAME = "liquid_routing"

EXTRACTORS = {}

function register()
  return {
    name = MOD_NAME,
    hooks = {"draw"},
    modules = {"utils", "extractor"}
  }
end

function init()
  api_set_devmode(true)
  api_create_log("init", "pipes mod loaded !")
  return util_define_all()
end

function draw() 
  extractor = api_get_highlighted("menu_obj")
  if (extractor ~= nil and api_gp(extractor, "oid") == MOD_NAME .. "_extractor") then
    cam = api_get_camera_position()
    ox = api_gp(extractor, "x") - cam["x"]
    oy = api_gp(extractor, "y") - cam["y"]
    api_draw_circle(ox+8, oy+8, 64, "OUTLINE", true)
  end
end