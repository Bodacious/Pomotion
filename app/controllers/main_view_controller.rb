# The Main View Controller for this application
class MainViewController < UIViewController

  # A PomodoroTimer instance used to count down the current pomodoro session
  attr_accessor :pomodoro_timer
    
  def loadView
    self.view = MainView.alloc.initWithFrame(CGRectZero)
    self.title = "Pomotion"    
  end
  
  # A UIAlertView to alert the User when their Pomodoro session is complete
  def alert_view
    @alert_view ||= UIAlertView.alloc.initWithTitle("Pomodoro Complete!", 
      message: "Time to take a short break.", delegate: self, 
      cancelButtonTitle: "OK", otherButtonTitles: nil)
  end

  # A helper method to access view's timer_label
  def timer_label
    view.timer_label
  end
    
  # A helper method to access view's timer_button
  def timer_button
    view.timer_button
  end
  
  # Called when the timer button is tapped. If there's a valid PomodoroTimer running,
  # invalidate it. Otherwise start a new PomodoroTimer.
  # 
  # sender - The object that called this action
  def timer_button_tapped(sender)
    if pomodoro_timer && pomodoro_timer.valid?
      pomodoro_timer.invalidate      
    else
      start_new_pomodoro_timer
    end
  end
  
  # Called when the PomodoroTimer is started.
  # 
  # pomodoro_timer - The PomodoroTimer object that just started
  def pomodoro_timer_did_start(pomodoro_timer)
    timer_button.selected = true
    update_timer_label    
  end
 
  # Called when the PomodoroTimer is invalidated
  #
  # pomodoro_timer - The PomodoroTimer object that just invalidated
  def pomodoro_timer_did_invalidate(pomodoro_timer)
    timer_button.selected = false  
    update_timer_label    
  end

  # Called when the PomodoroTimer is decremented
  #
  # pomodoro_timer - The PomodoroTimer object that just decremented 
  def pomodoro_timer_did_decrement(pomodoro_timer)
    update_timer_label    
  end

  # Called when the PomodoroTimer is finished
  #
  # pomodoro_timer - The PomodoroTimer object that just finished  
  def pomodoro_timer_did_finish(pomodoro_timer)
    pomodoro_timer.invalidate
    alert_view.show    
  end
  
  
  private
  
  
  # Updates the timer_label with the current pomodoro_timer count.
  def update_timer_label
    timer_label.update_for_count(pomodoro_timer.count)
  end
    
  # Creates a new PomodoroTimer and starts it.
  def start_new_pomodoro_timer
    self.pomodoro_timer = PomodoroTimer.new
    pomodoro_timer.delegate = self
    pomodoro_timer.start
  end

end