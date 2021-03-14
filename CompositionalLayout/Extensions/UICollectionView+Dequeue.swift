import UIKit

extension UICollectionView {

    func registerClassForCell(_ cellClass: UICollectionReusableView.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.defaultIdentifier)
    }

    func dequeueReusableCellWithType<T: UICollectionViewCell>(
        _ cellClass: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        dequeueReusableCell(withReuseIdentifier: cellClass.defaultIdentifier, for: indexPath) as? T
    }

    func dequeueConfigurableCell<T: ConfigurableCell>(
        _ cellClass: T.Type,
        data: T.CellData,
        indexPath: IndexPath
    ) -> T? {
        let cell = dequeueReusableCell(
            withReuseIdentifier: cellClass.defaultIdentifier,
            for: indexPath
        ) as? T

        cell?.configure(with: data)
        return cell
    }
}
