class PomodoroTimer
 
  attr_accessor :count
 
  attr_reader :delegate
 
  attr_accessor :ns_timer
 
  def initialize
    @count = Time.secsIn25Mins
  end
 
  def delegate=(object)
    @delegate = WeakRef.new(object)
  end
 
  def valid?
    ns_timer && ns_timer.valid?
  end
  
  def start
    invalidate if ns_timer
    self.ns_timer = NSTimer.timerWithTimeInterval(1, target: self, selector: 'decrement', userInfo: nil, repeats: true)
    NSRunLoop.currentRunLoop.addTimer(ns_timer, forMode: NSDefaultRunLoopMode)
    delegate.pomodoro_timer_did_start(self) if delegate
  end
 
 
  def invalidate
    ns_timer.invalidate
    delegate.pomodoro_timer_did_invalidate(self) if delegate
  end
 
 
  private
 
 
  def decrement
    self.count -= 1
    return if delegate.nil?
    if count > 0
      delegate.pomodoro_timer_did_decrement(self)
    else
      delegate.pomodoro_timer_did_finish(self)
    end
  end
 
end