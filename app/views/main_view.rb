# The main view class used in MainViewController
class MainView < UIView

  # Overrides UIView#initWithFrame - sets a styleId and adds subviews.
  def initWithFrame(frame)
    super.tap do 
      self.styleId = 'main_view'
      addSubview(timer_label)
      addSubview(timer_button)
    end
  end
    
  # A TimerLabel used to show the current timer count on the screen
  def timer_label
    @timer_label ||= TimerLabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'timer_label'
      label.text    = '00:00'
    end
  end
  
  # A SelectableButton used to start and stop the count down
  def timer_button
    @timer_button ||= SelectableButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.styleId = 'timer_button'
      button.setTitle('Start Timer', forState: UIControlStateNormal)
      button.setTitle("Interrupt!" , forState: UIControlStateSelected)
      button.addTarget(nextResponder, action: 'timer_button_tapped:', forControlEvents: UIControlEventTouchUpInside)
    end
  end
 
end