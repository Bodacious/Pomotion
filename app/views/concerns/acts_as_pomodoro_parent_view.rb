module ActsAsPomodoroParentView
  
  def add_pomodoro_view(count = 1)
    count.times do 
      pomodoro_view = PomodoroView.alloc.initWithFrame(CGRectZero)
      if respond_to?(:contentView)
        contentView.addSubview(pomodoro_view)
      else
        addSubview(pomodoro_view)
      end
    end
  end
  
end