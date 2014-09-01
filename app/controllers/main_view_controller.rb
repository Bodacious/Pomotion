class MainViewController < UIViewController
  
  attr_accessor :pomodoro_timer
  
  
  def loadView
    self.title = "Pomotion"
    self.view = MainView.alloc.initWithFrame(CGRectZero)
  end
  
  # ==============
  # = Properties =
  # ==============
  
  def timer_label
    view.timer_label
  end
  
  
  # ===========
  # = Actions =
  # ===========
  
  def timer_button_tapped(sender)
    if pomodoro_timer && pomodoro_timer.valid?
      pomodoro_timer.invalidate      
    else
      start_new_pomodoro_timer
    end
  end
  
  # =========================
  # = PomodoroTimerDelegate =
  # =========================  
  
  def pomodoro_timer_did_start(pomodoro_timer)
    NSLog("pomodoro_timer_did_start")
  end
    
  def pomodoro_timer_did_invalidate(pomodoro_timer)
    NSLog("pomodoro_timer_did_invalidate")
  end
  
  def pomodoro_timer_did_decrement(pomodoro_timer)
    timer_label.text = TimerTextValue.new(pomodoro_timer.count).to_s
  end

  def pomodoro_timer_did_finish(pomodoro_timer)
    NSLog("pomodoro_timer_did_finish")    
  end
  
  
  private
  
    
  def start_new_pomodoro_timer
    self.pomodoro_timer = PomodoroTimer.new
    pomodoro_timer.delegate = self
    pomodoro_timer.start
  end
end