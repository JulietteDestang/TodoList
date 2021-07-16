//
//  ContentView.swift
//  Todolist
//
//  Created by Juliette Destang on 15/07/2021.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

struct ContentView: View {
    
    @State private var items: [Item] = []
    @State private var editMode = EditMode.inactive
    private static var count = 0
    @State private var addText = ""

    var body: some View {
        NavigationView {
            List{
                Section {
                TextField("What's new?", text: $addText, onCommit:  {
                        onAdd()
                    })
                    .cornerRadius(40)
                }
                ForEach(items) { item in
                    Text(item.title)
    
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .navigationBarTitle("My TodoList 📝")
            .navigationBarItems(leading: EditButton())
            .environment(\.editMode, $editMode)
        }
    }
    var addButton: some View {
            switch editMode {
            case .inactive:
                return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
    private func onAdd() {
        items.append(Item(title: "\(addText)"))
        Self.count += 1
        addText = ""
    }
    func onDelete(offsets: IndexSet) {
            items.remove(atOffsets: offsets)
    }

    func onMove(source: IndexSet, destination: Int) {
            items.move(fromOffsets: source, toOffset: destination)
    }
}
