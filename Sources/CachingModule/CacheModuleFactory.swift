//
//  CacheModuleFactory.swift
//  CachingModule
//
//  Created by Ahmad on 06/02/2025.
//

import SwiftData

// MARK: - Factory
@MainActor
public enum CacheModuleFactory {
    @available(macOS 14, *)
    public static func make(context: ModelContext, service: String) throws -> CacheModule {
        return CacheModule(secureCache: KeychainSecureCache(service: service), dataCache: SwiftDataCache(context: context))
    }
}
