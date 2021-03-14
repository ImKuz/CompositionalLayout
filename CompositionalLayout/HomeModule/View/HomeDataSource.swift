//
//  HomeDataSource.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import UIKit

struct HomeDataSource {

    enum Section: Hashable {

        case fullWidth(Int)
        case grid(Int)
        case courusel(Int)
    }

    typealias RowData = TestCellData
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, RowData>
    typealias DataSnapshot = NSDiffableDataSourceSnapshot<Section, RowData>

    static func make(_ collectionView: UICollectionView) -> DiffableDataSource {
        DiffableDataSource(
            collectionView: collectionView,
            cellProvider: cellProvider
        )
    }

    private static func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ rowData: RowData
    ) -> UICollectionViewCell {
        collectionView.dequeueConfigurableCell(
            TestCell.self,
            data: rowData,
            indexPath: indexPath
        ) ?? UICollectionViewCell()
    }
}
