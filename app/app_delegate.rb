class AppDelegate
  
  def main_view_controller
    @main_view_controller ||= MainViewController.alloc.initWithNibName(nil, bundle: nil)
  end
  
  def navigation_controller
    @navigation_controller ||= UINavigationController.alloc.
      initWithRootViewController(main_view_controller)
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
