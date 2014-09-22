class MainViewController < UIViewController

  attr_accessor :pomodoro_timer
  
  def loadView
    self.view = MainView.alloc.initWithFrame(CGRectZero)
  end

  def timer_label
    view.timer_label
  end
    
  def timer_button
    view.timer_button
  end
  
  def timer_button_tapped(sender)
    if pomodoro_timer && pomodoro_timer.valid?
      pomodoro_timer.invalidate      
    else
      start_new_pomodoro_timer
    end
  end
  
  def pomodoro_timer_did_start(pomodoro_timer)
    timer_button.selected = true
    update_timer_label    
  end
 
  def pomodoro_timer_did_invalidate(pomodoro_timer)
    timer_button.selected = false  
    update_timer_label    
  end
 
  def pomodoro_timer_did_decrement(pomodoro_timer)
    update_timer_label    
  end
 
  def pomodoro_timer_did_finish(pomodoro_timer)
    pomodoro_timer.invalidate
  end
  
  
  private
  
  
  def update_timer_label
    mins = pomodoro_timer.count / 60
    secs = pomodoro_timer.count % 60
    timer_label.text = "%02d:%02d" % [mins, secs]
  end
    
  def start_new_pomodoro_timer
    self.pomodoro_timer = PomodoroTimer.new
    pomodoro_timer.delegate = self
    pomodoro_timer.start
  end

end