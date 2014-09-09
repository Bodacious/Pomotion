class MainView < UIView
  
  include ActsAsPomodoroParentView
  
  TIMER_BUTTON_LABEL_NORMAL_TITLE = 'Start Timer'
  
  TIMER_BUTTON_LABEL_SELECTED_TITLE = "Interrupt!"  
  
  TASK_NAME_LABEL_DEFAULT_TEXT = 'n/a'

  
  def initWithFrame(frame)
    super.tap do
      self.styleId = 'main_view'
      addSubview(timer_label)
      addSubview(timer_button)
      addSubview(task_header_label)      
      addSubview(task_name_label)
    end
  end
  
  # ==============
  # = Properties =
  # ==============
  
  def timer_label
    @timer_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId   = 'timer_label'
      label.text      = '00:00'
      label.textColor = UIColor.pomo_grey_color
    end
  end
  
  def timer_button
    @timer_button ||= TimerButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.styleId = 'timer_button'
      button.setTitle(TIMER_BUTTON_LABEL_NORMAL_TITLE, forState: UIControlStateNormal)
      button.setTitle(TIMER_BUTTON_LABEL_SELECTED_TITLE, forState: UIControlStateSelected)
      button.addTarget(nextResponder, action: 'timer_button_tapped:', 
        forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def task_header_label
    @task_header_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'task_header_label'
      label.text = 'Current task:'
    end
  end  
  
  def task_name_label
    @task_name_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'task_name_label'
      label.text = TASK_NAME_LABEL_DEFAULT_TEXT
    end
  end
  
end