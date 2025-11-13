//
//  RepositoryRow.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import SwiftUI
import Combine

struct RepositoryRow: View {
    @StateObject var repository: PublicRepositoryUI

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(uiImage: repository.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
                .clipped()
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text(repository.title)
                Text(repository.ownerName)
            }
        }
        .padding(.top, 4)
        .padding(.bottom, 4)
        .onAppear(perform: { repository.fetchImage() })
    }
}