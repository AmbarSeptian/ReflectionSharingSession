//
//  Model.swift
//  ReflectionSharingSession
//
//  Created by Ambar Septian on 14/01/21.
//

import UIKit

struct Badge {
    let title: String
    let image: UIImage
}

struct ProductCard {
    let id: Int
    let name: String
    let labels: [Badge]
}

enum Example {
  case foo(Int)
  case bar(String)
}
