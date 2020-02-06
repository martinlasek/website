import Vapor

public func routes(_ router: Router) throws {
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
}

struct CurrentSite: Encodable {
  let name: String
  
  init(_ name: String) {
    self.name = name
  }
}
