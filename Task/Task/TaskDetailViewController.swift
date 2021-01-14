//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Benjamin Tincher on 1/13/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    //  MARK: Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    //  MARK: Properties
    var task: Task?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //  MARK: Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        if let task = task {
            TaskController.shared.updateTask(task: task, notes: taskNotesTextView.text, dueDate: date)
        } else {
            let notes = taskNotesTextView.text
            let dueDate = date
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: dueDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerValueChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
}
