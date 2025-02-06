//
//  CacheModule.swift
//  CachingModule
//
//  Created by Ahmad on 05/02/2025.
//

import Foundation

/// A thread-safe caching module combining secure and general-purpose caching.
@MainActor
public final class CacheModule {
    public let secureCache: SecureCaching
    public let dataCache: DataCaching
    
    /// Creates a caching module.
    /// - Parameters:
    ///   - secureCache: Secure storage implementation (default: Keychain).
    ///   - dataCache: General-purpose cache (e.g., SwiftData, UserDefaults).
    public init(
        secureCache: SecureCaching,
        dataCache: DataCaching
    ) {
        self.secureCache = secureCache
        self.dataCache = dataCache
    }
}


