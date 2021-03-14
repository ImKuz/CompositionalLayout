//
//  HomeLayoutProvider.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import UIKit
import Combine

final class LayoutProvider {

    private var sections = [HomeDataSource.Section]()
    private var disposeBag = [AnyCancellable]()

    init(sectionsPublisher: AnyPublisher<[HomeDataSource.Section] ,Never>) {
        sectionsPublisher
            .assign(to: \.sections, on: self)
            .store(in: &disposeBag)
    }

    func makeSeciton(
        _ section: Int,
        enviroment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        guard sections.count > 0 else { return nil }
        switch sections[section] {
        case .courusel:
            return makeCarouselLayout()
        case .fullWidth:
            return makeFullWidthLayout()
        case .grid:
            return makeGridLayout()
        }
    }
}

// MARK: - Section Layouts

private extension LayoutProvider {

    // MARK: - Full width

    func makeFullWidthLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200.0)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [ item ])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: Layout.inset,
            leading: Layout.inset,
            bottom: .zero,
            trailing: Layout.inset
        )

        return section
    }

    // MARK: - Carousel

    func makeCarouselLayout() -> NSCollectionLayoutSection {
        let fraction: CGFloat = 1.0 / 3.0

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fraction),
            heightDimension: .fractionalWidth(fraction)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.7
                let maxScale: CGFloat = 1.1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        section.contentInsets = .init(
            top: Layout.inset,
            leading: Layout.inset,
            bottom: .zero,
            trailing: Layout.inset
        )

        return section
    }

    // MARK: - Grid

    func makeGridLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.33),
            heightDimension: .absolute(100)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(500)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: Layout.inset,
            leading: Layout.inset,
            bottom: .zero,
            trailing: Layout.inset
        )

        return section
    }
}

private extension LayoutProvider {

    enum Layout {
        static let inset: CGFloat = 18
    }
}
