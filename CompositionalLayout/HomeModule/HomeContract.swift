//
//  HomeContract.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import Combine

// MARK: - Interactor

protocol HomeInteractor {

    func viewDidLoad()
}

// MARK: - Presenter

protocol HomePresenter {

    func configure(with data: [TestDTO])
}

// MARK: - View

protocol HomeView: class {

    var dataSnapshot: HomeDataSource.DataSnapshot { get set }
}
