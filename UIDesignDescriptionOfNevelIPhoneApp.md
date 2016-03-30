# UI 设计说明 -- Nevel iPhone Application #

本文档用于说明 NevelForiPhone 应用程序的UI设计结构.


## 程序主菜单设计说明 ##

**类: NevelForiPhoneAppDelegate**

  * 应用程序主标签栏控制器:

> UITabBarController: appRootController

> with IBOutlet --> MainWindow.xib / Tab Bar Controller

  * Tab\_1: 托管站点列表 -- 导航控制器类

> 创建 SiteListNavViewController 类的实例: siteListNavViewController

  * Tab\_2: 系统设置 -- 导航控制器类

> 创建 AppSettingsNavViewController 类的实例: appSettingsNavViewController

**NIB: MainWindow.xib**

  * 新增控件 Tab Bar Controller

> number of tabs: 2

  * Tab\_1:

> name: Site List

> class: UINavigationController

> subclass: SiteListNavRootViewController

> NIB: SiteListNavRootViewController

  * Tab\_1:

> name: Settings

> class: UINavigationController

> subclass: AppSettingsNavRootViewController

> NIB: AppSettingsNavRootViewController