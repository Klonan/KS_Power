--require "util"
require "scripts.turbine"
require "scripts.burner-gen"

script.on_event(defines.events.on_tick, function(event)
  local t = event.tick
  if (t % 25000) == 0 then
    change_wind_day()
  end
  if (t % 2500) == 0 then
    change_wind_hour()
  end
  if (t % 249) == 0 then
    tick_wind()
  end
  check_interfaces()
  update_pots()
end)

function BuiltEntity(event)
  local entity = event.created_entity
	if entity.name == "wind-turbine-2" then	
    built_interface(entity)
    return
	end
	if entity.name == "burner-generator" then	
		on_built_burner_gen(entity)
    return
	end
end

function MinedEntity(event)
	if event.entity.name == "burner-generator" then
	local b = event.entity
	local X = b.position.x 
	local Y = b.position.y
		local power = {}		
		lid =	b.surface.find_entity("burner-generator-power",{X, Y})
		if lid ~= nil then
		lid.destroy()	end
	end
end

script.on_event(defines.events.on_built_entity, BuiltEntity)
script.on_event(defines.events.on_robot_built_entity, BuiltEntity)
script.on_event(defines.events.on_pre_player_mined_item , MinedEntity)
script.on_event(defines.events.on_entity_died , MinedEntity)
script.on_event(defines.events.on_robot_pre_mined  , MinedEntity)