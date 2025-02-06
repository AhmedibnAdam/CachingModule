//
//  SecureCaching.swift
//  MoviesDB
//
//  Created by Ahmad on 05/02/2025.
//

import Foundation
import SwiftUI
import SwiftData

public protocol SecureCaching {
    func set(_ value: String, forKey key: String) async throws
    func get(forKey key: String) async throws -> String?
    func removeValue(forKey key: String) async throws
}





