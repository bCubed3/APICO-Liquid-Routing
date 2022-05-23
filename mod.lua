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

function clock()
  new_list = {}
  for i=1,#PIPES do
    if (api_inst_exists(PIPES[i])) then
      pipes_process(PIPES[i])
      table.insert(new_list, PIPES[i])
    end
  end
  PIPES = new_list
end