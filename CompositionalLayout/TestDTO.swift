//
//  TestDTO.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 14.03.2021.
//

import UIKit

struct TestDTO {

    enum Category {
        case grid
        case courusel
        case fullWidth
    }

    let category: Category
    let items: [(id: UUID, color: UIColor)]
}
