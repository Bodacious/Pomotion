class MainViewController < UIViewController
  
  attr_accessor :pomodoro_timer
  
  
  def loadView
    self.view = MainView.alloc.initWithFrame(CGRectZero)
  end
  
  def viewDidLoad
    super
    self.title = "Pomotion"
    self.navigationItem.rightBarButtonItem = tasks_button
    
    Pomodoro.today.each do |pomodoro|
      view.add_pomodoro_view if pomodoro.complete?
    end
  end
  
  def viewDidAppear(animated)
    super
    set_task_name_label_from_current_task
  end
  
  # ==============
  # = Properties =
  # ==============
  
  def task_name_label
    view.task_name_label
  end
  
  def timer_label
    view.timer_label
  end
  
  def timer_button
    view.timer_button
  end
  
  def tasks_button
    @tasks_button ||= UIBarButtonItem.alloc.initWithImage(tasks_image, 
      style: UIBarButtonItemStylePlain, target: self, action: 'tasks_button_tapped:')
  end
  
  def tasks_image
    @tasks_image ||= UIImage.imageNamed('todo.png')
  end
  
    
  def alert_view
    @alert_view ||= UIAlertView.alloc.initWithTitle("Pomodoro Complete!", 
      message: "Time to take a short break.", delegate: self, 
      cancelButtonTitle: "OK", otherButtonTitles: nil)
  end
  
  # ===========
  # = Actions =
  # ===========
  
  def tasks_button_tapped(sender)
    tasks_controller = TasksViewController.alloc.initWithNibName(nil, bundle: nil)
    navigationController.pushViewController(tasks_controller, animated: true)  
  end
  
  def timer_button_tapped(sender)
    if pomodoro_timer && pomodoro_timer.valid?
      pomodoro_timer.invalidate      
    else
      create_new_pomodoro
      start_new_pomodoro_timer
    end
  end
  
  # =======================
  # = UIAlertViewDelegate =
  # =======================
  
  def alertView(alertView, didDismissWithButtonIndex: button_index)
    view.add_pomodoro_view
    timer_button.selected = false    
  end
  
  # =========================
  # = PomodoroTimerDelegate =
  # =========================  
  
  def pomodoro_timer_did_start(pomodoro_timer)
    update_timer_label
    timer_button.selected = true
  end
    
  def pomodoro_timer_did_invalidate(pomodoro_timer)
    update_timer_label
    timer_button.selected = false
    Pomodoro.finish_current_and_reset
  end
  
  def pomodoro_timer_did_decrement(pomodoro_timer)
    update_timer_label
  end

  def pomodoro_timer_did_finish(pomodoro_timer)
    view.add_pomodoro_view
    pomodoro_timer.invalidate
    alert_view.show       
  end
  
  
  private
  
  
  def create_new_pomodoro
    Pomodoro.current = Pomodoro.create(started_at: Time.now, task: Task.current)
    cdq.save
  end
  
  def update_timer_label
    timer_label.textColor = TimerColor.new(pomodoro_timer.count).color
    timer_label.text      = TimerTextValue.new(pomodoro_timer.count).to_s
  end
  
  def start_new_pomodoro_timer
    self.pomodoro_timer = PomodoroTimer.new
    pomodoro_timer.delegate = self
    pomodoro_timer.start
  end
  
  def set_task_name_label_from_current_task
    if Task.current
      task_name_label_text = Task.current.name
    else
      task_name_label_text = MainView::TASK_NAME_LABEL_DEFAULT_TEXT
    end
    task_name_label.text = task_name_label_text
  end

  
end