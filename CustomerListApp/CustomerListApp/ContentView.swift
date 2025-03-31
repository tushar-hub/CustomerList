//
//  ContentView.swift
//  CustomerListApp
//
//  Created by tushar kasana on 31/03/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CustomerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Search field for filtering by name or city.
                TextField("Search by name or city", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding([.leading, .trailing, .top])
                
                // List of customer tiles.
                List {
                    ForEach(viewModel.filteredCustomers) { customer in
                        CustomerRowView(
                            customer: customer,
                            toggleAction: {
                                viewModel.toggleActive(for: customer)
                            },
                            deleteAction: {
                                viewModel.delete(customer: customer)
                            }
                        )
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Customers")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
