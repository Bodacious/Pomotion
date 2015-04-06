class Task < CDQManagedObject
 
  def self.current=(task)
    self.current.current = false if self.current
    task.current = true    
    self.save
    @current = task
  end
 
  def self.current
    @current ||= where(current: true).first
  end
 
  def self.reset_current
    @current = nil
  end
  
end