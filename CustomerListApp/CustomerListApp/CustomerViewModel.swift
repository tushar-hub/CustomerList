//
//  CustomerViewModel.swift
//  CustomerListApp
//
//  Created by tushar kasana on 31/03/25.
//

import Foundation
import Combine

class CustomerViewModel: ObservableObject {
    // Published properties update the UI automatically.
    @Published var customers: [Customer] = []
    @Published var searchText: String = ""
    
    // Computed property to filter customers by name or city.
    var filteredCustomers: [Customer] {
        if searchText.isEmpty {
            return customers
        } else {
            return customers.filter { customer in
                let nameMatch = customer.DisplayName.lowercased().contains(searchText.lowercased())
                let cityMatch = customer.Locations.first?.City?.lowercased().contains(searchText.lowercased()) ?? false
                return nameMatch || cityMatch
            }
        }
    }
    
    init() {
        loadCustomers()
    }
    
    // Load JSON data from the main bundle.
    func loadCustomers() {
        if let url = Bundle.main.url(forResource: "customerSample", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(CustomerResponse.self, from: data)
                DispatchQueue.main.async {
                    self.customers = response.customer
                }
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
    
    // Toggle a customer's active state.
    func toggleActive(for customer: Customer) {
        if let index = customers.firstIndex(where: { $0.CustomerId == customer.CustomerId }) {
            customers[index].IsActive.toggle()
            // Reassign the array to force a UI refresh.
            customers = customers
        }
    }
    
    // Delete a customer from the list.
    func delete(customer: Customer) {
        customers.removeAll { $0.CustomerId == customer.CustomerId }
    }
    
    // Edit action placeholder.
    func edit(customer: Customer) {
        // You can later implement an edit screen here.
        print("Edit action triggered for: \(customer.DisplayName)")
    }
}
