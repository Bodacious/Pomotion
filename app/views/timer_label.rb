class TimerLabel < UILabel
  
  def update_for_count(count)
    update_text_for_count(count)
    update_color_for_count(count)
  end
  
  
  private
  
  
  def update_text_for_count(count)
    mins = count / 60
    secs = count % 60
    self.text = "%02d:%02d" % [mins, secs]
  end
  
  def update_color_for_count(count)
    if count > 0
      proportion = count / Time.secsIn25Mins.to_f
      color = UIColor.new_from_two_colors(UIColor.pomo_red_color, UIColor.pomo_green_color, proportion)
    else
      color = UIColor.pomo_grey_color
    end
    self.color = color
  end
  
end