//
//  ConfigurableCell.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import UIKit

protocol ConfigurableCell: UICollectionViewCell {

    associatedtype CellData

    func configure(with cellData: CellData)
}
