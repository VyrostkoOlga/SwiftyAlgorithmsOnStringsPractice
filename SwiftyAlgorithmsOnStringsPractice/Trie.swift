//
//  Trie.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Ольга Выростко on 16.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import Foundation

class Trie {
    
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
    
    private(set) var edges = [Int: [Edge]]()
    private var notOccupiedV: Int = 1
    
    static let endSymbol: Character = "$"
    
    static func buildTrie(_ patterns: [String]) -> Trie {
        let trie = Trie()
        for pattern in patterns {
            let patternChars = pattern.characters
            var currentV = 0
            for c in patternChars {
                currentV = trie.addIfNeededEdge(fromV: currentV, marked: c)
            }
            let _ = trie.addIfNeededEdge(fromV: currentV, marked: Trie.endSymbol)
        }
        return trie
    }
    
    func findPositionsInText(_ text: String) -> [Int] {
        var positions = [Int]()
        for pos in 0..<text.characters.count {
            if checkContainsPatterns(text, fromPosition: pos) {
                positions.append(pos)
            }
        }
        return positions
    }
    
    fileprivate func checkContainsPatterns(_ text: String, fromPosition pos: Int) -> Bool {
        var queue = [0]
        var offset = 0
        while !queue.isEmpty {
            var nextQueue = [Int]()
            while !queue.isEmpty {
                guard let v = queue.popLast() else { break }
                guard let vEdges = edges[v] else { return true }
                for edge in vEdges {
                    if edge.mark == Trie.endSymbol { return true }
                    
                    if pos + offset < text.characters.count, edge.mark == text[pos + offset] {
                        nextQueue.append(edge.v)
                    }
                }
            }
            queue = nextQueue
            offset += 1
        }
        return false
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
