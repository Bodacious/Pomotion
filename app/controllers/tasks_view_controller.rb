# A UITableView controller for the adding, removing and selecting of Tasks.
class TasksViewController < UITableViewController
  
  # Callback called once the view has finished loading.
  def viewDidLoad
    super
    self.title = "Tasks"    
    tableView.registerClass(EmptyCell, forCellReuseIdentifier: EmptyCell.name)
    tableView.registerClass(TaskCell, forCellReuseIdentifier: TaskCell.name)
    navigationItem.rightBarButtonItem = add_button    
  end
  
  # A navigation bar button with plus icon. Calls add_button_tapped: when tapped.
  def add_button
    @add_button ||= UIBarButtonItem.alloc.
    initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, 
      action: 'add_button_tapped:')
  end

  # A UIAlertView that allows the User to add a new task to the database.
  def task_alert_view
    @task_alert_view ||= UIAlertView.alloc.initWithTitle("Add A Task", 
      message: "Insert the name of the task below",
      delegate: self, cancelButtonTitle: "Add", otherButtonTitles: nil).tap do |alert|
        alert.alertViewStyle = UIAlertViewStylePlainTextInput
    end
  end
  
  # An action called when the add_button is tapped.
  #
  # sender - The UIControl object that called this action.
  def add_button_tapped(sender)
    task_alert_view.show
  end
  
  # = UITableViewDelegate =
 
  # The height for a table_view's row at a given index path.
  #
  # table_view - The given UITableView to return row height for
  # index_path - An NSIndexPath object with the row's section and index
  def tableView(table_view, heightForRowAtIndexPath: index_path)
    todays_tasks.any? ? 75.0 : tableView.frame.size.height
  end
 
  # A delegate method called when a row of the tableView is selected
  #
  # table_view - The given UITableView
  # index_path - An NSIndexPath object with the row's section and index
  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    Task.current = Task.all[index_path.row]
    navigationController.popViewControllerAnimated(true)
  end
  
  # = UITableViewDataSource =

  # A UITableViewDataSource method that defines whether or not a user may edit 
  # a given row in a given UITableView.
  #
  # table_view - The given UITableView
  # index_path - An NSIndexPath object with the given row's section and index 
  #
  # Returns true
  def tableView(table_view, canEditRowAtIndexPath: index_path)
    true
  end  
  

  # A UITableViewDataSource method that's called when a user attempts to edit a given
  # row of a given UITableView.
  #
  # table_view    - The given UITableView
  # editing_style - A UITableViewCellEditingStyle value
  # index_path    - An NSIndexPath object with the given row's section and index
  def tableView(table_view, commitEditingStyle:editing_style, 
      forRowAtIndexPath: index_path)
      
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
  
 
  # A UITableViewDataSource method that returns an instance of UITableViewCell for a
  # given row of a given UITableView
  #
  # table_view    - The given UITableView
  # index_path    - An NSIndexPath object with the given row's section and index
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
  
  # A UITableViewDataSource method that returns the number of rows in a given UITableView
  # section.
  #
  # table_view - The given UITableView
  # section    - The index of the UITableView's section
  def tableView(table_view, numberOfRowsInSection: section)
    [1, todays_tasks.count].max
  end
 
 
  # = UIAlertViewDelegate =
  
  # A UIAlertViewDelegate method that's called when a user taps a button within a given
  # UIAlertView.
  #
  # alert_view - The given UIAlertView
  # index_path - An NSIndexPath object with the index of the tapped button
  def alertView(alert_view, clickedButtonAtIndex: index_path)
    text_field = alert_view.textFieldAtIndex(0)
    if !text_field.text.to_s.empty?
      create_new_task(name: text_field.text)
      tableView.reloadData      
      text_field.text = ''
    end
  end
  
 
  private
 
 
  # Create a new Task and save it to the database
  def create_new_task(attributes)
    Task.create(attributes)
    Task.save
  end
 
  # The complete list of Tasks from the database
  #
  # Returns a CDQ::CDQTargetedQuery
  def todays_tasks
    Task.all
  end
  
  # Deletes the Task in todays_tasks at a given index and commits the change
  # in the database.
  #
  # index - The index for the Task to delete
  def delete_task_at_index(index)
    task = todays_tasks[index]
    task.destroy
    Task.save
    Task.reset_current
  end
  
end