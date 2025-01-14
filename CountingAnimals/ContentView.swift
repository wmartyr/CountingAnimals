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
    @State private var chosenAnimals = [String]()
    @State private var finalAnimalList: [Animal] = [Animal(animal: "")]
    @State private var correctAnswersList = ["bear": 0]
    @State private var answerIsCorrect = false
    @State private var buttonChosen = ""
    @State private var choicesList: [String: [Int]] = [:]
    @State private var buttonChosenList: [String] = []
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 100, maximum: 120))]
    
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
                    ForEach(choicesList[animal] ?? [], id: \.self) { choice in
                        let buttonID = "\(animal)-\(choice)"
                        var buttonPressed = buttonChosenList.contains(buttonID)
                        Button(String(choice)) {
                            withAnimation {
                                answerIsCorrect = isAnswerCorrect(animalPicked: animal, numberPicked: choice)
                                buttonChosen = "\(animal)-\(choice)"
                                buttonChosenList.append(buttonChosen)
                                print("Answer is \(answerIsCorrect)")
                            }
                        }
                        .padding(10)
                        .frame(width: 70, height: 70)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .background(buttonChosen == buttonID || buttonPressed ? correctAnswersList[animal] == choice ? Color.green : Color.red : Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .frame(width: .infinity)
            Spacer()
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
        chosenAnimals = Array(animals.shuffled().prefix(numberOfAnimals))
        finalAnimalList = animalDisplayGridList(gridSize)
        correctAnswersList = generateAnswersDictionary(finalAnimalList: finalAnimalList)
        choicesList = generateChoicesIncludingCorrectNumber(correctAnswersList: correctAnswersList)
    }
    
    func generateAnswersDictionary(finalAnimalList: [Animal]) -> [String: Int]{
        var ansList: [String: Int] = [:]
        for chosenAnimal in chosenAnimals {
            let count = finalAnimalList.filter { $0.animal == chosenAnimal}.count
            ansList[chosenAnimal] = count
        }
        return ansList
    }
    
    func generateChoicesIncludingCorrectNumber(correctAnswersList: [String: Int]) -> [String: [Int]] {
        var finalList: [String: [Int]] = [:]
        
        for (chosenAnimal, correctAnswer) in correctAnswersList {
            var choices: [Int] = [correctAnswer]
            for _ in 0...1 {
                var choice = Int.random(in: 0...6)
                while choices.contains(choice) {
                    choice = Int.random(in: 0...6)
                }
                choices.append(choice)
            }
            finalList[chosenAnimal] = choices.shuffled()
        }
        return finalList
    }
    
    
    func isAnswerCorrect(animalPicked: String, numberPicked: Int) -> Bool {
        return correctAnswersList[animalPicked] == numberPicked
    }
}

#Preview {
    ContentView()
}
