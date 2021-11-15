local function makelayer_boiler(direction, layer)
  local type = "base"
  local frame_count = 1
  local line_length = 1
  local repeat_count = 8
  local draw_as_shadow = false
  local hshift = 0
  if layer == "shadow" then
    type = "base-shadow"
    draw_as_shadow = true
    hshift = 0.5
  elseif layer == "anim" then
    type = "anim"
    frame_count = 8
    line_length = 8
    repeat_count = 1
  end
  return {
    filename = "__KS_Power__/graphics/entity/oil-steam-boiler/oil-steam-boiler-" .. direction .. "-" .. type .. ".png",
    width = 128,
    height = 128,
    frame_count = frame_count,
    line_length = line_length,
    repeat_count = repeat_count,
    animation_speed = 0.4,
    shift = {hshift, 0},
    draw_as_shadow = draw_as_shadow,
    hr_version = {
      filename = "__KS_Power__/graphics/entity/oil-steam-boiler/hr-oil-steam-boiler-" .. direction .. "-" .. type .. ".png",
      width = 256,
      height = 256,
      frame_count = frame_count,
      line_length = line_length,
      repeat_count = repeat_count,
      animation_speed = 0.4,
      shift = {hshift, 0},
      scale = 0.5,
      draw_as_shadow = draw_as_shadow,
    }
  }
end


 data:extend({
  {
    type = "item",
    name = "oil-steam-boiler",
    icon = "__KS_Power__/graphics/icons/oil-steam-boiler-icon.png",
    icon_size = 64,
    flags = {},
    subgroup = "energy",
    order = "f[oil-steam-boiler]",
    place_result = "oil-steam-boiler",
    stack_size = 10
  },
  {
    type = "recipe",
    name = "oil-steam-boiler",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {"copper-plate", 16},
      {"steel-plate", 12},
      {"pipe", 10},
      {"concrete", 6},
    },
    result = "oil-steam-boiler"
  },
  {
    type = "boiler",
    name = "oil-steam-boiler",
    icon = "__KS_Power__/graphics/icons/oil-steam-boiler-icon.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "oil-steam-boiler"},
    max_health = 200,
    corpse = "big-remnants",
    dying_explosion = "big-explosion",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    mode = "output-to-separate-pipe",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    target_temperature = 165,
    fluid_box =
    {
      base_area = 1,
      height = 2,
      base_level = -1,
      pipe_covers = pipecoverspictures(),
      --pipe_picture = pipepictures(),
      pipe_connections = {{ type="input", position = {1, -2} }},
      production_type = "input",
      filter = "water",
    },
    output_fluid_box =
    {
      base_area = 1,
      height = 2,
      base_level = 1,
      pipe_covers = pipecoverspictures(),
      --pipe_picture = pipepictures(),
      pipe_connections =
      {
        {type = "output", position = {0, 2}}
      },
      production_type = "output",
      filter = "steam",
    },
    energy_consumption = "2.7MW",
    energy_source =
    {
      type = "fluid",
      emissions_per_minute = 20,
      burns_fluid = true,
      fluid_usage_per_tick = 0,
      scale_fluid_usage = true,
      fluid_box =
      {
        base_area = 1,
        height = 2,
        base_level = -1,
        pipe_covers = pipecoverspictures(),
        --pipe_picture = pipepictures(),
        pipe_connections = {{ type="input", position = {-1, -2} }},
        production_type = "input",
      },
    },
    working_sound =
    {
      sound =
      {
        filename = "__KS_Power__/sounds/oil-boiler-loop-2.ogg",
        volume = 0.35
      },
      idle_sound = { filename = "__KS_Power__/sounds/steam-offlet.ogg", volume = 0.35 },
      max_sounds_per_type = 2,
    },

    structure =
    {
      north = {
        layers = {
          makelayer_boiler("n"),
          makelayer_boiler("n", "shadow"),
          makelayer_boiler("n", "anim"),
        }
      },
      east = {
        layers = {
          makelayer_boiler("e"),
          makelayer_boiler("e", "shadow"),
          makelayer_boiler("e", "anim"),
        }
      },
      south = {
        layers = {
          makelayer_boiler("s"),
          makelayer_boiler("s", "shadow"),
          makelayer_boiler("s", "anim"),
        }
      },
      west = {
        layers = {
          makelayer_boiler("w"),
          makelayer_boiler("w", "shadow"),
          makelayer_boiler("w", "anim"),
        }
      },
    },
    fire = {},
    fire_glow = {},
    burning_cooldown = 20
  },
  {
    type = "technology",
    name = "OilBurning",
    icon = "__KS_Power__/graphics/technology/oil-boiler-technology.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "oil-steam-boiler"
      }
    },
    prerequisites = {"oil-processing","concrete"},
    unit = {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "f-b-c",
  }
})