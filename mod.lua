MOD_NAME = "liquid_routing"

function register()
  return {
    name = MOD_NAME,
    hooks = {"clock"},
    modules = {"utils"}
  }
end

function init()
  api_set_devmode(true)
  api_create_log("init", "pipes mod loaded !")
  return util_define_all()
end