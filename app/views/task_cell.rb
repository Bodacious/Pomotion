class TaskCell < UITableViewCell
  
  include ActsAsPomodoroParentView
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'task_cell'
    end
  end
  
  def configure_for_task(task)
    textLabel.text = task.name
    add_pomodoro_view(task.pomodoros.count)
  end
  
  def prepareForReuse
    super
    textLabel.text = ''
    pomodoro_subviews = contentView.subviews.select do |sub|
      sub.is_a?(PomodoroView)
    end
    pomodoro_subviews.each(&:removeFromSuperview)
  end 
  
end