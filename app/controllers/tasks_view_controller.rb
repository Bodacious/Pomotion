class TasksViewController < UITableViewController
  
  def viewDidLoad
    super
    self.title = "Tasks"    
    tableView.registerClass(EmptyCell, forCellReuseIdentifier: EmptyCell.name)
    navigationItem.rightBarButtonItem = add_button    
  end
  
  def add_button
    @add_button ||= UIBarButtonItem.alloc.
    initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, action: nil)
  end
 
  # = UITableViewDelegate =
 
  def tableView(table_view, heightForRowAtIndexPath: index_path)
    todays_tasks.any? ? 75.0 : tableView.frame.size.height
  end
 
  # = UITableViewDataSource =
 
  def tableView(table_view, cellForRowAtIndexPath: index_path)
    table_view.dequeueReusableCellWithIdentifier(EmptyCell.name)
  end
 
  def tableView(table_view, numberOfRowsInSection: section)
    [1, todays_tasks.count].max
  end
 
  private
 
  def todays_tasks
    Task.all
  end
  
end