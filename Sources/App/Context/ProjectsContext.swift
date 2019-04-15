//
//  ProjectsContext.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

struct ProjectsContext: Encodable {
  let currentSite: CurrentSite
  let projectList: [Project]
}
