//
//  DataCaching.swift
//  CachingModule
//
//  Created by Ahmad on 05/02/2025.
//


public protocol DataCaching {
    func set<T: Codable>(_ value: T, forKey key: String) async throws
    func get<T: Codable>(forKey key: String) async throws -> T?
    func removeValue(forKey key: String) async throws
    func clear() async throws
}
