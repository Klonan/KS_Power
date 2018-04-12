 data:extend({
  {
    type = "item",
    name = "OilSteamBoiler",
    icon = "__KS_Power__/graphics/icons/OilSteamBoiler.png",
    icon_size = 32,
    flags = {"goes-to-quickbar"},
    subgroup = "production-machine",
    order = "f[OilSteamBoiler]",
    place_result = "OilSteamBoiler",
    stack_size = 10
  },
  {
    type = "recipe",
    name = "OilSteamBoiler",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {"copper-plate", 16},
      {"steel-plate", 12},
      {"pipe", 10},
      {"concrete", 6},
    },
    result = "OilSteamBoiler"
  },
  {
    type = "assembling-machine",
    name = "OilSteamBoiler",
    icon = "__KS_Power__/graphics/icons/OilSteamBoiler.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "OilSteamBoiler"},
    max_health = 200,
    corpse = "big-remnants",
    dying_explosion = "big-explosion",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    module_specification =
    {
      module_slots = 2
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    animation =
    {
      south =
      {
        priority = "extra-high",
        width = 256,
        height = 220,
        line_length = 8,
        shift = {0.5, 0},
        filename = "__KS_Power__/graphics/ob_s_sheet.png",
        frame_count = 8,
        animation_speed = 0.4,
        scale = 0.5,
        run_mode = "forward-then-backward",
        },
        north =
        {
          priority = "extra-high",
          width = 256,
          height = 223,
          line_length = 8,
          shift = {0.5, 0},
          filename = "__KS_Power__/graphics/ob_n_sheet.png",
          frame_count = 8,
          animation_speed = 0.4,
          scale = 0.5,
          run_mode = "forward-then-backward",
          },
          east =
          {
            priority = "extra-high",
            width = 256,
            height = 175,
            line_length = 8,
            shift = {0.45, 0},
            filename = "__KS_Power__/graphics/ob_w_sheet.png",
            frame_count = 8,
            animation_speed = 0.4,
            scale = 0.5,
            run_mode = "forward-then-backward",
            },
            west =
            {
              priority = "extra-high",
              width = 256,
              height = 173,
              line_length = 8,
              shift = {0.45, 0},
              filename = "__KS_Power__/graphics/ob_e_sheet.png",
              frame_count = 8,
              animation_speed = 0.4,
              scale = 0.5,
              run_mode = "forward-then-backward",
              }
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

            crafting_speed = 1,
            energy_source =
            {
              type = "electric",
              usage_priority = "primary-input",
              emissions = 4/1000,
            },
            energy_usage = "30kW",
            ingredient_count = 3,
            crafting_categories = {"OilBurn"},

            fluid_boxes =
            {
              {
                production_type = "input",
                base_area = 1,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-1, -2} }}
              },
              {
                production_type = "input",
                base_area = 1,
                base_level = -1,
                pipe_connections = {{ type="input", position = {1, -2} }}
              },
              {
                production_type = "output",
                base_level = 1,
                pipe_connections = {{ position = {0, 2} }
              }
            },
          }
        },
        {type = "recipe-category", name = "OilBurn"},
        {
          type = "item-subgroup",
          name = "oil-burning",
          group = "intermediate-products",
          order = "a-z"
        },
      })