import Foundation

protocol BooksListPresenterProtocol: AnyObject {
    func getBooksList()
    func openDetails(for book: Book)
    func getCover(id: String, size: String, cellID: IndexPath)
    
}

final class BooksListPresenter: BooksListPresenterProtocol {
    
    // MARK: - Properties
    
    private let booksListView: BooksListViewProtocol
    private let coordinator: CoordinatorProtocol
    private let networkService: NetworkServiceProtocol
    
    private var booksList = [Book]()
    
    // MARK: - LifeCycle
    
    required init(booksListView: BooksListViewProtocol, coordinator: CoordinatorProtocol, networkService: NetworkServiceProtocol) {
        self.booksListView = booksListView
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    // MARK: - Public
    
    func getBooksList() {
        networkService.getBooksList(subject: "history") { result in
            switch result {
            case .success(let books):
                self.booksListView.showBooks(books)
            case .failure(let error):
                self.booksListView.showAlert(message: error.localizedDescription)
            }
        }
        booksListView.showBooks([])
    }
    
    func getCover(id: String, size: String, cellID: IndexPath) {
        networkService.getCover(id: id, size: size) { result in
            switch result {
            case .success(let data):
                self.booksListView.showCover(data: data, cellID: cellID)
            case .failure(let error):
                self.booksListView.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func openDetails(for book: Book) {
        coordinator.openDetails(for: book)
    }
    
}
