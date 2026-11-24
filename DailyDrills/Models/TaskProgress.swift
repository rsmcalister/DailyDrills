//
// 
//


import Foundation
import SwiftData

@Model
final class TaskProgress {
    @Attribute(.unique) var taskID: String
    var isDone: Bool
    var completedAt: Date?

    init(taskID: String, isDone: Bool, completedAt: Date? = nil) {
        self.taskID = taskID
        self.isDone = isDone
        self.completedAt = completedAt
    }
}

