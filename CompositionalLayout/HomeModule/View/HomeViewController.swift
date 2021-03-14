//
//  HomeViewController.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import UIKit
import Combine

final class HomeViewController: UIViewController, HomeView {

    // MARK: - UI Components

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = .white
        return collectionView
    }()

    // MARK: - Properties

    private var layoutProvider: LayoutProvider?
    private var dataSource: HomeDataSource.DiffableDataSource?
    private var cancelBag = [AnyCancellable]()

    @Published var dataSnapshot = HomeDataSource.DataSnapshot()
    var interactor: HomeInteractor?

    // MARK: - Lifecycle

    override func loadView() {
        setupCollectionView()
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    // MARK: - Setup

    private func setupCollectionView() {

        let sectionsPublisher = $dataSnapshot
            .map(\.sectionIdentifiers)
            .eraseToAnyPublisher()

        let layoutProvider = LayoutProvider(sectionsPublisher: sectionsPublisher)
        let layout = UICollectionViewCompositionalLayout(sectionProvider: layoutProvider.makeSeciton)
        self.layoutProvider = layoutProvider

        dataSource = HomeDataSource.make(collectionView)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.registerClassForCell(TestCell.self)
    }

    private func setupBinding() {
        defer { interactor?.viewDidLoad() }

        $dataSnapshot
            .sink { [weak dataSource] in dataSource?.apply($0) }
            .store(in: &cancelBag)
    }
}
