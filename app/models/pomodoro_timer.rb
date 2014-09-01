class PomodoroTimer
  
  attr_accessor :count

  attr_reader :delegate
  
  attr_accessor :ns_timer

  def initialize(seconds = Time.secsIn25Mins)
    @count = seconds
  end
  
  def delegate=(object)
    @delegate = WeakRef.new(object)
  end
  
  def start
    invalidate if ns_timer
    self.ns_timer = NSTimer.timerWithTimeInterval(1, target: self, 
      selector: 'decrement', userInfo: nil, repeats: true)
    NSRunLoop.currentRunLoop.addTimer(ns_timer, forMode: NSDefaultRunLoopMode)
    delegate.pomodoro_timer_did_start(self)
  end
  
  def valid?
    ns_timer && ns_timer.valid?
  end
  
  def invalidate
    ns_timer.invalidate
    delegate.pomodoro_timer_did_invalidate(self)
  end
  
  
  private
  
  
  def decrement
    self.count -= 1
    if count > 0
      delegate.pomodoro_timer_did_decrement(self)
    else
      delegate.pomodoro_timer_did_finish(self)
    end
  end
    
end