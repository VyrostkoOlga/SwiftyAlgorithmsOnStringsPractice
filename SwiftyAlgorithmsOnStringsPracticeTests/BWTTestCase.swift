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
        let bwt = BWT.build(text: "ababa$")
        XCTAssertEqual(bwt.bwt, ["a", "b", "b", "$", "a", "a"])
    }

    func testBuildBWT2() {
        let bwt = BWT.build(text: "abcaaa$")
        XCTAssertEqual(bwt.bwt, ["a", "a", "a", "c", "$", "a", "b"])
    }
}
