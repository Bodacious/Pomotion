class UIColor
 
  def self.pomo_grey_color
    @pomo_grey_color ||= UIColor.colorWithRed(0.5, green: 0.5, blue: 0.5, alpha: 1.0)
  end
 
  def self.pomo_green_color
    @pomo_green_color ||= UIColor.colorWithRed(0.0, green: 0.666, blue: 0.0, alpha: 1.0)
  end
 
  def self.pomo_red_color
    @pomo_red_color ||= UIColor.colorWithRed(0.666, green: 0.0, blue: 0.0, alpha: 1.0)
  end
  
  def self.new_from_two_colors(color_1, color_2, proportion)
    color_1_r = Pointer.new(:float)
    color_1_g = Pointer.new(:float)
    color_1_b = Pointer.new(:float)
    color_1_a = Pointer.new(:float)
    color_1.getRed(color_1_r, green: color_1_g, blue: color_1_b, alpha: color_1_a)
 
    color_2_r = Pointer.new(:float)
    color_2_g = Pointer.new(:float)
    color_2_b = Pointer.new(:float)
    color_2_a = Pointer.new(:float)
    color_2.getRed(color_2_r, green: color_2_g, blue: color_2_b, alpha: color_2_a)
 
    new_red   = color_1_r.value + (color_2_r.value - color_1_r.value) * proportion
    new_green = color_1_g.value + (color_2_g.value - color_1_g.value) * proportion
    new_blue  = color_1_b.value + (color_2_b.value - color_1_b.value) * proportion
    new_alpha = color_1_a.value + (color_2_a.value - color_1_a.value) * proportion
 
    UIColor.colorWithRed(new_red, green: new_green, blue: new_blue, alpha: new_alpha)
  end
 
end
