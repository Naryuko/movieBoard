//
//  MyMovieListItem.swift
//  MovieBoard
//
//  Created by itct on 2019/12/10.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation


struct MyMovieListItem: Codable {
    
    var title: String
    var link: String
    var image: String
    var subtitle: String
    var pubDate: String
    var director: String
    var actor: String
    var userRating: String

    func saveItem(){
        DataManager.save(self, with: title)
        
}
    func deletItem(){
        DataManager.delet(title)
        
}
    
}
//
//  TodoList.swift
//  Checklist
//
//  Created by kali.forever on 15/10/2019.
//  Copyright © 2019 kali.forever. All rights reserved.
//

import Foundation

class TodoList {
    
    
    private var mymovielist: [[movieList]] = [[]]
    
    init() {
        mymovielist = [DataManager.loadAll(movieList.self)]
        
        
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
        
        row0Item.text = "Take a jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk the dog"
        row4Item.text = "Study design pattern"
        
        addTodo(row0Item, for: .medium)
        addTodo(row1Item, for: .low)
        addTodo(row2Item, for: .high)
        addTodo(row3Item, for: .no)
        addTodo(row4Item, for: .medium)
    }
    
    func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1) {
        if index < 0 {
            todos[priority.rawValue].append(item)
        } else {
            todos[priority.rawValue].insert(item, at: index)
        }
    }
    
    func todoList(for priority: Priority) -> [ChecklistItem] {
        return todos[priority.rawValue]
    }
    
    func newTodo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        todos[Priority.medium.rawValue].append(item)
        return item
    }
    
    func move(item: ChecklistItem,
              from sourcePriority: Priority,
              at sourceIndex: Int,
              to destinationPriority: Priority,
              at destinationIndex: Int) {
        remove(item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
    }
    
    func remove(_ item: ChecklistItem, from priority: Priority, at index: Int) {
        todos[priority.rawValue].remove(at: index)
    }
    
    private func randomTitle() -> String {
        let titles = ["New todo item", "Generic todo", "Fill me out", "I need something todo", "Much todo about nothing"]
        let randomNumber = Int.random(in: (0...titles.count - 1))
        return titles[randomNumber]
    }
}
