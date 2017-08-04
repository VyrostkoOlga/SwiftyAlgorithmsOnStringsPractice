//
//  BWTTestCase.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 30.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import XCTest

class BWTTestCase: XCTestCase {

    func testBuildBWT1() {
        let text = "ababa$"
        let bwt = BWT.build(text: text)
        XCTAssertEqual(bwt.bwt, ["a", "b", "b", "$", "a", "a"])
        XCTAssertEqual(bwt.reconstruct(), text)
    }

    func testBuildBWT2() {
        let text = "abcaaa$"
        let bwt = BWT.build(text: text)
        XCTAssertEqual(bwt.bwt, ["a", "a", "a", "c", "$", "a", "b"])
        XCTAssertEqual(bwt.reconstruct(), text)
    }
}
