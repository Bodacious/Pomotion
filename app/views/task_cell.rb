# A UITableViewCell that's displayed for a given Task.
class TaskCell < UITableViewCell
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'task_cell'
    end
  end
  
  # Configure this TaskCell for a given Task.
  #
  # task - The Task to configure this cell for.
  def configure_for_task(task)
    textLabel.text = task.name
  end

  # Prepare this TaskCell to be used again.
  def prepareForReuse
    super
    textLabel.text = ''
  end
  
end