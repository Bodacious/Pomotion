class Task < CDQManagedObject
  
  scope :is_current, where(:current).eq(true)
  
  def self.current=(task)
    self.current.current = false if self.current
    task.current = true    
    cdq.save
    @current = task
  end
  
  def self.current
    @current ||= is_current.first
  end
  
  def self.reset_current
    @current = nil
  end
  
  def complete_pomodoros
    pomodoros.select(&:complete?)
  end
  
end