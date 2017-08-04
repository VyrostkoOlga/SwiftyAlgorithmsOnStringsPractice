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
    
    func reconstruct() -> String {
        var result = [Character]()
        
        let sortedBWT = bwt.sorted()
        var currentIndex: Int? = 0
        while result.count != bwt.count {
            guard let index = currentIndex else { break }
            result.append(sortedBWT[index])
            currentIndex = findCharacter(sortedBWT[index], skipped: countPreviousForCharacterAtIndex(index, collection: sortedBWT))
        }
        return String(result.suffix(from: 1) + ["$"])
    }
    
    fileprivate func countPreviousForCharacterAtIndex(_ index: Int, collection: [Character]) -> Int {
        var currentIndex = 0
        var count = 0
        while currentIndex < index {
            if collection[currentIndex] == collection[index] {
                count += 1
            }
            currentIndex += 1
        }
        return count
    }
    
    fileprivate func findCharacter(_ char: Character, skipped: Int) -> Int? {
        var index = 0
        var currentlySkipped = 0
        while index < bwt.count {
            if bwt[index] == char {
                if currentlySkipped == skipped {
                    return index
                }
                currentlySkipped += 1
            }
            index += 1
        }
        return nil
    }
}
