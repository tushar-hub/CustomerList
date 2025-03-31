//
//  Customer.swift
//  CustomerListApp
//
//  Created by tushar kasana on 31/03/25.
//
import Foundation

// Top-level structure matching your JSON.
struct CustomerResponse: Codable {
    let customer: [Customer]
}

// Model for each customer. Conforming to Identifiable for list display.
struct Customer: Codable, Identifiable {
    var id: String { CustomerId }
    let CustomerId: String
    let DisplayName: String
    var IsActive: Bool
    let Locations: [Location]
    let LocationErrors: [LocationError]?
}

// Model for a customer location.
struct Location: Codable {
    let City: String?
}

// Model for location errors.
struct LocationError: Codable {
    let ErrorType: String?
    let ErrorMessage: String?
}

