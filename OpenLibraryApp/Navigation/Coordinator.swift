import UIKit

protocol CoordinatorProtocol {
    func openBooksList()
    func openDetails(for book: Book)
}

final class Coordinator: CoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let assemblyBuilder: AssemblyBuilder
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilder) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func openBooksList() {
        let vc = assemblyBuilder.createBooksListModule(coordinator: self)
        navigationController.viewControllers = [vc]
    }
    
    func openDetails(for book: Book) {
        let vc = assemblyBuilder.createDetailsModule(for: book, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

