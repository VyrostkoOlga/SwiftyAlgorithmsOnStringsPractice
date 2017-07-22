//
//  SharedSubstringMatchingTestCase.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 22.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import XCTest

class SharedSubstringMatchingTestCase: XCTestCase {

    func testSharedSubstringMatching() {
        XCTAssertEqual("BA", SharedSubstringsMatching.findLongestSharedSubstring(s1: "ABA", s2: "BBA"))
        XCTAssertEqual("BB", SharedSubstringsMatching.findLongestSharedSubstring(s1: "AABBB", s2: "BBA"))
        XCTAssertEqual("BB", SharedSubstringsMatching.findLongestSharedSubstring(s1: "BBB", s2: "BBA"))
        XCTAssertEqual("ABB", SharedSubstringsMatching.findLongestSharedSubstring(s1: "AABBB", s2: "CABBA"))
        XCTAssertEqual("AAB", SharedSubstringsMatching.findLongestSharedSubstring(s1: "AAB", s2: "AAB"))
    }

    func testNotSharedSubstringMatching() {
        XCTAssertEqual("BB", SharedSubstringsMatching.findShortestNotSharedSubstring(s1: "ABA", s2: "BBA"))
        XCTAssertEqual("BA", SharedSubstringsMatching.findShortestNotSharedSubstring(s1: "AABBB", s2: "BBA"))
        XCTAssertEqual("A", SharedSubstringsMatching.findShortestNotSharedSubstring(s1: "BBB", s2: "BBA"))
        XCTAssertEqual("C", SharedSubstringsMatching.findShortestNotSharedSubstring(s1: "AABBB", s2: "CABBA"))
        XCTAssertEqual("", SharedSubstringsMatching.findShortestNotSharedSubstring(s1: "AAB", s2: "AAB"))
    }
}
