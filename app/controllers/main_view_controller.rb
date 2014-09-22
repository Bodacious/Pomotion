class MainViewController < UIViewController

  attr_accessor :pomodoro_timer
  
  def loadView
    self.view = MainView.alloc.initWithFrame(CGRectZero)
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
    NSLog("pomodoro_timer_did_start")
    timer_button.selected = true
  end
 
  def pomodoro_timer_did_invalidate(pomodoro_timer)
    NSLog("pomodoro_timer_did_invalidate")
    timer_button.selected = false  
  end
 
  def pomodoro_timer_did_decrement(pomodoro_timer)
    NSLog("pomodoro_timer_did_decrement")
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