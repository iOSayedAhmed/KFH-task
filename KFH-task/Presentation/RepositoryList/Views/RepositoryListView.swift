//
//  RepositoryListView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Combine
import SwiftUI

struct RepositoryListView: View {

    @ObservedObject var viewModel: RepositoryListViewModel
    @State private var query = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repos) { repository in
                    NavigationLink(destination: RepositoryRow(repository: repository)) {
                        RepositoryRow(repository: repository)
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .searchable(text: $query, prompt: "Find Repo...")
            .onChange(of: query) { newQuery in
                viewModel.search(query: newQuery)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
                viewModel.fetchPublicReposList()
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "")
            )
        })
    }
}