//
//  CacheModule.swift
//  MoviesDB
//
//  Created by Ahmad on 05/02/2025.
//


import SwiftData

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
        secureCache: SecureCaching = KeychainSecureCache(),
        dataCache: DataCaching
    ) {
        self.secureCache = secureCache
        self.dataCache = dataCache
    }
}

// MARK: - Factory
@MainActor
public enum CacheModuleFactory {
    public static func make(context: ModelContext) throws -> CacheModule {
        guard context.container != nil else {
            throw CacheError.invalidData
        }
        return CacheModule(dataCache: SwiftDataCache(context: context))
    }
}

