//
//  TaskListTableViewCell.swift
//  Task
//
//  Created by Benjamin Tincher on 1/13/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskListTableViewCell)
}

class TaskListTableViewCell: UITableViewCell {
    
    //  MARK: Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //  MARK: Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?
    
    //  MARK: Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        if task.isComplete {
            completionButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            completionButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}
