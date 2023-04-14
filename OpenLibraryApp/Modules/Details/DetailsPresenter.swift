protocol DetailsPresenterProtocol: AnyObject {
    
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    let book: Book
    let coordinator: CoordinatorProtocol
    
    required init(book: Book, coordinator: CoordinatorProtocol) {
        self.book = book
        self.coordinator = coordinator
    }
    
}
