import UIKit

protocol BooksListViewProtocol: AnyObject {
    func showBooks(_ books: [Book])
}

class BooksListViewController: UIViewController, BooksListViewProtocol {
    
    // MARK: - Properties
    
    var presenter: BooksListPresenterProtocol!
    
    private lazy var booksList: UITableView = {
        let tableView = UITableView()
        tableView.register(BookListCell.self, forCellReuseIdentifier: BookListCell.identifier)
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 150
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
       
    }
    
    // MARK: - Public
    
    func showBooks(_ books: [Book]) {
        // Add logic
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

extension BooksListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add logic
        let book = Book()
        presenter.openDetails(for: book)
    }
   
}

