import Foundation

protocol BooksListPresenterProtocol: AnyObject {
    func getBooksList()
    func openDetails(for book: Book)
    
}

class BooksListPresenter: BooksListPresenterProtocol {
    
    // MARK: - Properties
    
    private let booksListView: BooksListViewProtocol
    private let coordinator: CoordinatorProtocol
    
    private var booksList = [Book]()
    
    // MARK: - LifeCycle
    
    required init(booksListView: BooksListViewProtocol, coordinator: CoordinatorProtocol) {
        self.booksListView = booksListView
        self.coordinator = coordinator
    }
    
    // MARK: - Public
    
    func getBooksList() {
        // Add network logic
    }
    
    func openDetails(for book: Book) {
        coordinator.openDetails(for: book)
    }
    
}
