//
//  SwiftDataCache.swift
//  MoviesDB
//
//  Created by Ahmad on 05/02/2025.
//

import SwiftData
import Foundation

@MainActor
public final class SwiftDataCache: DataCaching {
    private let context: ModelContext
    
    public init(context: ModelContext) {
        self.context = context
    }
    
    public func set<T: Codable>(_ value: T, forKey key: String) async throws {
        let data = try JSONEncoder().encode(value)
        let descriptor = FetchDescriptor<CacheItem>(predicate: #Predicate { $0.key == key })
        if let existingItem = try context.fetch(descriptor).first {
            existingItem.value = data
        } else {
            context.insert(CacheItem(key: key, value: data))
        }
        
        try context.save()
    }
    
    public func get<T: Codable>(forKey key: String) async throws -> T? {
        let descriptor = FetchDescriptor<CacheItem>(predicate: #Predicate { $0.key == key })
        guard let item = try context.fetch(descriptor).first else { return nil }
        return try JSONDecoder().decode(T.self, from: item.value)
    }
    
    public func removeValue(forKey key: String) async throws {
        let descriptor = FetchDescriptor<CacheItem>(predicate: #Predicate { $0.key == key })
        if let item = try context.fetch(descriptor).first {
            context.delete(item)
            try context.save()
        }
    }
    
    public func clear() async throws {
        try context.delete(model: CacheItem.self)
        try context.save()
    }
}
