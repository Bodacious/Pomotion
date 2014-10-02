# A UILabel with additional behaviour for showing the pomodoro count, formatted & in color
class TimerLabel < UILabel
  
  # Update the current TimerLabel for the given pomodoro count
  #
  # count - An Integer representing the number of seconds left in this pomodoro
  def update_for_count(count)
    update_text_for_count(count)
    update_color_for_count(count)
  end
  
  
  private
  
  
  # Updates the labels's text to show the number of seconds in format: "00:13".
  #
  # count - An Integer representing the number of seconds left in this pomodoro
  def update_text_for_count(count)
    mins = count / 60
    secs = count % 60
    self.text = "%02d:%02d" % [mins, secs]
  end
  
  # Update's the label's text color. Will merge red and green proportionally if count
  # is greater than 0. Otherwise sets the text to grey.
  #
  # count - An Integer representing the number of seconds left in this pomodoro
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