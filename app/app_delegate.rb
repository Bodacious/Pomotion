class AppDelegate
  
  def hello_world_label
    @hello_world_label ||= begin
      frame = CGRectMake(20,200,280,40)
      label           = UILabel.alloc.initWithFrame(frame)
      label.text      = "Hello world"
      label.textColor = UIColor.whiteColor
      label.textAlignment = UITextAlignmentCenter
      label
    end
  end
 
  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.addSubview(hello_world_label)
     window.makeKeyAndVisible    
    true
  end
end
