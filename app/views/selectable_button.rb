# A UIButton that changes background color when selected
class SelectableButton < UIButton
 
  # Set's selected property. When bool is true, sets backgroundColor to red, when false
  # sets it to green.
  #
  # bool - A boolean true or false
  def selected=(bool)
    super.tap do
      self.backgroundColor = bool ? UIColor.pomo_red_color : UIColor.pomo_green_color
    end
  end
  
end