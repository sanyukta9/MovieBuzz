//
//  Trie.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 20/03/26.
//

class Trie {
    private let root = TrieNode()
    
    //MARK: - Insert
    func insert(index: Int, word: String) {
        var node = root
        print("insertNode", node)
        
        //check for each letter in word if node has created for it or not
        for char in word {
            if node.childNode[char] == nil {
                //create node
                node.childNode[char] = TrieNode()
            }
            //move to tht node
            node = node.childNode[char]!
            //add index for it along the path
            print("Movie indices:", node.movieIndices)
            node.movieIndices.insert(index)
        }
    }
    
    //MARK: - Search
    func search(prefix: String) -> Set<Int> {
        var node = root
        for char in prefix {
            guard let nextNode = node.childNode[char] else { return [] }
            node = nextNode
        }
        return node.movieIndices
    }
}
