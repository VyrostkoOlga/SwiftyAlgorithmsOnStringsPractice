//
//  SuffixTreeTest.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Olga Vyrostko on 21.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import XCTest
@testable import SwiftyAlgorithmsOnStringsPractice

class SuffixTreeTest: XCTestCase {
    
    let tree = SuffixTree()

    override func setUp() {
        super.setUp()
        
        tree.edges = [0: [SuffixTree.Edge(v: 1, mark: "A"), SuffixTree.Edge(v: 4, mark: "BAA$")],
                      1: [SuffixTree.Edge(v: 2, mark: "ABAA$"), SuffixTree.Edge(v: 3, mark: "BAA$")]]
        tree.notOccupiedV = 5
    }
    
    func testFindVForPattern() {
        var v = tree.findVForPattern("AAB$")
        XCTAssertEqual(2, v.v)
        XCTAssertEqual(3, v.dist)
        XCTAssertEqual(1, v.visitedFrom)
        XCTAssertEqual(1, v.visitedFromDist)
        
        v = tree.findVForPattern("BA$")
        XCTAssertEqual(4, v.v)
        XCTAssertEqual(2, v.dist)
        XCTAssertEqual(0, v.visitedFrom)
        XCTAssertEqual(0, v.visitedFromDist)
        
        v = tree.findVForPattern("A$")
        XCTAssertEqual(1, v.v)
        XCTAssertEqual(1, v.dist)
        XCTAssertEqual(0, v.visitedFrom)
        XCTAssertEqual(0, v.visitedFromDist)
        
        v = tree.findVForPattern("CA$")
        XCTAssertEqual(0, v.v)
        XCTAssertEqual(0, v.dist)
        XCTAssertEqual(0, v.visitedFrom)
        XCTAssertEqual(0, v.visitedFromDist)
    }
    
    func testBuildTree1() {
        let tree = SuffixTree.buildTree("AAB")
        XCTAssertEqual(tree.edges[0]!, [SuffixTree.Edge(v: 1, mark: "A"), SuffixTree.Edge(v: 4, mark: "B$"), SuffixTree.Edge(v: 5, mark: "$")])
        XCTAssertEqual(tree.edges[1]!, [SuffixTree.Edge(v: 2, mark: "AB$"), SuffixTree.Edge(v: 3, mark: "B$")])
    }
    
    func testBuildTree2() {
        let tree = SuffixTree.buildTree("AAAB")
        XCTAssertEqual(tree.edges[0]!, [SuffixTree.Edge(v: 1, mark: "A"), SuffixTree.Edge(v: 6, mark: "B$"), SuffixTree.Edge(v: 7, mark: "$")])
        XCTAssertEqual(tree.edges[1]!, [SuffixTree.Edge(v: 4, mark: "A"), SuffixTree.Edge(v: 5, mark: "B$")])
        XCTAssertEqual(tree.edges[4]!, [SuffixTree.Edge(v: 2, mark: "AB$"), SuffixTree.Edge(v: 3, mark: "B$")])
    }
}
