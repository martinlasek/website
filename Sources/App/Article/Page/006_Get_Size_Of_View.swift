//
//  Article+006.swift
//  website
//
//  Created by Martin Lasek on 10/19/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Splash

extension Article {

    static let a_006_Get_Size_Of_View = Article(
        headline: "How To: Get the size of a view in SwiftUI",
        subheadline: "How to get the size of a view in SwiftUI using GeometryReader.",
        slug: "get-size-of-view-in-swiftui",
        published_at: .date(19, .oct, 2023),

        contentList: [
            .opener("Here’s how you can get the size of any view in SwiftUI using the GeometryReader."),

            .h2("The Problem"),
            .text("You are trying to figure out what size a certain view is."),
            .image(.a_006_the_problem),

            .h2("The Solution"),
            .code("""
            struct ContentView: View {
                var body: some View {
                    Text("Ethan Hunt")
                        .background(
                            GeometryReader { proxy in
                                Color.red.onAppear {
                                    print("🔥 \\(proxy.size)")
                                }
                            }
                        )
                }
            }
            """),

            .text("We are using the background modifier to fill it with the color red. By wrapping our color in a GeometryReader we are able to read the size of that color plane."),

            .image(.a_006_the_solution),

            .text("You could've alternatively also just wrapped your Text view with a GeometryReader and do the .onAppear on that Text view instead. But sometimes it's nice to see the color of the frame we are investigating for better visual debugging.")
        ]
    )
}
