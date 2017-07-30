//
//  PriorityQueueTestCase.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 30.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

@testable import SwiftyAlgorithmsOnStringsPractice
import XCTest

class PriorityQueueTestCase: XCTestCase {

    func testIntegerQueue() {
        let queue = PriorityQueue<Int>(comparisonBlock: { (lhs, rhs) -> Bool in
            lhs > rhs
        })
        
        queue.push(element: 4)
        XCTAssertEqual(queue.queue, [4])
        queue.push(element: 6)
        XCTAssertEqual(queue.queue, [6, 4])
        queue.push(element: 8)
        XCTAssertEqual(queue.queue, [8, 6, 4])
        queue.push(element: 5)
        XCTAssertEqual(queue.queue, [8, 6, 5, 4])
        queue.push(element: 3)
        XCTAssertEqual(queue.queue, [8, 6, 5, 4, 3])
    }

    func testCharacterQueue() {
        let queue = PriorityQueue<Character>(comparisonBlock: { (lhs, rhs) -> Bool in
            lhs < rhs
        })
        
        queue.push(element: "a")
        XCTAssertEqual(queue.queue, ["a"])
        queue.push(element: "$")
        XCTAssertEqual(queue.queue, ["$", "a"])
        queue.push(element: "t")
        XCTAssertEqual(queue.queue, ["$", "a", "t"])
        queue.push(element: "b")
        XCTAssertEqual(queue.queue, ["$", "a", "b", "t"])
    }
    
    func testStringQueue() {
        let queue = PriorityQueue<String>(comparisonBlock: { (lhs, rhs) -> Bool in
            lhs < rhs
        })
        
        queue.push(element: "aba$")
        XCTAssertEqual(queue.queue, ["aba$"])
        queue.push(element: "ba$a")
        XCTAssertEqual(queue.queue, ["aba$", "ba$a"])
        queue.push(element: "a$ab")
        XCTAssertEqual(queue.queue, ["a$ab", "aba$", "ba$a"])
        queue.push(element: "$aba")
        XCTAssertEqual(queue.queue, ["$aba", "a$ab", "aba$", "ba$a"])
    }
    
    func testPeekAndPoll() {
        let queue = PriorityQueue<Int>(comparisonBlock: { (lhs, rhs) -> Bool in
            lhs > rhs
        })
        
        queue.push(element: 4)
        queue.push(element: 6)
        queue.push(element: 8)
        queue.push(element: 5)
        queue.push(element: 3)
        
        XCTAssertEqual(queue.peek(), 8)
        XCTAssertEqual(queue.poll(), 8)
        XCTAssertEqual(queue.queue, [6, 5, 4, 3])
    }
}
