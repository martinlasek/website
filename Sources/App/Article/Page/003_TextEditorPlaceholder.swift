//
//  Article+003.swift
//  website
//
//  Created by Martin Lasek on 10/11/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Article {
    
    static let a_003_texteditor_placeholder = Article(
        headline: "How To: Add a placeholder to TextEditor in SwiftUI.",
        subheadline: "SwiftUI currently only supports a placeholder for TextField but not for the TextEditor - Let's fix that!",
        slug: "how-to-add-a-placeholder-to-texteditor",
        published_at: .date(12, .oct, 2023),
        contentList: [
            .opener("If you tried to add a placeholder to a TextEditor you might have noticed that.. it doesn't work. It turns out TextEditor doesn't support a placeholder. Here's a quick and straightforward way how you can implement a placeholder yourself."),

            .text("I am going to show you the fully working piece of code so you can just copy and paste it. And if you want to understand why I did certain things like padding or spacer you will find the explanation right under the code snippet."),

            .code("""
            struct ContentView: View {

                @State
                var text: String = ""

                var body: some View {
                    ZStack {
                        TextEditor(text: $text)

                        if text.isEmpty {
                            VStack {
                                HStack {
                                    Text("Optional")
                                        .foregroundStyle(.tertiary)
                                        .padding(.top, 8)
                                        .padding(.leading, 5)

                                    Spacer()
                                }

                                Spacer()
                            }
                        }
                    }
                }
            }
            """),

            .text("You can see we are using a ZStack. It's important the TextEditor comes first as we want the Text view to be on top."),
            .text("The reason we use a VStack and an HStack here, is, because otherwise our Text view would be centered. However we want it vertically on top and horizontally to the left."),
            .text("The padding is used to place the text exactly where the TextEditor text would start. Using a simple isEmpty check allows us to show/hide the Text view based on whether we've entered something in our TextEditor. And that's it!"),

            .image(.a_003_texteditor_placeholder_result)
        ]
    )
}
