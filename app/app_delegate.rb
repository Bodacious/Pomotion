# The main AppDelegate for Pomotion
class AppDelegate
  
  include CDQ
  
  # The MainViewController object to display on screen when the app is loaded.
  def main_view_controller
    @main_view_controller ||= MainViewController.alloc.initWithNibName(nil, bundle: nil)
  end
  
  # A UINavigationController to display main_view_controller in.
  def navigation_controller
    @navigation_controller ||= UINavigationController.alloc.
      initWithRootViewController(main_view_controller)
  end
 
  # The app's main UIWindow.
  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    cdq.setup
    window.rootViewController = navigation_controller
    window.makeKeyAndVisible
    true
  end
  
end
