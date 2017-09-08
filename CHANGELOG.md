# Change Log
All notable changes to this project will be documented in this file.

---

## [Unreleased]
### Changed
- Optimize diff algorithm used by `ObservableArray` for common methods such as `insert(at:)`, `remove(at:)` etc...
- Fix a bug where `manager` was not set correctly on `Item` or `Section`
- Fix memory ownership of `ObservableArray` for Swift 4

## [1.1.0]
### Added
- Support `TableViewManager` as `manager` property of `Item` and `Section`
- Support `UIScrollViewDelegate` from `TableViewManager` via `scrollDelegate`

### Changed
- Move `UITableViewDataSource` and `UITableViewDelegate` implementations from `TableViewManager` to `TableViewKitDataSource` and `TableViewKitDelegate` which are now the properties: `dataSource` and `delegate`, respectively.
- Method `Item.section(in:)` has been renamed to `Item.section`
- Method `Item.indexPath(in:)` has been renamed to `Item.indexPath`
- Method `Item.reload(in:with:)` has been renamed to `Item.reload(with:)`
- Method `Item.select(in:animated:scrollPosition:)` has been renamed to `Item.select(animated:scrollPosition:)`
- Method `Item.select(in:animated:scrollPosition:)` has been renamed to `Item.select(animated:scrollPosition:)`
- Method `Item.deselect(in:animated:)` has been renamed to `Item.deselect(animated:)`
- Method `Section.index(in:)` has been renamed to `Section.index`
