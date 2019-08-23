//
//  ProjectList.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

struct Project: Encodable {
  let slug: String
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
    slug: "socialdown",
    imageUrl: "/images/projects/socialdown.png",
    title: "socialdown",
    description: "A personal assistant for every Instagram user.",
    kind: .ios,
    linkUrl: "https://itunes.apple.com/us/app/socialdown/id1453720895"
  ),
  Project(
    slug: "momoko",
    imageUrl: "/images/projects/momoko.png",
    title: "Momoko",
    description: "It's a hardcore highscore game perfect when waiting for the bus!",
    kind: .ios,
    linkUrl: "https://apps.apple.com/de/app/momoko-io/id1371665660"
  ),
  Project(
    slug: "serversideswift-conference",
    imageUrl: "/images/projects/serversideswift.png",
    title: "ServerSide.swift",
    description: "Website for the server-side swift conference.",
    kind: .web,
    linkUrl: "https://www.serversideswift.info"
  ),
  Project(
    slug: "vapor-berlin",
    imageUrl: "/images/projects/vaporberlin.png",
    title: "vapor.berlin",
    description: "Vote for topics for the next VaporBerlin meetup.",
    kind: .web,
    linkUrl: "http://vapor.berlin"
  ),
  Project(
    slug: "serversideswift-racing",
    imageUrl: "/images/projects/serversideswiftracing.png",
    title: "serversideswift.racing",
    description: "Statistics on the four major server-side swift frameworks.",
    kind: .web,
    linkUrl: "http://serversideswift.racing"
  ),
]

func completeProjectList() -> [Project] {
  return list
}

func projectListForHome() -> [Project] {
  let teaseList = [
    "socialdown",
    "momoko",
    "serversideswift-conference"
  ]
  
  var list = completeProjectList()
  list = list.filter({ project in teaseList.contains(where: { slug in slug == project.slug }) })

  return list
}
