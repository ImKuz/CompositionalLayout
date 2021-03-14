//
//  TestCell.swift
//  PageApp
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import UIKit

struct TestCellData: Hashable {

    let id: UUID
    let color: UIColor
}

class TestCell: UICollectionViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}

extension TestCell: ConfigurableCell {

    func configure(with cellData: TestCellData) {
        backgroundColor = cellData.color
    }
}
