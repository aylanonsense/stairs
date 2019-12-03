pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

local stair_y
local entities

function _init()
  stair_y = 147
  entities = {
    {
      stair = 7,
      segment = 1
    },
    {
      stair = 7,
      segment = 2
    },
    {
      stair = 7,
      segment = 3
    },
    {
      stair = 7,
      segment = 4
    },
    {
      stair = 7,
      segment = 5
    },
    { stair = 7,
      segment = 6
    }
  }
end

function _update()
  stair_y = stair_y + 1
  if stair_y >= 166 then
    stair_y = 127
    for entity in all(entities) do
      entity.stair = entity.stair - 1
    end
  end
end

function _draw()
  local stair_positions = {}
  cls()
  rect(0, 0, 127, 127, 3)
  local width, rise_left = calc_stair_size(stair_y)
  local bottom_width, bottom_y
  for y = flr(stair_y), 0, -1 do
    local segments = {}
    local width_2, rise_left_2 = calc_stair_size(y)
    if rise_left > 0 then
      rise_left = rise_left - 1
      if rise_left <= 0 then
        bottom_width = width
        bottom_y = y - 1
      end
    else
      width = width - 1
    end
    if width <= width_2 then
      width = width_2
      rise_left = rise_left_2
      if bottom_width and bottom_y then
        -- draw parts of stairs
        local top_y, top_width = y + 2, width - 1
        local top_left_x = 64 - top_width / 2 - 1
        local bottom_left_x = 64 - bottom_width / 2
        local top_right_x = 64 + top_width / 2 + 1
        local bottom_right_x = 64 + bottom_width / 2
        for p = 1 / 6, 5.5 / 6, 1 / 6 do
          line(top_left_x + (top_right_x - top_left_x) * p, top_y, bottom_left_x + (bottom_right_x - bottom_left_x) * p, bottom_y, 2)
          -- local gap = y > 90 and 2 or (y > 50 and 1 or 0)
          -- line(top_left_x + (top_right_x - top_left_x) * p - gap, top_y, bottom_left_x + (bottom_right_x - bottom_left_x) * p - gap, bottom_y, 2)
          -- line(top_left_x + (top_right_x - top_left_x) * p + gap, top_y, bottom_left_x + (bottom_right_x - bottom_left_x) * p + gap, bottom_y, 2)
        end
        -- record stair positions
        local middle_y = (top_y + bottom_y) / 2
        local middle_left_x = (top_left_x + bottom_left_x) / 2
        local middle_right_x = (top_right_x + bottom_right_x) / 2
        for p = 1 / 12, 5.5 / 6, 1 / 6 do
          add(segments, {
            x = middle_left_x + (middle_right_x - middle_left_x) * p,
            y = middle_y
          })
        end
        add(stair_positions, segments)
        bottom_width = nil
        bottom_y = nil
      end
    end
    if rise_left > 0 then
      pset(64 - width / 2, y, 2)
      pset(64 + width / 2 - 0.5, y, 2)
      if rise_left <= 2 then
        line(64 - width / 2, y, 64 + width / 2 - 0.5, y, 2)
      end
    else
      line(64 - width / 2, y, 64 + width / 2 - 0.5, y, 4)
    end
  end
  -- draw entities
  for entity in all(entities) do
    if stair_positions[entity.stair] then
      local position = stair_positions[entity.stair][entity.segment]
      local x, y = position.x, position.y
      spr(1, x - 3.5, y - 7.5)
      pset(x, y, 8)
    end
  end
end

function calc_stair_size(y)
  return flr((60 + 60 * y / 127) / 2) * 2, flr(6 + y / 10)
end

__gfx__
00000000cbbbbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cbbbbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700cbbbbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000cbb77bb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000cbb77bb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700cbbbbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cbbbbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cbbbbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
