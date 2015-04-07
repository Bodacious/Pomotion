class Task < CDQManagedObject
 
  # Set the current Task to work on
  def self.current=(task)
    self.current.current = false if self.current
    task.current = true    
    self.save
    @current = task
  end

  # The current Task to work on 
  def self.current
    @current ||= where(current: true).first
  end
 
  # Reset the current Task to nil
  def self.reset_current
    @current = nil
  end
  
end