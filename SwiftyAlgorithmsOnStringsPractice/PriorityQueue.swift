//
//  PriorityQueue.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 30.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import Foundation

class PriorityQueue<T> {
    
    internal var queue = [T]()
    fileprivate var comparisonBlock: (T, T) -> Bool
    
    init(comparisonBlock: @escaping (T, T) -> Bool) {
        self.comparisonBlock = comparisonBlock
    }
    
    var size: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.count == 0
    }
    
    func push(element: T) {
        let index = findPosition(element: element)
        guard index < queue.count else {
            queue.append(element)
            return
        }
        queue.insert(element, at: index)
    }
    
    func peek() -> T? {
        return queue.first
    }
    
    func poll() -> T? {
        guard queue.count > 0 else { return nil }
        return queue.removeFirst()
    }
    
    func push(contentsOf collection: [T]) {
        for element in collection {
            push(element: element)
        }
    }
    
    fileprivate func findPosition(element: T) -> Int {
        var index = 0
        while index < queue.count, comparisonBlock(queue[index], element) { index += 1 }
        return index
    }
    
}
