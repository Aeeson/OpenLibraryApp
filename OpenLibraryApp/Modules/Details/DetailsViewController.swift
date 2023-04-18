import UIKit

protocol DetailsViewProtocol: AnyObject {
    func showDetails(for book: Book, with details: Details)
    func showCover(data: Data)
    func showAlert(message: String)
}

final class DetailsViewController: UIViewController, DetailsViewProtocol {
    
    // MARK: - Properties
    
    var presenter: DetailsPresenterProtocol!
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColors.primaryBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.CustomColors.primaryLabel
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.CustomColors.primaryLabel
        return label
    }()
    
    private lazy var publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.CustomColors.secondaryLabel
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.CustomColors.primaryLabel
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var scroolView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
        presenter.getInfo()
        presenter.loadCover()
    }
    
    // MARK: - Public
    
    func showDetails(for book: Book, with details: Details) {
        titleLabel.text = book.title
        descriptionLabel.text = details.description
        publishDateLabel.text = "Published at \(book.firstPublishYear)"
        authorLabel.text = book.authors.first?.name
    }
    
    func showCover(data: Data) {
        activityIndicatorView.stopAnimating()
        coverImageView.image = UIImage(data: data)
        coverImageView.isHidden = false
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = UIColor.CustomColors.secondaryBackground
        view.addSubview(scroolView)
        self.navigationItem.title = "Details"
        
        scroolView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publishDateLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(coverImageView)
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func setConstraints() {
        scroolView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroolView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scroolView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.leftAnchor.constraint(equalTo: scroolView.leftAnchor, constant: indent).isActive = true
        contentView.topAnchor.constraint(equalTo: scroolView.topAnchor, constant: indent).isActive = true
        contentView.rightAnchor.constraint(equalTo: scroolView.rightAnchor, constant: -indent).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scroolView.bottomAnchor, constant: -indent).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width - 2 * indent).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: -indent).isActive = true
        
        authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: indent).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: -indent).isActive = true
        
        publishDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        publishDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: indent).isActive = true
        publishDateLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: -indent).isActive = true
        
        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: indent).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
    }
}

fileprivate let indent: CGFloat = 16
