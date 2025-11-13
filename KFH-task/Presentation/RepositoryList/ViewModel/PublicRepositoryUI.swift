//
//  PublicRepositoryUI.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import UIKit
import Foundation

class PublicRepositoryUI: Identifiable, ObservableObject {
    @Published var image: UIImage

    let id: Int
    let title: String
    let ownerName: String
    let description: String?
    let ownerAvatar: ImageItem
    let repository: RepositoryModel

    func fetchImage() {
        ImageCache.public.load(url: ownerAvatar.url as NSURL, item: ownerAvatar) { fetchedItem, image in
            if let img = image, img != fetchedItem.image {
                self.image = img
                self.ownerAvatar.image = img
            }
        }
    }

    func onReuse() {
        ImageCache.public.cancelLoad(ownerAvatar.url as NSURL)
        self.image = UIImage(systemName: "photo")!
        self.ownerAvatar.image = UIImage(systemName: "photo")!
    }

    init(id: Int, title: String, ownerName: String, description: String?, ownerAvatarURL: String, repository: RepositoryModel) {
        self.id = id
        self.title = title
        self.ownerName = ownerName
        self.description = description
        self.repository = repository
        self.ownerAvatar = ImageItem(
            image: UIImage(systemName: "photo")!,
            url: URL(string: ownerAvatarURL)!
        )
        self.image = UIImage(systemName: "photo")!
    }
}