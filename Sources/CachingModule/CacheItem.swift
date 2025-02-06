//
//  CacheItem.swift
//  MoviesDB
//
//  Created by Ahmad on 05/02/2025.
//


import SwiftData
import Foundation

@Model
public final class CacheItem {
    var key: String
    var value: Data
    
    public init(key: String, value: Data) {
        self.key = key
        self.value = value
    }
}
