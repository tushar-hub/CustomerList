//
//  CustomerRowView.swift
//  CustomerListApp
//
//  Created by tushar kasana on 31/03/25.
//

import SwiftUI

struct CustomerRowView: View {
    var customer: Customer
    var toggleAction: () -> Void
    var deleteAction: () -> Void
    
    // Local state for handling the edit alert.
    @State private var showEditAlert = false
    @State private var showActionSheet = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Display red marker if there are any location errors.
            if let errors = customer.LocationErrors, !errors.isEmpty {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.red)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(customer.DisplayName)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(customer.Locations.first?.City ?? "No City")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Ellipsis button to open the action sheet.
            Button(action: {
                showActionSheet = true
            }) {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90)) // Vertical appearance.
                    .padding()
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select Action"), buttons: [
                    .default(Text("Edit"), action: {
                        // Show an alert to simulate editing.
                        showEditAlert = true
                    }),
                    .default(Text(customer.IsActive ? "Deactivate" : "Activate"), action: toggleAction),
                    .destructive(Text("Delete"), action: deleteAction),
                    .cancel()
                ])
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        // Reverse backgrounds: Active = Black, Inactive = White (or light gray).
        .background(customer.IsActive ? Color.black : Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        // Edit alert to show that the edit button is working.
        .alert(isPresented: $showEditAlert) {
            Alert(title: Text("Edit Action"),
                  message: Text("Edit tapped for \(customer.DisplayName)"),
                  dismissButton: .default(Text("OK")))
        }
    }
}
