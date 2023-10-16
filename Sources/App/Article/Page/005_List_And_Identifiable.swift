//
//  Article+005.swift
//  website
//
//  Created by Martin Lasek on 10/16/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Article {
    static let a_005_List_And_Identifiable = Article(
        headline: "List and Identifiable in SwiftUI",
        subheadline: "It is now easier than ever to create a list - with one thing to make sure of. The elements are identifiable",
        slug: "list-and-identifiable-in-swiftui",
        published_at: .date(16, .oct, 2023),
        contentList: [
            .opener("In this tutorial, we will learn how to create a List in SwiftUI that dynamically grows. We will also learn about Identifiable and how to add a Navigation with a Button."),

            .image(.a_005_first_state_showcase),

            .h2("1. Create a new SwiftUI Project"),
            .text("In Xcode go ahead and create a new project and select Single View App. If you want to see how to create a new SwiftUI project have a look at the previous article:"),
            .link(.a_004_UnderstandingStateSwiftUI),

            .h2("2. Create a static List"),
            .text("Once your project is created navigate into the ContentView.swift file replace the code with the following:"),

            .code("""
            struct ContentView : View {
                var body: some View {
                    List {
                        Text("Charmander")
                        Text("Squirtle")
                        Text("Bulbasaur")
                        Text("Pikachu")
                    }
                }
            }
            """),

            .text("What if I told you this is it? That there’s nothing else to add? Well.. It really is!"),
            .image(.a_005_list_showcase),
            .text("The List will create a row for each View that is inside of it - and render that view in that row. We have 4 Text views. A row for each then 😊"),
            .text("How about we make our List a little more interesting before we move on and add the type to each Pokémon? Let’s do it:"),

            .code("""
            struct ContentView: View {
                var body: some View {
                    List {
                        HStack {
                            Text("Charmander")
                            Text("Fire").foregroundStyle(.red)
                        }
                        HStack {
                            Text("Squirtle")
                            Text("Water").foregroundStyle(.blue)
                        }
                        HStack {
                            Text("Bulbasaur")
                            Text("Grass").foregroundStyle(.green)
                        }
                        HStack {
                            Text("Pikachu")
                            Text("Electric").foregroundStyle(.yellow)
                        }
                    }
                }
            }
            """),
            .text("We’re using an HStack to have the Pokémon name and type stacked horizontally next to each other. With .foregroundStyle we give the second Text view a cool matching color."),

            .image(.a_005_list_pokemon_and_type),

            .h2("3. Make the List dynamic."),
            .text("A static List can make sense especially if you want to implement a Setting view. Static here meaning you define the List once and it stays like that. Our goal now is to adjust our List so that it is based of an Array of elements. There are a few ways of achieving that. Let’s have a look at two ways starting with the simpler one. Create a Pokemon struct with name, type, and color:"),

            .code("""
            import SwiftUI

            struct Pokemon {
                let name: String
                let type: String
                let color: Color
            }

            struct ContentView: View {
                var body: some View {
                    List {
                        HStack {
                            Text("Charmander")
                            Text("Fire").foregroundStyle(.red)
                        }
                        HStack {
                            Text("Squirtle")
                            Text("Water").foregroundStyle(.blue)
                        }
                        HStack {
                            Text("Bulbasaur")
                            Text("Grass").foregroundStyle(.green)
                        }
                        HStack {
                            Text("Pikachu")
                            Text("Electric").foregroundStyle(.yellow)
                        }
                    }
                }
            }
            """),

            .text("Now we can go and create a variable inside of our ContentView struct, name it pokemonList and assign an array of Pokemon instances to it:"),

            .code("""
            struct ContentView: View {
                var pokemonList = [
                    Pokemon(name: "Charmander", type: "Fire", color: .red),
                    Pokemon(name: "Squirtle", type: "Water", color: .blue),
                    Pokemon(name: "Bulbasaur", type: "Grass", color: .green),
                    Pokemon(name: "Pikachu", type: "Electric", color: .yellow),
                ]

                var body: some View {
                    List(pokemonList, id: \\.name) { pokemon in
                        HStack {
                            Text(pokemon.name)
                            Text(pokemon.type).foregroundStyle(pokemon.color)
                        }
                    }
                }
            }
            """),

            .text("You can see that I also updated our List view to accept our new array. Whenever we use a List based on an Array we also have to let the List know how to identify each row as unique. In our case, the name of each pokemon works quite well."),
            .text("If you run the project now everything should work just like before!"),

            .h2("4. Understand Identifieable"),
            .text("Let’s break our List a little to really understand the need of id with simply changing the name of Squirtle to Charmander and run the project."),
            .image(.a_005_list_id_broken_example),
            .text("You can see that our List updates accordingly, however, something is off.. If you look closely the second row indeed says Charmander just like our second element in our Array. BUT we kept the type of that second element to Water yet the List shows Fire."),
            .text("This is because the List is confused since it has two rows with the same Identifier. Two rows identify themselves with the String Charmander. That’s a no no. Let’s rename our Pokemon back to Squirtle."),
            .text("Here’s another way of letting our List know how to identify each row as unique and I think in the future we will prefer this one over the simpler one:"),

            .code("""
            import SwiftUI

            struct Pokemon: Identifiable {
                let id: Int
                let name: String
                let type: String
                let color: Color
            }

            struct ContentView: View {
                var pokemonList = [
                    Pokemon(id: 0, name: "Charmander", type: "Fire", color: .red),
                    Pokemon(id: 1, name: "Squirtle", type: "Water", color: .blue),
                    Pokemon(id: 2, name: "Bulbasaur", type: "Grass", color: .green),
                    Pokemon(id: 3, name: "Pikachu", type: "Electric", color: .yellow),
                ]

                var body: some View {
                    List(pokemonList, id: \\.id) { pokemon in
                        HStack {
                            Text(pokemon.name)
                            Text(pokemon.type).foregroundStyle(pokemon.color)
                        }
                    }
                }
            }
            """),

            .text("When conforming to the Identifiable protocol we have to to implement a variable called id. However this variable does not have to be an Int. The protocol only requires that the type of the variable id is actually Hashable."),

            .banner(.primary("Note: Int, Double, String and a lot more types are Hashable — go try it out!")),

            .text("When confirming to the Identifiable protocol we no longer have to explicitly tell the List how the elements in our Array are uniquely identified. 🥳"),

            .h2("5. Dynamically add elements to the List"),
            .text("What we are about to do is really cool! We will add a NavigationBar to our List with a Button that randomly adds a new Pokemon to our List. Cool? Very cool. 😎"),

            .text("Adding a Navigation is as simple as:"),
            .code("""
            struct ContentView: View {
                var pokemonList = [
                    Pokemon(id: 0, name: "Charmander", type: "Fire", color: .red),
                    Pokemon(id: 1, name: "Charmander", type: "Water", color: .blue),
                    Pokemon(id: 2, name: "Bulbasaur", type: "Grass", color: .green),
                    Pokemon(id: 3, name: "Pikachu", type: "Electric", color: .yellow),
                ]

                var body: some View {
                    NavigationStack {
                        List(pokemonList) { pokemon in
                            HStack {
                                Text(pokemon.name)
                                Text(pokemon.type).foregroundStyle(pokemon.color)
                            }
                        }.navigationBarTitle(Text("Pokémons"))
                    }
                }
            }
            """),
            .banner(.primary("Make sure the .navigationBarTitle is on the first element inside the NavigationStack.")),
            .text("You should end up with a view that looks like this:"),
            .image(.a_005_add_navigation),
            .text("Let’s implement a function that will randomly add a pokemon to our pokemonList variable. And let’s also make our variable a @State variable so that as soon as we change its value by adding a new element, our view updates automagically."),
            
            .code("""
            struct ContentView: View {
                @State
                var pokemonList = [
                    Pokemon(id: 0, name: "Charmander", type: "Fire", color: .red),
                    Pokemon(id: 1, name: "Squirtle", type: "Water", color: .blue),
                    Pokemon(id: 2, name: "Bulbasaur", type: "Grass", color: .green),
                    Pokemon(id: 3, name: "Pikachu", type: "Electric", color: .yellow),
                ]

                var body: some View {
                    NavigationStack {
                        List(pokemonList) { pokemon in
                            HStack {
                                Text(pokemon.name)
                                Text(pokemon.type).foregroundStyle(pokemon.color)
                            }
                        }.navigationBarTitle(Text("Pokémons"))
                    }
                }

                func addPokemon() {
                    if let randomPokemon = pokemonList.randomElement() {
                        pokemonList.append(randomPokemon)
                    }
                }
            }
            """),

            .text("We are using the native .randomElement() function of an Array to get a random element. The returned element, however, is optional. That is because in the case of the Array being empty that function would return nil. That’s why we append the returned value only in the case .randomElement() doesn’t return nil."),
            .text("Next let’s add a Button view to our Navigation and have addPokemon being executed once tapped!"),
            .code("""
            struct ContentView: View {
                @State
                var pokemonList = [
                    Pokemon(id: 0, name: "Charmander", type: "Fire", color: .red),
                    Pokemon(id: 1, name: "Squirtle", type: "Water", color: .blue),
                    Pokemon(id: 2, name: "Bulbasaur", type: "Grass", color: .green),
                    Pokemon(id: 3, name: "Pikachu", type: "Electric", color: .yellow),
                ]

                var body: some View {
                    NavigationStack {
                        List(pokemonList) { pokemon in
                            HStack {
                                Text(pokemon.name)
                                Text(pokemon.type).foregroundStyle(pokemon.color)
                            }
                        }
                        .navigationBarTitle(Text("Pokémons"))
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: addPokemon, label: { Text("Add")})
                            }
                        }
                    }
                }

                func addPokemon() {
                    if let randomPokemon = pokemonList.randomElement() {
                        pokemonList.append(randomPokemon)
                    }
                }
            }
            """),
            .text("We can use the .toolbar function to add ToolBarItem Views to our Navigation. Those views can be on the left side (leading) or on the right side (trailing). It’s up to you where you want them 😊!"),
            .banner(.primary("The ToolbarItem allows any kind of View. We are using Button but feel free to try others like Image, Text, etc.")),
            .text("Go run your app and add Pokemons 🥳!"),
            .image(.a_005_first_state_showcase)
        ]
    )
}

