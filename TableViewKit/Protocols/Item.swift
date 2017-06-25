import Foundation

/// A type that represent an item to be displayed
/// defining the `drawer` and the `height`
public protocol Item: class, AnyEquatable {

    /// The `drawer` of the item
    static var drawer: AnyCellDrawer { get }

    /// The `height` of the item
    var height: Height? { get }
}

public extension Item where Self: Equatable {
    func equals(_ other: Any?) -> Bool {
        if let other = other as? Self {
            return other == self
        }
        return false
    }
}

// swiftlint:disable:next identifier_name
private var ItemTableViewManagerKey: UInt8 = 0

extension Item {

    public internal(set) var manager: TableViewManager? {
        get {
            return objc_getAssociatedObject(self, &ItemTableViewManagerKey) as? TableViewManager
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &ItemTableViewManagerKey,
                                     newValue as AnyObject,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension Item {

    public func equals(_ other: Any?) -> Bool {
        if let other = other as AnyObject? {
            return other === self
        }
        return false
    }

    /// Dynamic height with an estimate value of 44.0
    public var height: Height? {
        return .dynamic(44.0)
    }

    /// Returns the `section` of the `item`
    ///
    /// - returns: The `section` of the `item` or `nil` if not present
    public var section: Section? {
        guard let indexPath = indexPath else { return nil }
        return manager?.sections[indexPath.section]
    }

    /// Returns the `indexPath` of the `item`
    ///
    /// - returns: The `indexPath` of the `item` or `nil` if not present
    public var indexPath: IndexPath? {
        guard let manager = manager else { return nil }
        for section in manager.sections {
            guard
                let sectionIndex = section.index,
                let rowIndex = section.items.index(of: self) else { continue }
            return IndexPath(row: rowIndex, section: sectionIndex)
        }
        return nil
    }

    /// Reload the `item` with an `animation`
    ///
    /// - parameter animation: A constant that indicates how the reloading is to be animated
    ///
    /// - returns: The `section` of the `item` or `nil` if not present
    public func reload(with animation: UITableViewRowAnimation = .automatic) {
        guard let indexPath = indexPath else { return }
        let section = manager?.sections[indexPath.section]
        section?.items.callback?(.updates([indexPath.row]))
    }

}

public extension Collection where Self.Iterator.Element == Item {
    /// Return the index of the `element` inside a collection of items
    func index(of element: Item) -> Self.Index? {
        return index(where: { $0 === element })
    }
}
