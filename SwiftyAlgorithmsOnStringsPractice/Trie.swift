//
//  Trie.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 16.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import Foundation

struct Edge: CustomStringConvertible, Equatable, Hashable {
    let v: Int
    let mark: Character
    
    var description: String {
        return "\(v): \(mark)"
    }
    
    var hashValue: Int {
        return v
    }
    
    static func ==(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.v == rhs.v && lhs.mark == rhs.mark
    }
}

class Trie {
    
    private(set) var edges = [Int: [Edge]]()
    var notOccupiedV: Int = 1
    
    static func buildTrie(_ patterns: [String]) -> Trie {
        let trie = Trie()
        for pattern in patterns {
            let patternChars = pattern.characters
            var currentV = 0
            for c in patternChars {
                currentV = trie.addIfNeededEdge(fromV: currentV, marked: c)
            }
            let _ = trie.addIfNeededEdge(fromV: currentV, marked: "$")
        }
        return trie
    }
    
    fileprivate func addIfNeededEdge(fromV v: Int, marked mark: Character) -> Int {
        guard let vEdges = edges[v] else {
            edges[v] = [Edge(v: notOccupiedV, mark: mark)]
            notOccupiedV += 1
            return notOccupiedV - 1
        }
        
        var newEdge: Edge?
        for edge in vEdges {
            if edge.mark == mark {
                newEdge = edge
                break
            }
        }
        
        if let newEdge = newEdge {
            return newEdge.v
        }
        
        edges[v]?.append(Edge(v: notOccupiedV, mark: mark))
        notOccupiedV += 1
        return notOccupiedV - 1
    }
}
