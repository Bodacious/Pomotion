class TimerButton < UIButton
  
  def setSelected(bool)
    super.tap do
      self.backgroundColor = bool ? UIColor.pomo_red_color : UIColor.pomo_green_color
    end
  end
  
end