//
//  TrieTestCase.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 16.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import XCTest
@testable import SwiftyAlgorithmsOnStringsPractice

class TrieTestCase: XCTestCase {

    func testBuildTrie1() {
        let patterns = ["ABA", "BB", "ABBAA"]
        let trie = Trie.buildTrie(patterns)
        XCTAssertEqual(9, trie.edges.count)
        XCTAssertEqual([Trie.Edge(v: 1, mark: "A"), Trie.Edge(v: 5, mark: "B")], trie.edges[0]!)
        XCTAssertEqual([Trie.Edge(v: 2, mark: "B")], trie.edges[1]!)
        XCTAssertEqual([Trie.Edge(v: 3, mark: "A"), Trie.Edge(v: 8, mark: "B")], trie.edges[2]!)
        XCTAssertEqual([Trie.Edge(v: 4, mark: "$")], trie.edges[3]!)
        XCTAssertEqual([Trie.Edge(v: 6, mark: "B")], trie.edges[5]!)
        XCTAssertEqual([Trie.Edge(v: 7, mark: "$")], trie.edges[6]!)
        XCTAssertEqual([Trie.Edge(v: 9, mark: "A")], trie.edges[8]!)
        XCTAssertEqual([Trie.Edge(v: 10, mark: "A")], trie.edges[9]!)
        XCTAssertEqual([Trie.Edge(v: 11, mark: "$")], trie.edges[10]!)
    }
    
    func testBuildTrie2() {
        let patterns = ["AB", "BA", "ABA"]
        let trie = Trie.buildTrie(patterns)
        XCTAssertEqual(6, trie.edges.count)
        XCTAssertEqual([Trie.Edge(v: 1, mark: "A"), Trie.Edge(v: 4, mark: "B")], trie.edges[0]!)
        XCTAssertEqual([Trie.Edge(v: 2, mark: "B")], trie.edges[1]!)
        XCTAssertEqual([Trie.Edge(v: 3, mark: "$"), Trie.Edge(v: 7, mark: "A")], trie.edges[2]!)
        XCTAssertEqual([Trie.Edge(v: 5, mark: "A")], trie.edges[4]!)
        XCTAssertEqual([Trie.Edge(v: 6, mark: "$")], trie.edges[5]!)
        XCTAssertEqual([Trie.Edge(v: 8, mark: "$")], trie.edges[7]!)
    }
    
    func testTriePatternMatching() {
        let patterns = ["ABA", "BB", "ABBAA"]
        let trie = Trie.buildTrie(patterns)
        XCTAssertEqual([0], trie.findPositionsInText("BBACAAAAAAAAAAAA"))
        XCTAssertEqual([1, 3, 6], trie.findPositionsInText("BABABABB"))
        XCTAssertEqual([0, 1, 4], trie.findPositionsInText("ABBAABA"))
    }
}
