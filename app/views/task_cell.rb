class TaskCell < UITableViewCell
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'task_cell'
    end
  end
  
  def configure_for_task(task)
    textLabel.text = task.name
  end
  
  def prepareForReuse
    super
    textLabel.text = ''
  end
  
  
end