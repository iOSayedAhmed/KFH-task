//
//  RepoDetailsView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import SwiftUI

struct RepoDetailsView: View {
    let repository: RepositoryModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    RepoHeaderView(repository: repository)
                    RepoInfoView(repository: repository)
                    Spacer(minLength: 50)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct RepoHeaderView: View {
    let repository: RepositoryModel

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: repository.owner.avatarURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)

            VStack(spacing: 8) {
                Text(repository.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)

                Text(repository.fullName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct RepoInfoView: View {
    let repository: RepositoryModel

    var body: some View {
        VStack(spacing: 16) {
            if let description = repository.description, !description.isEmpty {
                InfoCard(title: "Description", content: description)
            }

            InfoCard(title: "Owner", content: repository.owner.login)
            InfoCard(title: "Owner Type", content: repository.owner.type.rawValue)
            InfoCard(title: "Repository Type", content: repository.welcomePrivate ? "Private" : "Public")

            if repository.fork {
                InfoCard(title: "Fork", content: "This is a forked repository")
            }

            Button(action: {
                openURL(repository.htmlURL)
            }) {
                HStack {
                    Image(systemName: "safari")
                    Text("View on GitHub")
                }
                .font(.body)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
    }

    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

struct InfoCard: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}

#Preview {
    RepoDetailsView(repository: RepositoryModel(
        id: 1,
        nodeID: "node123",
        name: "Sample Repository",
        fullName: "user/sample-repository",
        welcomePrivate: false,
        owner: RepositoryOwnerModel(
            login: "sampleuser",
            id: 123,
            nodeID: "owner123",
            avatarURL: "https://avatars.githubusercontent.com/u/123?v=4",
            gravatarID: "",
            url: "https://api.github.com/users/sampleuser",
            htmlURL: "https://github.com/sampleuser",
            followersURL: "https://api.github.com/users/sampleuser/followers",
            followingURL: "https://api.github.com/users/sampleuser/following",
            gistsURL: "https://api.github.com/users/sampleuser/gists",
            starredURL: "https://api.github.com/users/sampleuser/starred",
            subscriptionsURL: "https://api.github.com/users/sampleuser/subscriptions",
            organizationsURL: "https://api.github.com/users/sampleuser/orgs",
            reposURL: "https://api.github.com/users/sampleuser/repos",
            eventsURL: "https://api.github.com/users/sampleuser/events",
            receivedEventsURL: "https://api.github.com/users/sampleuser/received_events",
            type: .user,
            siteAdmin: false
        ),
        htmlURL: "https://github.com/user/sample-repository",
        description: "This is a sample repository description that demonstrates the layout.",
        fork: false,
        url: "https://api.github.com/repos/user/sample-repository",
        forksURL: "",
        keysURL: "",
        collaboratorsURL: "",
        teamsURL: "",
        hooksURL: "",
        issueEventsURL: "",
        eventsURL: "",
        assigneesURL: "",
        branchesURL: "",
        tagsURL: "",
        blobsURL: "",
        gitTagsURL: "",
        gitRefsURL: "",
        treesURL: "",
        statusesURL: "",
        languagesURL: "",
        stargazersURL: "",
        contributorsURL: "",
        subscribersURL: "",
        subscriptionURL: "",
        commitsURL: "",
        gitCommitsURL: "",
        commentsURL: "",
        issueCommentURL: "",
        contentsURL: "",
        compareURL: "",
        mergesURL: "",
        archiveURL: "",
        downloadsURL: "",
        issuesURL: "",
        pullsURL: "",
        milestonesURL: "",
        notificationsURL: "",
        labelsURL: "",
        releasesURL: "",
        deploymentsURL: ""
    ))
}
