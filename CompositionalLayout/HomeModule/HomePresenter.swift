//
//  HomePresenter.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 14.03.2021.
//

import Foundation

class HomePresenterImpl: HomePresenter {

    typealias Section = HomeDataSource.Section
    typealias RowData = HomeDataSource.RowData

    weak var view: HomeView?

    init(view: HomeView) {
        self.view = view
    }

    func configure(with data: [TestDTO]) {
        var snapshot = HomeDataSource.DataSnapshot()
        data.enumerated().forEach { index, data in
            let section: Section = {
                switch data.category {
                case .courusel:
                    return .courusel(index)
                case .fullWidth:
                    return .fullWidth(index)
                case .grid:
                    return .grid(index)
                }
            }()

            let rows: [RowData] = data.items.map { RowData(id: $0.id, color: $0.color) }
            snapshot.appendSections([section])
            snapshot.appendItems(rows, toSection: section)
            view?.dataSnapshot = snapshot
        }
    }
}
