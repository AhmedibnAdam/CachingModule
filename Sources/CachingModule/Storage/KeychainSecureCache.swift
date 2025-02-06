//
//  KeychainSecureCache.swift
//  CachingModule
//
//  Created by Ahmad on 05/02/2025.
//

import Foundation
import Security

public final class KeychainSecureCache: SecureCaching {
    private let service: String
    
    public init(service: String) {
        self.service = service
    }
    
    public func set(_ value: String, forKey key: String) async throws {
        guard let data = value.data(using: .utf8) else { throw CacheError.invalidData }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Delete existing item if it exists
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw CacheError.keychainError(status) }
    }
    
    public func get(forKey key: String) async throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            if status == errSecItemNotFound { return nil }
            throw CacheError.keychainError(status)
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    public func removeValue(forKey key: String) async throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw CacheError.keychainError(status)
        }
    }
}
