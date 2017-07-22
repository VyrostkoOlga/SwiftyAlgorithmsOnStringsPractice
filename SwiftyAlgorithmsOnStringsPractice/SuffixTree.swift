//
//  SuffixTree.swift
//  SwiftyAlgorithmsOnStringsPractice
//
//  Created by Olga Vyrostko on 20.07.17.
//  Copyright © 2017 Ольга Выростко. All rights reserved.
//

import Foundation

class SuffixTree {
    
    struct Edge: Equatable, Hashable {
        let v: Int
        let mark: String
        
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
    
    internal(set) var edges = [Int: [Edge]]()
    internal var notOccupiedV = 1
    
    static func buildTree(_ text: String) -> SuffixTree {
        let tree = SuffixTree()
        let length = text.characters.count + 1
        let text = text + "$"
        for index in 0..<length {
            let suffix = text[index..<length]
            let v = tree.findVForPattern(suffix)
            tree.appendEdgesForPattern(suffix, v: v)
        }
        return tree
    }
    
    // MARK: - tree add one more pattern methods
    
    internal func findVForPattern(_ pattern: String) -> (v: Int, dist: Int, visitedFrom: Int, visitedFromDist: Int) {
        let patternLength = pattern.characters.count
        
        var queue = [0]
        var visited = [0: 0]
        
        var dist = [Int]()
        for _ in 0..<notOccupiedV {
            dist.append(0)
        }
        
        while !queue.isEmpty {
            guard let currentV = queue.popLast() else { break }
            guard let vEdges = edges[currentV] else { continue }
            for edge in vEdges {
                let suffix = pattern[(dist[currentV])..<patternLength]
                let diffIdx = indexOfFirstDifference(lhs: edge.mark, rhs: suffix)
                dist[edge.v] = dist[currentV] + diffIdx
                visited[edge.v] = currentV
                
                if dist[edge.v] == patternLength {
                    return (v: edge.v, dist: dist[edge.v], visitedFrom: currentV, visitedFromDist: dist[currentV])
                }
                
                if diffIdx < edge.mark.characters.count {
                    continue
                }
                
                queue.append(edge.v)
            }
        }
        
        var maxDist = 0
        var maxDistV = 0
        var visitedFrom = 0
        for v in 0..<(notOccupiedV / 2 + 1) {
            if let visited = visited[v], dist[v] > maxDist {
                maxDist = dist[v]
                maxDistV = v
                visitedFrom = visited
            }
            if let visited = visited[notOccupiedV - 1 - v], dist[notOccupiedV - 1 - v] > maxDist {
                maxDist = dist[notOccupiedV - 1 - v]
                maxDistV = notOccupiedV - 1 - v
                visitedFrom = visited
            }
        }
        return (v: maxDistV, dist: maxDist, visitedFrom: visitedFrom, visitedFromDist: dist[visitedFrom])
    }
    
    internal func appendEdgesForPattern(_ pattern: String, v: (v: Int, dist: Int, visitedFrom: Int, visitedFromDist: Int)) {
        guard v.v < notOccupiedV else { return }
        var vEdges = edges[v.visitedFrom] ?? []
        
        let offset = v.dist - v.visitedFromDist
        guard offset > 0 else {
            vEdges.append(Edge(v: notOccupiedV, mark: pattern))
            edges[v.visitedFrom] = vEdges
            notOccupiedV += 1
            return
        }
        
        let index = vEdges.index { (edge) -> Bool in
            return edge.v == v.v
        }
        
        guard let sIndex = index else { return }
        let sEdge = vEdges[sIndex]
        let prefix = sEdge.mark[0..<offset]
        let suffix = sEdge.mark[offset..<vEdges[sIndex].mark.characters.count]
        vEdges.remove(at: sIndex)
        vEdges.append(Edge(v: sEdge.v, mark: prefix))
        edges[v.visitedFrom] = vEdges
        
        var rootEdges: [SuffixTree.Edge] = []
        rootEdges.append(Edge(v: notOccupiedV, mark: suffix))
        if let oldEdges = edges[vEdges[sIndex].v] {
            edges[notOccupiedV] = oldEdges
        }
        notOccupiedV += 1
        rootEdges.append(Edge(v: notOccupiedV, mark: pattern[v.dist..<pattern.characters.count]))
        notOccupiedV += 1
        edges[vEdges[sIndex].v] = rootEdges
    }
    
    fileprivate func indexOfFirstDifference(lhs: String, rhs: String) -> Int {
        var index = 0
        let minLength = min(lhs.characters.count, rhs.characters.count)
        while index < minLength {
            guard (lhs[index] as Character) == rhs[index] else { break }
            index += 1
        }
        return index
    }
}
