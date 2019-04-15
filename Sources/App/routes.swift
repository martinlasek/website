import Vapor

public func routes(_ router: Router) throws {
  router.get("/") { req -> Future<View> in
    let context = HomeContext(projectList: projectListForHome())
    return try req.view().render("Home/home", context)
  }
  
  router.get("/projects") { req -> Future<View> in
    let context = ProjectsContext(currentSite: CurrentSite("projects"), projectList: completeProjectList())
    return try req.view().render("projects", context)
  }

  router.get("/imprint") { req -> Future<View> in
    let context = ImprintContext(currentSite: CurrentSite("imprint"))
    return try req.view().render("imprint", context)
  }
  
  router.get("/shop") { req -> Future<View> in
    let context = ShopContext(currentSite: CurrentSite("shop"))
    return try req.view().render("shop", context)
  }
}

struct CurrentSite: Encodable {
  let name: String
  
  init(_ name: String) {
    self.name = name
  }
}
