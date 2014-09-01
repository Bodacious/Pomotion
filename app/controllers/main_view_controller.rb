class MainViewController < UIViewController
  
  def loadView
    self.title = "Pomotion"
    self.view = MainView.alloc.initWithFrame(CGRectZero)
  end
  
end