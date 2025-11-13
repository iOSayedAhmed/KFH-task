//
//  GitHubRepositoriesView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import SwiftUI
import Combine

struct GitHubRepositoriesView: View {
    @EnvironmentObject private var diContainer: DIContainer
    @StateObject private var viewModel: RepositoryListViewModel
    @State private var searchQuery = ""

    init() {
        self._viewModel = StateObject(wrappedValue: RepositoryListViewModel(useCase: DIContainer.shared.publicRepositoryUseCase))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repos) { repository in
                    NavigationLink(destination: RepoDetailsView(repository: repository.repository)) {
                        RepositoryRowView(repository: repository)
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .searchable(text: $searchQuery, prompt: "Find Repo...")
            .onChange(of: searchQuery) { newQuery in
                viewModel.search(query: newQuery)
            }
            .refreshable {
                viewModel.fetchPublicReposList()
            }
        }
        .onAppear {
            viewModel.fetchPublicReposList()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "")
            )
        }
    }
}

// Custom Repository Row View
struct RepositoryRowView: View {
    @StateObject var repository: PublicRepositoryUI

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(uiImage: repository.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 8) {
                Text(repository.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(repository.ownerName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let description = repository.description, !description.isEmpty {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            Spacer()
        }
        .padding(.vertical, 4)
        .onAppear {
            repository.fetchImage()
        }
    }
}

#Preview {
    GitHubRepositoriesView()
        .environmentObject(DIContainer.shared)
}
