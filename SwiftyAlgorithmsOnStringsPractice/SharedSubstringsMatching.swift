//
//  SharedSubstringsMatching.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 22.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import Foundation

class SharedSubstringsMatching {
    
    static func findShortestNotSharedSubstring(s1: String, s2: String) -> String {
        guard let range = SharedSubstringsMatching.findShortestSharedSubstringBounds(s1: s1, s2: s2) else {
            return ""
        }
        
        var correctedRange: Range<Int>
        if range.upperBound < s2.characters.count {
            correctedRange = range.lowerBound..<(range.upperBound + 1)
        } else {
            return ""
        }
        
        return s2[correctedRange]
    }
    
    static func findLongestSharedSubstring(s1: String, s2: String) -> String {
        guard let range = SharedSubstringsMatching.findLongestSharedSubstringBounds(s1: s1, s2: s2) else {
            return ""
        }
        return s2[range]
    }
    
    fileprivate static func findShortestSharedSubstringBounds(s1: String, s2: String) -> Range<Int>? {
        let s1Tree = SuffixTree.buildTree(s1)
        
        var minV: (v: Int, dist: Int, visitedFrom: Int, visitedFromDist: Int)?
        var minVOffset = 0
        
        let s2Length = s2.characters.count
        for index in 0..<s2Length {
            let v = s1Tree.findVForPattern(s2[index..<s2Length])
            
            guard minV != nil else {
                minV = v
                minVOffset = index
                continue
            }
            
            if minV!.dist > v.dist {
                minV = v
                minVOffset = index
            }
        }
        
        guard let sMinV = minV else { return nil }
        return minVOffset..<(minVOffset + sMinV.dist)
    }
    
    fileprivate static func findLongestSharedSubstringBounds(s1: String, s2: String) -> Range<Int>? {
        let s1Tree = SuffixTree.buildTree(s1)
        
        var maxV: (v: Int, dist: Int, visitedFrom: Int, visitedFromDist: Int)?
        var maxVOffset = 0
        
        let s2Length = s2.characters.count
        for index in 0..<s2Length {
            let v = s1Tree.findVForPattern(s2[index..<s2Length])
            
            guard maxV != nil else {
                maxV = v
                maxVOffset = index
                continue
            }
            
            if maxV!.dist < v.dist {
                maxV = v
                maxVOffset = index
            }
        }
        
        guard let sMaxV = maxV else { return nil }
        return maxVOffset..<(maxVOffset + sMaxV.dist)
    }
    
}
