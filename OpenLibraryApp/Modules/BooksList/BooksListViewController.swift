import UIKit

protocol BooksListViewProtocol: AnyObject {
    func showBooks(_ books: [Book])
    func showCover(data: Data, cellID: IndexPath)
}

final class BooksListViewController: UIViewController, BooksListViewProtocol {
    
    // MARK: - Properties
    
    var presenter: BooksListPresenterProtocol!
    
    private var books = [Book]()
    private var booksCover = [UIImage?]()
    
    private lazy var booksList: UITableView = {
        let tableView = UITableView()
        tableView.register(BookListCell.self, forCellReuseIdentifier: BookListCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
        presenter.getBooksList()
        
        // add loading
       
    }
    
    // MARK: - Public
    
    func showBooks(_ books: [Book]) {
        self.books = books
        self.booksCover = Array(repeating: nil, count: self.books.count)
        booksList.reloadData()
    }
    
    func showCover(data: Data, cellID: IndexPath) {
        booksCover[cellID.row] = UIImage(data: data)
        booksList.reloadData()
    }
    
    
    // MARK: - Private
    
    private func setupView() {
        view.addSubview(booksList)
        view.backgroundColor = .white
        booksList.delegate = self
        booksList.dataSource = self
    }
    
    private func setConstraints() {
        booksList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        booksList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        booksList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        booksList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

    // MARK: - <UITableViewDelegate,UITableViewDataSource>

extension BooksListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListCell.identifier, for: indexPath) as! BookListCell
        cell.titleLabel.text = books[indexPath.row].title
        cell.publishDateLabel.text = String(books[indexPath.row].firstPublishYear)
        cell.coverImageView.image = booksCover[indexPath.row]
        if booksCover[indexPath.row] == nil {
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            presenter.getCover(id: String(books[indexPath.row].coverID), size: "S", cellID: indexPath)
        } else {
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        presenter.openDetails(for: book)
    }
   
}

