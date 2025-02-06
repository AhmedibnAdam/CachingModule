//
//  CacheError.swift
//  CachingModule
//
//  Created by Ahmad on 05/02/2025.
//

import Foundation

public enum CacheError: Error {
    case invalidData
    case keychainError(OSStatus)
    case encodingError
    case decodingError
}
