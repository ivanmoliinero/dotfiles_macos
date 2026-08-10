local padding <const> = {
  background = 2,
  icon = 10,
  label = 8,
  bar = 30,
  left = 0,
  right = 0,
  item = 2,
  popup = 10,
}

local graphics <const> = {
  bar = {
    height = 36,
    offset = 9,
  },
  background = {
    height = 24,
    corner_radius = 9,
  },
  slider = {
    height = 20,
  },
  popup = {
    width = 200,
    large_width = 300,
  },
  blur_radius = 30,
}

local text <const> = {
  icon = 16.0,
  label = 14.0,
}

return {
  padding = padding,
  graphics = graphics,
  text = text,
}
