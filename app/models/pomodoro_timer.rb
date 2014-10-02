# Timer class that handles the count down of one Pomodoro
class PomodoroTimer
 
  # The number of seconds left in this Pomodoro as an Integer
  attr_accessor :count
 
  # The delegate to notify when certain events occur within this PomodoroTimer
  attr_reader :delegate
 
  # An NSTimer object used to decrement the PomodoroTimer once per second
  attr_accessor :ns_timer
 
  # Create's a new PomodoroTimer with a count of Time.secsIn25Mins 
  def initialize
    @count = Time.secsIn25Mins
  end
 
  # Set's the delegate property as a weak reference
  # 
  # object - The Object to act as this PomodoroTimer's delegate
  def delegate=(object)
    @delegate = WeakRef.new(object)
  end
 
  # Is this PomodoroTimer's ns_timer still vaild?
  def valid?
    ns_timer && ns_timer.valid?
  end
  
  # Start this PomodoroTimer counting down to zero
  def start
    invalidate if ns_timer
    self.ns_timer = NSTimer.timerWithTimeInterval(1, target: self, selector: 'decrement', userInfo: nil, repeats: true)
    NSRunLoop.currentRunLoop.addTimer(ns_timer, forMode: NSDefaultRunLoopMode)
    delegate.pomodoro_timer_did_start(self) if delegate
  end
 
  # Invalidate this PomodoroTimer (via ns_timer) and stop the countdown
  def invalidate
    ns_timer.invalidate
    delegate.pomodoro_timer_did_invalidate(self) if delegate
  end
 
 
  private
 
  
  # Decrement count by 1 second
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