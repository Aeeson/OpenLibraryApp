import UIKit

protocol BooksListViewProtocol: AnyObject {
    func showBooks(_ books: [Book])
    func showCover(data: Data, cellID: IndexPath)
    func showAlert(message: String)
}

final class BooksListViewController: UIViewController, BooksListViewProtocol {
    
    // MARK: - Properties
    
    var presenter: BooksListPresenterProtocol!
    
    private var books = [Book]()
    private var booksCover = [UIImage?]()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var booksListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookListCell.self, forCellReuseIdentifier: BookListCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.layer.cornerRadius = 12
        tableView.tableHeaderView = UIView()
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.CustomColors.separator
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
        presenter.getBooksList()
        activityIndicatorView.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }
    
    // MARK: - Public
    
    func showBooks(_ books: [Book]) {
        self.books = books
        self.booksCover = Array(repeating: nil, count: self.books.count)
        booksListTableView.reloadData()
        if !books.isEmpty {
            activityIndicatorView.stopAnimating()
            UIView.transition(
                with: booksListTableView,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.booksListTableView.isHidden = false
                })
        }
    }
    
    func showCover(data: Data, cellID: IndexPath) {
        booksCover[cellID.row] = UIImage(data: data)
        booksListTableView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: UIAlertAction.Style.default, handler: nil
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Private
    
    private func setupView() {
        view.addSubview(booksListTableView)
        view.addSubview(activityIndicatorView)
        view.backgroundColor = UIColor.CustomColors.secondaryBackground
        self.navigationItem.title = "Books list"
        booksListTableView.delegate = self
        booksListTableView.dataSource = self
    }
    
    private func setConstraints() {
        booksListTableView.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: indent
        ).isActive = true
        booksListTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: indent
        ).isActive = true
        booksListTableView.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -indent
        ).isActive = true
        booksListTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -indent
        ).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(
            equalTo: booksListTableView.centerXAnchor
        ).isActive = true
        activityIndicatorView.centerYAnchor.constraint(
            equalTo: booksListTableView.centerYAnchor
        ).isActive = true
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.CustomColors.secondaryBackground
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.CustomColors.primaryLabel ?? UIColor.black
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.CustomColors.primaryLabel ?? UIColor.black
        ]
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func showTableView() {
        view.addSubview(booksListTableView)
        
        booksListTableView.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: indent
        ).isActive = true
        booksListTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: indent
        ).isActive = true
        booksListTableView.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -indent
        ).isActive = true
        booksListTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -indent
        ).isActive = true
    }
}

// MARK: - <UITableViewDelegate,UITableViewDataSource>

extension BooksListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BookListCell.identifier, for: indexPath
        ) as! BookListCell
        cell.titleLabel.text = books[indexPath.row].title
        cell.publishDateLabel.text = "Published: \(String(books[indexPath.row].firstPublishYear))"
        cell.coverImageView.image = booksCover[indexPath.row]
        cell.authorLabel.text = books[indexPath.row].authors.first?.name
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.CustomColors.primaryBackground
        if booksCover[indexPath.row] == nil {
            cell.activityIndicator.startAnimating()
            presenter.getCover(
                id: String(books[indexPath.row].coverID),
                size: "S", cellID: indexPath
            )
        } else {
            cell.activityIndicator.stopAnimating()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        presenter.openDetails(for: book)
    }
}

fileprivate let indent: CGFloat = 16
