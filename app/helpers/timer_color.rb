class TimerColor
  
  attr_reader :timer_count
  
  def initialize(timer_count)
    @timer_count = timer_count.to_i
  end
  
  def color
    if timer_count > 0
      UIColor.new_from_two_colors(UIColor.pomo_red_color, UIColor.pomo_green_color, 
        proportion)
    else
      UIColor.pomo_grey_color
    end    
  end  
  
  def proportion
    Rational(timer_count, Time.secsIn25Mins).to_f.round(2)
  end
  
end