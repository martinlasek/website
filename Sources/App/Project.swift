//
//  ProjectList.swift
//  App
//
//  Created by Martin Lasek on 15.04.19.
//

struct Project: Encodable {
  let kind: Kind
  let bgColor: BackgroundColor
  
  let name: String
  let description: String
  let url: String
  
  let imageUrl: String
  
  enum Kind: String, Encodable {
    case iosLandscape
    case iosPortrait
    case web
  }
  
  enum BackgroundColor: String, Encodable {
    case red
    case graphit
    case orange
    case peach
  }
  
  static func all() -> [Project] {
    return [
      Project(
        kind: .iosLandscape,
        bgColor: .red,
        name: "Momoko IO",
        description: "It is a fast pace hardcore highscore game purely written in Swift using the native SceneKit Library.",
        url: "https://apps.apple.com/de/app/momoko-io/id1371665660",
        imageUrl: "/images/projects/momoko.png"
      ),
      Project(
        kind: .iosPortrait,
        bgColor: .graphit,
        name: "socialdown",
        description: "A personal assistant for Instagram influencer and everyone who wants to grow and become one organically.",
        url: "https://itunes.apple.com/us/app/socialdown/id1453720895",
        imageUrl: "/images/projects/momoko.png"
      ),
      Project(
        kind: .web,
        bgColor: .orange,
        name: "ServerSide.swift",
        description: "Conference Website to buy tickets, read about the talks and see the date and schedule.",
        url: "https://www.serversideswift.info",
        imageUrl: "/images/projects/momoko.png"
      ),
      Project(
        kind: .web,
        bgColor: .peach,
        name: "VaporBerlin",
        description: "Meetup Website to vote on topics to influence what talks should be presented on the next meetup.",
        url: "http://vapor.berlin",
        imageUrl: "/images/projects/momoko.png"
      ),
    ]
  }
}

fileprivate let list: [Project] = [
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
