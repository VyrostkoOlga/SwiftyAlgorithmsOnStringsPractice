//
//  BWT.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 30.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import Foundation

class BWT {
    
    private(set) var bwt = [Character]()
    
    static func build(text: String) -> BWT {
        let bwt = BWT()
        let queue = PriorityQueue<String>(comparisonBlock: { (lhs, rhs) -> Bool in
            return lhs < rhs
        })
        
        let textLength = text.characters.count
        var border = 0
        
        while border < textLength {
            queue.push(element: text[border..<textLength] + text[0..<border])
            border += 1
        }
        
        while !queue.isEmpty {
            guard let el = queue.poll() else {
                break
            }
            bwt.bwt.append(el[el.characters.count - 1])
        }
        
        return bwt
    }
}
