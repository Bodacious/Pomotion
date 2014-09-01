class MainViewController < UIViewController
  
  def loadView
    self.view = MainView.alloc.initWithFrame(CGRectZero)
  end
  
end