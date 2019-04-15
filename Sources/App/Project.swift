//
//  ProjectList.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

struct Project: Encodable {
  let imageUrl: String
  let title: String
  let description: String
  let kind: Kind
  let linkUrl: String
  
  enum Kind: String, Encodable {
    case ios
    case web
  }
}

fileprivate let list = [
  Project(
    imageUrl: "/images/projects/socialdown.png",
    title: "socialdown",
    description: "A personal assistant for every Instagram user.",
    kind: .ios,
    linkUrl: "/"
  ),
  Project(
    imageUrl: "/images/projects/serversideswiftracing.png",
    title: "serversideswift.racing",
    description: "Statistics on the four major server-side swift frameworks.",
    kind: .web,
    linkUrl: "http://serversideswift.racing"
  ),
  Project(
    imageUrl: "/images/projects/vaporberlin.png",
    title: "vapor.berlin",
    description: "Vote for topics for the next vapor.berlin meetup.",
    kind: .web,
    linkUrl: "http://vapor.berlin"
  ),
]

func completeProjectList() -> [Project] {
  return list
}

func projectListForHome() -> [Project] {
  var lastThreeProjects = [Project]()
  var list = completeProjectList()
  list.reverse()
  
  for index in 0...2 {
    if index < list.count {
      lastThreeProjects.append(list[index])
    }
  }
  
  lastThreeProjects.reverse()
  return lastThreeProjects
}
