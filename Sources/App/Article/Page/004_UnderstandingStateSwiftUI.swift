//
//  Artcle+004.swift
//  website
//
//  Created by Martin Lasek on 10/13/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Article {
    static let a_004_UnderstandingStateSwiftUI = Article(
        headline: "Understanding @State in SwiftUI",
        subheadline: "When starting out with SwiftUI the @State property wrapper might very well be the most important one to learn about.",
        slug: "understanding-state-in-swiftui",
        published_at: .date(13, .oct, 2023),
        contentList: [
            .opener("In this tutorial we will dive into the fundamentals of State — what it is, why it’s good and how to use it."),

            .h2("Here's what you will have achieved at the end of this tutorial."),
            .image(.a_004_result_showcasing),

            .h2("1. Create a new SwiftUI Project"),
            .text("In Xcode just go ahead as usual and create a new project and select the Single View App:"),
            .image(.a_004_create_new_project),

            .text("Next, make sure that Use SwiftUI is checked before you finally determine where to create the project:"),
            .image(.a_004_select_swift_ui),

            .h2("2. Create A Text and a Button View"),
            .text("You will be greeted with two .swift files from which we will solely focus on ContentView.swift. Inside here we see an Image view and Text view. Let's delete the Image view and add a Button view instead:"),
            .image(.a_004_starter_content_view),

            .text("Let’s explain each line here. Now VStack allows you to vertically stack views. The counterpart is HStack and you guessed it — it allows horizontal stacking."),

            .text("You can already feel how strongly SwiftUI focuses on closures and Views."),

            .text("The Button view is instantiated with two closures. The first one we pass in will be executed when the button is tapped. The second one is for us so we can return a View inside of it which defines the appearance of our button."),

            .text("Let’s apply some styling to our Text so that it’s a little nicer to look at it:"),

            .code("""
            struct ContentView: View {
                var body: some View {
                    VStack {
                        Text("Hello, world!")
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundStyle(.white)

                        Button(
                            action: { print("Hey Listen!") },
                            label: { Text("Switch") }
                        )
                    }
                    .padding()
                }
            }
            """),

            .text("Don't worry if this feels a little intimidating. These functions to style and manipulate a view are just new right now. But just like we slowly learned how to set the background color of a UIView to blue:"),

            .code("""
            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                myView.backgroundColor = .blue
            }
            """),

            .text("We will learn and get used to how to achieve the same thing (and more) in SwiftUI!"),
            .text("Okay, now with our adjustments you should have an awesome looking view like this:"),
            .image(.a_004_styled_content_view),

            .h2("3. Understanding State"),
            .text("Looking at our code we actually want to pass a name of a Pokemon into our Text view. Let’s not forget that we have nothing fancy but just a simple struct. We did use structs before and defined variables and functions inside of them."),
            .text("So let’s define a variable with a pokemon name and a function that changes it:"),

            .code("""
            struct ContentView: View {
                var pokemonName = "Charmander"
            
                var body: some View {
                    VStack {
                        Text(pokemonName)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundStyle(.white)
                        Button(
                            action: { self.switchPokemon() },
                            label: { Text("Switch") }
                        )
                    }
                }
                
                func switchPokemon() {
                    pokemonName = "Pikachu"
                }
            }
            """),

            .text("Xcode should complain: Cannot assign to property: ‘self’ is immutable."),
            .text("That’s because structs by default can’t mutate their own properties / variables. They could when we say mutating in front of our switchPokemon function. However, this isn’t really our issue — what we want is to write the new keyword @State in front of our variable pokemonName and it’s fixed!"),

            .code("""
            struct ContentView: View {
                @State
                var pokemonName = "Charmander"
                
                var body: some View {
                    ...
                }

                func switchPokemon() {
                    pokemonName = "Pikachu"
                }
            }
            """),

            .text("What does that new keyword do and why is it good?"),
            
            .banner(.primary("When the state updates, the view invalidates its appearance and updates itself.")),

            .text("It basically means our View which is our body variable will be re-rendered as soon as we are changing a variable that has @State as a keyword in front of it."),
            .text("Go ahead hit run and click the button to see how the text switches to pikachu!"),

            .image(.a_004_first_state_showcase),

            .text("When our body gets rendered the first time we have “Charmander” as a value for our variable with the @State keyword in front of it. The Text view will therefore display “Charmander”."),
            .text("Now, when we tap the button this will update our variable to a new value: “Pikachu” - and because our variable is a @State variable our View will be re-rendered. However at this point our pokemon variable holds the value “Pikachu” and so that's what the Text view will show."),

            .text("We can finish our random Pokemon name picker with actual random names:"),
            .code("""
            struct ContentView: View {
                @State
                var pokemonName = "Charmander"
                
                var body: some View {
                    VStack {
                        Text(pokemonName)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundStyle(.white)
                        Button(
                            action: { self.switchPokemon() },
                            label: { Text("Switch") }
                        )
                    }
                }

                func switchPokemon() {
                    let list = ["Squirtle", "Bulbasaur", "Charmander", "Pikachu"]
                    pokemonName = list.randomElement() ?? ""
                }
            }
            """),

            .text("Now you should have a View that automagically re-renders as soon as you change your @State variable and you should be able to switch to a random pokemon from your list by tapping the button 🥳")
        ]
    )
}
