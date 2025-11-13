//
//  ImageItem.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import UIKit

class ImageItem: Hashable {
    private let identifier = UUID()
    var image: UIImage
    let url: URL

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    init(image: UIImage, url: URL) {
        self.image = image
        self.url = url
    }
}
