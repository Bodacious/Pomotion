class Pomodoro < CDQManagedObject
  
  TODAY = lambda { Time.new(Time.now.year, Time.now.month, Time.now.day, 0,0,0) }
  
  scope :today, where(:started_at).gt(TODAY.call)
  
  def self.finish_current_and_reset
    current.finish
    self.current = nil  
  end
  
  def self.current=(pomodoro)
    @current = pomodoro
  end
  
  def self.current
    @current
  end
  
  def complete?
    return false unless finished_at
    (finished_at - started_at) >= Time.secsIn25Mins
  end

  def incomplete?
    !complete?
  end
  
  def finish
    self.finished_at = Time.now
    cdq.save
  end
  
  
end