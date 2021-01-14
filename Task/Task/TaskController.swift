//
//  TaskController.swift
//  Task
//
//  Created by Benjamin Tincher on 1/13/21.
//

import Foundation

class TaskController {
    
    //  MARK: Properties
    static let shared = TaskController()
    
    var tasks:[Task] = []
    
    //  MARK: CRUD
    //  Create
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let notes = notes ?? ""
        let dueDate = dueDate ?? Date()
        let task = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(task)
        saveToPersistenceStore()
    }
    
    //  Update
    func updateTask(task: Task, notes: String?, dueDate: Date?) {
        //update notes, dueDate; NOTE: toggle is handled on the TaskListVC and update is handled on the TaskDetailVC; thus, only need to pass info from text on TaskDetailVC
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistenceStore()
        //updateView?
    }
    
    //  Toggle
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    //  Delete
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistenceStore()
    }
    
    //  MARK: - Persistence
    
    //  fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    //  save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //  load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let loaded = try JSONDecoder().decode([Task].self, from: data)
            tasks = loaded
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
