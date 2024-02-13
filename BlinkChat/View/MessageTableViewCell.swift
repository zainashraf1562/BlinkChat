//
//  MessageTableViewCell.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/4/24.
//

import SwiftUI

struct MessageTableViewCell: View {
    let viewModel: MessageTableViewCellViewModel
    let uiImage:UIImage?
    var body: some View {
        HStack {
            if viewModel.isCurrentUser {
                Spacer()
                Text(viewModel.message.message)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                if let image = uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                }
            } else {
                if let image = uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                }
                Text(viewModel.message.message)
                    .padding(10)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
