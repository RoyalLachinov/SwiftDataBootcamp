//
//  ContentView.swift
//  SwiftDataBootcamp
//
//  Created by Royal Lachinov on 2025-03-06.
//

import SwiftUI
import SwiftData

class FruitVegetableViewModel : ObservableObject {
    
   // @Environment(\.modelContext) private var modelContext
    
    @Published var newFruitName: String = ""
    @Published var newVegetableName: String = ""
    
    init() {
        //fruitList = []
        //vegetableList = []
        
        //self.fetchFruits()
        //self.fetchFruits()
    }
    
//    func fetchFruits(modelContext: ModelContext) {
//        let descriptor = FetchDescriptor<Fruit>(sortBy: [SortDescriptor(\Fruit.name)])//#Predicate(\Fruit.name == "Apple")
//        do {
//            fruitList = try modelContext.fetch(descriptor)
//        } catch {
//            print("Error fetching fruits: \(error)")
//        }
//    }
//    
//    func fetchVegetables(modelContext: ModelContext) {
//        let descriptor = FetchDescriptor<Vegetable>(sortBy: [SortDescriptor(\Vegetable.name)])
//        do {
//            vegetableList = try modelContext.fetch(descriptor)
//        } catch {
//            print("Error fetching vegetables: \(error)")
//        }
//    }
//    
    func insertFruit(modelContext: ModelContext) {
        let fruitList: [String] = [
            "Apple", "Banana", "Orange", "Pineapple", "Strawberry", "Blueberry", "Kiwi", "Lemon", "Grape", "Mango",
            "Peach", "Nectarine", "Plum", "Apricot", "Cherry", "Blackberry", "Raspberry", "Cranberry", "Clementine"
        ]
        
        withAnimation {
            let newFruit = Fruit(
                name: newFruitName//fruitList.randomElement() ?? "Unknown"
            )
            modelContext.insert(newFruit)
            newFruitName = ""
        }
    }
    
    
    func insertVeg(modelContext: ModelContext) {
        
        let vegetableList:[String] = [
            "Gabbage", "Carrot", "Broccoli", "Cucumber", "Bell Pepper", "Tomato", "Onion", "Spinach",
            "Zucchini", "Avocado", "Corn", "Beet", "Radish", "Cabbage", "Cucumber", "Carrot"
        ]
        withAnimation {
            let newVegetable = Vegetable(
                name: newVegetableName//vegetableList.randomElement() ?? "Unknown"
            )
            modelContext.insert(newVegetable)
            newVegetableName = ""
        }
    }
    
    func deleteFruitItems(offsets: IndexSet, modelContext: ModelContext) {
        withAnimation {
//            for index in offsets {
//                modelContext.delete(fruitList[index])
//            }
        }
    }
    
    func deleteVegItems(offsets: IndexSet, modelContext: ModelContext) {
        withAnimation {
//            for index in offsets {
//                modelContext.delete(vegetableList[index])
//            }
        }
    }
    
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FruitVegetableViewModel()
    
    @Query var fruitList: [Fruit] = []
    @Query var vegetableList: [Vegetable] = []
    
    var body: some View {
        NavigationSplitView {
            
            VStack {
                TextField("Add a new fruit", text: $viewModel.newFruitName)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .frame(height: 50)
                    .textFieldStyle(.roundedBorder)
                //                    .onChange(of: newFruitName) { newName in
                //                        newFruitName = newName.trimmingCharacters(in: .whitespaces)
                //                    }
                
                
                Button(action: {
                    viewModel.insertFruit(modelContext: modelContext)
                }) {
                    Text("Save a new fruit")
                }
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .cornerRadius(20)
                
                TextField("Add a new Vegetable", text: $viewModel.newVegetableName)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .frame(height: 50)
                    .textFieldStyle(.roundedBorder)
                //                    .onChange(of: newVegetable) { newName in
                //                        newVegetable = newName.trimmingCharacters(in: .whitespaces)
                //                    }
                
                Button(action: {
                    viewModel.insertVeg(modelContext: modelContext)
                }) {
                    Text("Save a new vegetable")
                }
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .cornerRadius(20)
                
                List {
                    Section(header: Text("Fruits")) {
                        ForEach(fruitList) { fruit in
                            NavigationLink {
                                Text("Fruit details at \(fruit.name)")
                            } label: {
                                Text(fruit.name)
                            }
                        }
//                        .onDelete(perform: {
//                            viewModel.deleteFruitItems(offsets: $0, modelContext: modelContext)
//                        })
                    }
                    
                    Section(header: Text("Vegetables")) {
                        ForEach(vegetableList) { vegetable in
                            NavigationLink {
                                Text("Fruit details at \(vegetable.name)")
                            } label: {
                                Text(vegetable.name)
                            }
                        }
//                        .onDelete(perform: {
//                            viewModel.deleteVegItems(offsets: $0, modelContext: modelContext)
//                        })
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: {
                            viewModel.insertFruit(modelContext: modelContext)
                        }) {
                            Label("Add Fruit", systemImage: "plus")
                        }
                    }
                }
            }
            
        } detail: {
            Text("Select a fruit")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Fruit.self, Vegetable.self], inMemory: true)
}
