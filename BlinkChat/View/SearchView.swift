//
//  SearchView.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/1/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewModel: SearchViewModel

    var body: some View {
        List {
            ForEach(viewModel.filteredUsers(), id: \.email) { user in
                SearchTableViewCell(user: user)
                    .listRowSeparator(.visible)
                    .onTapGesture {
                        viewModel.addUser(user)
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}
