//
//  ContentView.swift
//  CountingAnimals
//
//  Created by Woodrow Martyr on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    @State private var numberOfAnimals = 2
    @State private var gridSize = 6
    @State private var chosenAnimals = [""]
    @State private var finalAnimalList: [Animal] = [Animal(animal: "")]
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 110))]
    
    struct Animal {
        let id = UUID()
        let animal: String
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                ForEach(finalAnimalList, id: \.id) { animal in
                    VStack {
                        Image(animal.animal)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Text("\(animal.animal)")
                            .textCase(.uppercase)
                    }
                }
                .padding(10)
                .onAppear {
                    initialSetup()
                }
            }
        }
    }
    
    func animalDisplayGridList(_ gridSize: Int) -> [Animal] {
        var finalList: [Animal] = []
        for _ in 0..<gridSize {
            finalList.append(Animal(animal: chosenAnimals.randomElement() ?? "bear"))
        }
        return finalList
    }
    
    func initialSetup() {
        print("Run initialSetup")
        chosenAnimals = Array(animals.shuffled().prefix(numberOfAnimals))
        finalAnimalList = animalDisplayGridList(gridSize)
        print("finalAnimalList: \(finalAnimalList)")
    }
}

#Preview {
    ContentView()
}
