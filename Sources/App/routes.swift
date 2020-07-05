import Vapor
import Authentication

public func routes(_ router: Router) throws {
  
  // MARK: - Martin Lasek
  
  router.get("/") { req -> Future<View> in
    return try req.view().render("Home/home")
  }
  
  router.get("/projects") { req -> Future<View> in
    let context = ViewData.Projects(currentSite: CurrentSite("projects"), projectList: Project.all())
    return try req.view().render("projects", context)
  }

  router.get("/imprint") { req -> Future<View> in
    let context = ViewData.Imprint(currentSite: CurrentSite("imprint"))
    return try req.view().render("imprint", context)
  }
  
  router.get("/shop") { req -> Future<View> in
    let context = ViewData.Shop(currentSite: CurrentSite("shop"))
    return try req.view().render("shop", context)
  }
  
  // MARK: - Admin Panel
  let adminPanelController = AdminPanelController()
  router.group("admin") { adminRoute in
    adminRoute.get("register", use: adminPanelController.renderRegister)
    adminRoute.post("register", use: adminPanelController.register)
    adminRoute.get("login", use: adminPanelController.renderLogin)
    adminRoute.get("logout", use: adminPanelController.logout)
    
    let authSessionRouter = adminRoute.grouped(AdminUser.authSessionsMiddleware())
    authSessionRouter.post("login", use: adminPanelController.login)

    let protectedAdminRouter = authSessionRouter.grouped(RedirectMiddleware<AdminUser>(path: "/admin/login"))
    protectedAdminRouter.get("/", use: adminPanelController.renderIndex)
    protectedAdminRouter.get("wish/list", use: adminPanelController.renderWishList)
    protectedAdminRouter.post("wish", socialdown_Wish.parameter, "change-state", use: adminPanelController.changeState)
  }
  
  // MARK: - Social Down
  
  let socialdownWishController = socialdown_WishController()
  let socialdownAPI = router.grouped("api", "socialdown")
  socialdownAPI.get("wish/list", use: socialdownWishController.list)
  socialdownAPI.post("wish/create", use: socialdownWishController.create)
  socialdownAPI.post("wish", socialdown_Wish.parameter, "vote", use: socialdownWishController.vote)
}

struct CurrentSite: Encodable {
  let name: String
  
  init(_ name: String) {
    self.name = name
  }
}
