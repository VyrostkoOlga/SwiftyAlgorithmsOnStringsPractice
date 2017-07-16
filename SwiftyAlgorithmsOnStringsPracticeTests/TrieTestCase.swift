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
        XCTAssertEqual([Edge(v: 1, mark: "A"), Edge(v: 5, mark: "B")], trie.edges[0]!)
        XCTAssertEqual([Edge(v: 2, mark: "B")], trie.edges[1]!)
        XCTAssertEqual([Edge(v: 3, mark: "A"), Edge(v: 8, mark: "B")], trie.edges[2]!)
        XCTAssertEqual([Edge(v: 4, mark: "$")], trie.edges[3]!)
        XCTAssertEqual([Edge(v: 6, mark: "B")], trie.edges[5]!)
        XCTAssertEqual([Edge(v: 7, mark: "$")], trie.edges[6]!)
        XCTAssertEqual([Edge(v: 9, mark: "A")], trie.edges[8]!)
        XCTAssertEqual([Edge(v: 10, mark: "A")], trie.edges[9]!)
        XCTAssertEqual([Edge(v: 11, mark: "$")], trie.edges[10]!)
    }
    
    func testBuildTrie2() {
        let patterns = ["AB", "BA", "ABA"]
        let trie = Trie.buildTrie(patterns)
        XCTAssertEqual(6, trie.edges.count)
        XCTAssertEqual([Edge(v: 1, mark: "A"), Edge(v: 4, mark: "B")], trie.edges[0]!)
        XCTAssertEqual([Edge(v: 2, mark: "B")], trie.edges[1]!)
        XCTAssertEqual([Edge(v: 3, mark: "$"), Edge(v: 7, mark: "A")], trie.edges[2]!)
        XCTAssertEqual([Edge(v: 5, mark: "A")], trie.edges[4]!)
        XCTAssertEqual([Edge(v: 6, mark: "$")], trie.edges[5]!)
        XCTAssertEqual([Edge(v: 8, mark: "$")], trie.edges[7]!)
    }
}
