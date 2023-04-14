import UIKit

protocol DetailsViewProtocol: AnyObject {
    
}

class DetailsViewController: UIViewController, DetailsViewProtocol {
    
    // MARK: - Properties
    
    var presenter: DetailsPresenterProtocol!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.backgroundColor = .cyan
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fisrt, \n Second, \n Third \n"
        label.backgroundColor = .cyan
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Publish Date"
        label.backgroundColor = .cyan
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top"
        label.backgroundColor = .cyan
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    // MARK: - Public
    
    
    
    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(publishDateLabel)
        view.addSubview(ratingLabel)
        view.addSubview(coverImageView)
    }
    
    private func setConstraints() {
        ratingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: indent).isActive = true
        ratingLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -indent).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: indent).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: indent).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: ratingLabel.rightAnchor, constant: -indent).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: indent).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: indent).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -indent).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        
        publishDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: indent).isActive = true
        publishDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: indent).isActive = true
        publishDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -indent).isActive = true
        
        coverImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: indent).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -indent).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -indent).isActive = true
    }
}

fileprivate let indent: CGFloat = 16
