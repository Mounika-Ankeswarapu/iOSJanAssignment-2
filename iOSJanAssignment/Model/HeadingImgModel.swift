//
//  HeadingImgModel.swift
//  iOSJanAssignment
//
//  Created by Mounika Ankeswarapu on 24/01/25.
//

import Foundation
import UIKit

struct HeadingImgModel {
    var img:String?
}

// MARK: - Carousel
struct CarouselStruct: Codable {
    let image, name: String?
    let list: [List]?
}

// MARK: - List
struct List: Codable {
    let image, name: String?
}
