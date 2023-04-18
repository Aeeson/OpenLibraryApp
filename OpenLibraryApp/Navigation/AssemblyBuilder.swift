import UIKit

struct AssemblyBuilder {

    private let networkService = NetworkService()

    func createBooksListModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let view = BooksListViewController()
        let presenter = BooksListPresenter(booksListView: view, coordinator: coordinator, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    func createDetailsModule(for book: Book, coordinator: CoordinatorProtocol) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(book: book, detailsView: view, coordinator: coordinator, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
