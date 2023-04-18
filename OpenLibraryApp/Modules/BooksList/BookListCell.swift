import UIKit

final class BookListCell: UITableViewCell {
    static let identifier = "BookListCell"
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(publishDateLabel)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(authorLabel)
    }
    
    private func setConstraints() {
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: indent).isActive = true
        authorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        publishDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        publishDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
        publishDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
        coverImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
    }
    
}

fileprivate let indent: CGFloat = 10
