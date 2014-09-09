class TasksViewController < UITableViewController
  
  # ==================
  # = View Lifecycle =
  # ==================
  
  def viewDidLoad
    super
    self.title = "Tasks"
    tableView.registerClass(EmptyCell, forCellReuseIdentifier: EmptyCell.name)
    navigationItem.rightBarButtonItem = add_button
  end
  
  # ==============
  # = Properties =
  # ==============
  
  def add_button
    @add_button ||= UIBarButtonItem.alloc.
      initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, 
      action: 'add_button_tapped:')
  end
  
  def task_alert_view
    @task_alert_view ||= UIAlertView.alloc.initWithTitle("Add A Task", 
      message: "Insert the name of the task below",
      delegate: self, cancelButtonTitle: "Add", otherButtonTitles: nil).tap do |alert|
        alert.alertViewStyle = UIAlertViewStylePlainTextInput
    end
  end
 
  
  # ===========
  # = Actions =
  # ===========
  
  def add_button_tapped(sender)
    task_alert_view.show
  end
  
  def alertView(alert_view, clickedButtonAtIndex: index_path)
    text_field = alert_view.textFieldAtIndex(0)
    if !text_field.text.to_s.empty?
      NSLog("Saving new Task: #{text_field.text}")  
      create_new_task(name: text_field.text)
      tableView.reloadData      
      text_field.text = ''
    else
      NSLog("Not saving Task as text label was empty.")
    end
  end
  
  
  # =======================
  # = UITableViewDelegate =
  # =======================
  
  def tableView(table_view, heightForRowAtIndexPath: index_path)
    tasks_list_empty? ? tableView.frame.size.height : 75.0
  end
  
  # =========================
  # = UITableViewDataSource =
  # =========================
  
  def tableView(table_view, cellForRowAtIndexPath: index_path)
    if tasks_list_empty?
      table_view.dequeueReusableCellWithIdentifier(EmptyCell.name)
    else
      UITableViewCell.alloc.init
    end
  end
  
  def tableView(table_view, numberOfRowsInSection: section)
    tasks_list_empty? ? 1 : Task.count
  end
  
  def numberOfSectionsInTableView(table_view)
    1
  end
  
  
  private
  
  def tasks_list_empty?
    !Task.any?
  end
  
  def create_new_task(attributes)
    Task.create(attributes) 
    cdq.save
  end
  
end