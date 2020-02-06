//
//  ProjectList.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

struct Project: Encodable {
  let kind: Kind
  
  let name: String
  let description: String
  let linkUrl: String
  
  let imageUrl: String
  
  enum Kind: String, Encodable {
    case iosLandscape
    case iosPortrait
    case web
  }
  
  static func all() -> [Project] {
    return [
      Project(
        kind: .iosLandscape,
        name: "Momoko IO",
        description: "It is a fast pace hardcore highscore game purely written in Swift using the native SceneKit Library.",
        linkUrl: "https://apps.apple.com/de/app/momoko-io/id1371665660",
        imageUrl: "/images/projects/momoko.png"
      )
    ]
  }
}

fileprivate let list = [
  Project(
    kind: .iosLandscape,
    name: "Momoko IO",
    description: "It is a fast pace hardcore highscore game purely written in Swift using the native SceneKit Library.",
    linkUrl: "https://apps.apple.com/de/app/momoko-io/id1371665660",
    imageUrl: "/images/projects/momoko.png"
  ),
  
  /*
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
 */
]
