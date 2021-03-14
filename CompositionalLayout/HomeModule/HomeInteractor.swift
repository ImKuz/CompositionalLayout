//
//  HomeInteractor.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 14.03.2021.
//

import UIKit

final class HomeInteractorImpl: HomeInteractor {
    let presenter: HomePresenter

    init(presenter: HomePresenter) {
        self.presenter = presenter
    }

    func viewDidLoad() {
        configure()
    }
}

private extension HomeInteractorImpl {
    
    func configure() {
        let data = [
            TestDTO(
                category: .fullWidth,
                items: createItems(count: 1, color: .systemYellow)
            ),
            TestDTO(
                category: .courusel,
                items: createItems(count: 10, color: .systemTeal)
            ),
            TestDTO(
                category: .grid,
                items: createItems(count: 9, color: .systemRed)
            ),
            TestDTO(
                category: .fullWidth,
                items: createItems(count: 1, color: .systemGreen)
            ),
            TestDTO(
                category: .grid,
                items: createItems(count: 9, color: .systemBlue)
            ),
            TestDTO(
                category: .courusel,
                items: createItems(count: 10, color: .systemTeal)
            ),
            TestDTO(
                category: .grid,
                items: createItems(count: 9, color: .systemGray)
            ),
            TestDTO(
                category: .fullWidth,
                items: createItems(count: 1, color: .systemPink)
            ),
        ]

        presenter.configure(with: data)
    }

    private func createItems(count: Int, color: UIColor) -> [(UUID, UIColor)] {
        var array = [(UUID, UIColor)]()
        for _ in 1...count {
            array.append((UUID(), color))
        }
        return array
    }
}
