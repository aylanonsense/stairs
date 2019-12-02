pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

local starting_y

function _init()
  starting_y = 147
end

function _update()
  starting_y = starting_y + 0.25
  if starting_y >= 166 then
    starting_y = 127
  end
end

function _draw()
  cls()
  rect(0, 0, 127, 127, 3)
  local width, rise_left = calc_stair_size(starting_y)
  local bottom_width, bottom_y
  for y = flr(starting_y), 15, -1 do
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
        end
        bottom_width = nil
        bottom_y = nil
      end
    end
    if rise_left > 0 then
      pset(64 - width / 2, y, 2)
      pset(64 + width / 2 - 0.5, y, 2)
      if rise_left == 1 then
        line(64 - width / 2, y, 64 + width / 2 - 0.5, y, 2)
      end
    else
      line(64 - width / 2, y, 64 + width / 2 - 0.5, y, 4)
    end
  end
end

function calc_stair_size(y)
  return flr((60 + 60 * y / 127) / 2) * 2, flr(6 + y / 10)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
