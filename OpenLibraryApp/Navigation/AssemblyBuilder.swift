import UIKit

struct AssemblyBuilder {

    // let networkService = NetworkService()

    func createBooksListModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let view = BooksListViewController()
        let presenter = BooksListPresenter(booksListView: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func createDetailsModule(for book: Book, coordinator: CoordinatorProtocol) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(book: book, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
