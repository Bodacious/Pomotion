class TimerColor < Struct.new(:timer_count)
    
  def color
    return UIColor.pomo_grey_color unless timer_count > 0
    UIColor.new_from_two_colors(UIColor.pomo_red_color, UIColor.pomo_green_color, 
      proportion)
  end  
  

  private

  
  def proportion
    Rational(timer_count, Time.secsIn25Mins).to_f.round(2)
  end
  
end