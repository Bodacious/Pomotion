class TasksViewController < UITableViewController
  
  def viewDidLoad
    super
    self.title = "Tasks"    
    tableView.registerClass(EmptyCell, forCellReuseIdentifier: EmptyCell.name)
    tableView.registerClass(TaskCell, forCellReuseIdentifier: TaskCell.name)
    navigationItem.rightBarButtonItem = add_button    
  end
  
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
  
  def add_button_tapped(sender)
    task_alert_view.show
  end
  
  # = UITableViewDelegate =
 
  def tableView(table_view, heightForRowAtIndexPath: index_path)
    todays_tasks.any? ? 75.0 : tableView.frame.size.height
  end
 
  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    Task.current = Task.all[index_path.row]
    navigationController.popViewControllerAnimated(true)
  end
  
  def tableView(table_view, canEditRowAtIndexPath: index_path)
    true
  end  
 
  def tableView(table_view, commitEditingStyle:editing_style, forRowAtIndexPath: index_path)
    case editing_style
    when UITableViewCellEditingStyleDelete
      delete_task_at_index(index_path.row)
      if todays_tasks.any?
        tableView.deleteRowsAtIndexPaths([index_path], 
          withRowAnimation: UITableViewRowAnimationFade)
      else
        tableView.reloadRowsAtIndexPaths([index_path], 
          withRowAnimation: UITableViewRowAnimationFade)      
      end
    end
  end
  
  # = UITableViewDataSource =
 
  def tableView(table_view, cellForRowAtIndexPath: index_path)
    if todays_tasks.any?
      task = todays_tasks[index_path.row]
      table_view.dequeueReusableCellWithIdentifier(TaskCell.name).tap do |cell|
        cell.configure_for_task(task)
      end
    else
      table_view.dequeueReusableCellWithIdentifier(EmptyCell.name)
    end
  end
  
  def tableView(table_view, numberOfRowsInSection: section)
    [1, todays_tasks.count].max
  end
 
 
  # = UIAlertViewDelegate =
  
  def alertView(alert_view, clickedButtonAtIndex: index_path)
    text_field = alert_view.textFieldAtIndex(0)
    if !text_field.text.to_s.empty?
      create_new_task(name: text_field.text)
      tableView.reloadData      
      text_field.text = ''
    end
  end
  
 
  private
 
 
  def create_new_task(attributes)
    Task.create(attributes)
    Task.save
  end
 
  def todays_tasks
    Task.all
  end
  
  def delete_task_at_index(index)
    task = todays_tasks[index]
    task.destroy
    Task.save
    Task.reset_current
  end
  
end