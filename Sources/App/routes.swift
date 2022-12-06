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
  
  router.get("/terms-of-use-privacy-policy") { req -> Future<View> in
    return try req.view().render("terms-of-use-privacy-policy")
  }
  
  // MARK: - Admin Panel
  
  let adminPanelController = AdminPanelController()
  let socialdownWEBWishController = sd_web_WishController()
  let betterworkoutWEBWishController = bw_web_WishController()
  
  router.group("admin") { adminRoute in
    adminRoute.get("register", use: adminPanelController.renderRegister)
    adminRoute.post("register", use: adminPanelController.register)
    adminRoute.get("login", use: adminPanelController.renderLogin)
    
    let authSessionRouter = adminRoute.grouped(AdminUser.authSessionsMiddleware())
    authSessionRouter.post("login", use: adminPanelController.login)
    authSessionRouter.get("logout", use: adminPanelController.logout)

    let protectedAdminRouter = authSessionRouter.grouped(RedirectMiddleware<AdminUser>(path: "/admin/login"))
    protectedAdminRouter.get("/", use: adminPanelController.renderIndex)
    
    // MARK: - socialdown (web)
    
    protectedAdminRouter.get("socialdown/wish/list", use: socialdownWEBWishController.renderWishList)
    protectedAdminRouter.post("socialdown/wish", socialdown_Wish.parameter, "change-state", use: socialdownWEBWishController.changeState)
    
    // MARK: - betterworkout (web)
    
    protectedAdminRouter.get("betterworkout/wish/list", use: betterworkoutWEBWishController.renderWishList)
    protectedAdminRouter.post("betterworkout/wish", bw_Wish.parameter, "change-state", use: betterworkoutWEBWishController.changeState)
  }
  
  // MARK: - socialdown (api)
  
  let socialdownAPIWishController = sd_api_WishController()
  let socialdownAPI = router.grouped("api", "socialdown")
  socialdownAPI.get("wish/list", use: socialdownAPIWishController.list)
  socialdownAPI.post("wish/create", use: socialdownAPIWishController.create)
  socialdownAPI.post("wish", socialdown_Wish.parameter, "vote", use: socialdownAPIWishController.vote)
  
  // MARK: - Better Workout
  
  let bwWishController = bw_api_WishController()
  let bwAPI = router.grouped("api", "betterworkout")
  bwAPI.get("wish/list", use: bwWishController.list)
  bwAPI.post("wish/create", use: bwWishController.create)
  bwAPI.post("wish", bw_Wish.parameter, "vote", use: bwWishController.vote)
}

struct CurrentSite: Encodable {
  let name: String
  
  init(_ name: String) {
    self.name = name
  }
}
