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
    @State private var gridSize = 4
    @State private var chosenAnimals = [""]
    @State private var finalAnimalList = [""]
    
    var body: some View {
        ForEach(finalAnimalList, id: \.self) { animal in
            Text("\(animal)")
                .font(.largeTitle)
            Image(animal)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding()
        .onAppear {
            initialSetup()
        }
    }
    
    func animalDisplayGridList(_ gridSize: Int) -> [String] {
        var finalList: [String] = []
        for _ in 0..<gridSize {
            finalList.append(chosenAnimals.randomElement() ?? "bear")
        }
        return finalList
    }
    
    func initialSetup() {
        chosenAnimals = Array(animals.shuffled().prefix(numberOfAnimals))
        finalAnimalList = animalDisplayGridList(gridSize)
    }
}

#Preview {
    ContentView()
}
