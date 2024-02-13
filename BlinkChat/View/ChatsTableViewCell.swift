//
//  ChatsTableViewCell.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 2/1/24.
//

import SwiftUI

struct ChatsTableViewCell: View {
    @State var viewModel: ChatTableViewCellViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: viewModel.chatImageURL) { imagePhase in
                switch imagePhase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    case .failure(_):
                        // Placeholder or error view when loading fails
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    @unknown default:
                        // Placeholder for unknown states
                        Image(systemName: "person.circle")
                    }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.chatLog.otherUsername)
                    .font(.headline)
                    .foregroundColor(.orange)
//                Text(viewModel.lastMessage)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}
