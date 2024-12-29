//
//  ContentView.swift
//  CountingAnimals
//
//  Created by Woodrow Martyr on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    @State private var numberOfAnimals = 3
    @State private var gridSize = 6
    @State private var chosenAnimals: [String] = []
    @State private var finalAnimalList: [Animal] = [Animal(animal: "")]
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 100))]
    
    struct Animal {
        let id = UUID()
        let animal: String
    }

    var body: some View {
        VStack {
            LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                ForEach(finalAnimalList, id: \.id) { animal in
                    VStack {
                        Image(animal.animal)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .padding(10)
                .onAppear {
                    initialSetup()
                }
            }
            Spacer()
            ForEach(chosenAnimals, id: \.self) { animal in
                let numberChoices = generateChoicesIncludingCorrectNumber(animal: animal)
                HStack {
                    VStack {
                        Image(animal)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("\(animal)")
                            .textCase(.uppercase)
                            .fontWeight(.bold)
                    }
                    .padding(10)
                    ForEach(numberChoices, id: \.self) { choice in
                        Button {
                            print("Button \(choice) tapped")
                        }label: {
                            Text("\(choice)")
                                .font(.largeTitle)
                                .padding()
                        }
                        .buttonStyle(.borderedProminent)

                    }
                }
            }
            .frame(width: .infinity)
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
        print("initial setup")
        chosenAnimals = Array(animals.shuffled().prefix(numberOfAnimals))
        finalAnimalList = animalDisplayGridList(gridSize)
        print("choosenAnimals: \(chosenAnimals)")
        print("finalAnimalList: \(finalAnimalList)")
    }
    
    func generateChoicesIncludingCorrectNumber(animal: String) -> [Int] {
        print("Run generateChoicesIncludingCorrectNumber")
        let count = finalAnimalList.filter { $0.animal == animal }.count
        var choices: [Int] = [count]
        var choice = 0
        for _ in 0...1 {
            choice = Int.random(in: 0...6)
            while choices.contains(choice) {
                choice = Int.random(in: 0...6)
            }
            choices.append(choice)
        }
        print("animal: \(animal)")
        print("count: \(count)")
        let finalChoices = choices.shuffled()
        print("finalChoices: \(finalChoices)")
        return finalChoices
    }
}

#Preview {
    ContentView()
}
