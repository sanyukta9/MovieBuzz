//
//  TrieNode.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 20/03/26.
//

class TrieNode {
    var childNode: [Character: TrieNode] = [:]
    var movieIndices: Set<Int> = []
}
