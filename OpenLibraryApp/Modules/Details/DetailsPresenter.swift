protocol DetailsPresenterProtocol: AnyObject {
    func getInfo()
    func loadCover()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    // MARK: - Properties
    
    let book: Book
    let coordinator: CoordinatorProtocol
    let detailsView: DetailsViewProtocol
    let networkService: NetworkServiceProtocol
    
    // MARK: - LifeCycle
    
    required init(book: Book, detailsView: DetailsViewProtocol, coordinator: CoordinatorProtocol, networkService: NetworkServiceProtocol) {
        self.book = book
        self.detailsView = detailsView
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    // MARK: - Public
    
    func getInfo() {
        networkService.getBookInfo(for: book.key) { result in
            switch result {
            case .success(let details):
                self.detailsView.showDetails(for: self.book, with: details)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadCover() {
        networkService.getCover(id: String(book.coverID), size: "L") { result in
            switch result {
            case .success(let data):
                self.detailsView.showCover(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
