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
        label.backgroundColor = .green
        label.text = "Name"
        return label
    }()
    
    let publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.text = "Publish Date"
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    private func setConstraints() {
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        publishDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        publishDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
        publishDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
        coverImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        
        activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
    }
    
}

fileprivate let indent: CGFloat = 10
