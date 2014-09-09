class TasksViewController < UITableViewController
  
  # ==================
  # = View Lifecycle =
  # ==================
  
  def viewDidLoad
    super
    self.title = "Tasks"
    tableView.registerClass(EmptyCell, forCellReuseIdentifier: EmptyCell.name)
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
  
end