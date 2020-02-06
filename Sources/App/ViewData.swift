//
//  ViewData.swift
//  App
//
//  Created by Martin Lasek on 05.02.20.
//

struct ViewData: Encodable {
  
  struct Projects: Encodable {
    let currentSite: CurrentSite
    let projectList: [Project]
  }
  
  struct Imprint: Encodable {
    let currentSite: CurrentSite
  }
  
  struct Shop: Encodable {
    let currentSite: CurrentSite
  }
}
