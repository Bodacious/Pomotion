class AppDelegate
  
  def navigation_controller
    @navigation_controller ||= UINavigationController.alloc.
      initWithRootViewController(main_controller)
  end
  
  def main_controller
    @main_controller ||= MainViewController.alloc.initWithNibName(nil, bundle: nil)
  end
  
  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.rootViewController = navigation_controller
    window.makeKeyAndVisible
    true
  end
  
end