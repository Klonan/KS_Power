--require "util"
require "scripts.turbine"

script.on_event(defines.events.on_tick, function(event)
  local t = event.tick
  if (t % 24999) == 0 then
    change_wind_day()
  end
  if (t % 2499) == 0 then
    change_wind_hour()
  end
  if (t % 249) == 0 then
    tick_wind()
  end
  check_interfaces()
end)

function BuiltEntity(event)
  local entity = event.created_entity
	if entity.name == "wind-turbine-2" then
    return built_interface(entity)
	end
end


script.on_event(defines.events.on_built_entity, BuiltEntity)
script.on_event(defines.events.on_robot_built_entity, BuiltEntity)