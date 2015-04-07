# The Main View Controller for this application
class MainViewController < UIViewController

  # A PomodoroTimer instance used to count down the current pomodoro session
  attr_accessor :pomodoro_timer
    
  # Load an instance of MainView for this ViewController
  def loadView
    self.view = MainView.alloc.initWithFrame(CGRectZero)
  end
  
  # Callback called once the view has finished loading.
  def viewDidLoad
    super
    self.title = "Pomotion" 
    self.navigationItem.rightBarButtonItem = tasks_button   
  end
  
  # Callback called once the view has appeared.
  #
  # animated - A boolean value that indicates whether the view was added to the window
  #            using an animation.
  def viewDidAppear(animated)
    super
    set_task_name_label_from_current_task
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
  
  # Navigation bar button with todo list icon. Calls tasks_button_tapped: when tapped.
  def tasks_button
    @tasks_button ||= UIBarButtonItem.alloc.initWithImage(tasks_image, 
      style: UIBarButtonItemStylePlain, target: self, action: 'tasks_button_tapped:')
  end

  # Returns an instance of UIImage with image in resources/todo.png
  def tasks_image
    @tasks_image ||= UIImage.imageNamed('todo.png')
  end
  
  # A UILabel in the MainView that displays the name of the current Task.
  def task_name_label
    view.task_name_label
  end
  
  # Called when the timer button is tapped. If there's a valid PomodoroTimer running,
  # invalidate it. Otherwise start a new PomodoroTimer.
  # 
  # sender - The UIControl object that called this action
  def timer_button_tapped(sender)
    if pomodoro_timer && pomodoro_timer.valid?
      pomodoro_timer.invalidate      
    else
      start_new_pomodoro_timer
    end
  end
  
  # Action called when the tasks_button is tapped. Creates a new instance of 
  # TasksViewController and pushes it on the navigation controller.
  #
  # sender - The UIControl object that called this action.
  def tasks_button_tapped(sender)
    tasks_controller = TasksViewController.alloc.initWithNibName(nil, bundle: nil)
    navigationController.pushViewController(tasks_controller, animated: true)  
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
  
  # Sets the value of the task_name_label's text property. If there's a current Task,
  # sets it to the name of the Task, otherwise sets it to a placeholder String.
  def set_task_name_label_from_current_task
    if Task.current
      task_name_label_text = Task.current.name
    else
      task_name_label_text = "n/a"
    end
    task_name_label.text = task_name_label_text
  end

end