class TimerTextValue
  
  attr_reader :mins
  
  attr_reader :secs
  
  def initialize(timer_count)
    timer_count = timer_count.to_i
    @mins = timer_count / 60
    @secs = timer_count % 60
  end
  
  def to_s
    "%02d:%02d" % [mins, secs]
  end
  
end