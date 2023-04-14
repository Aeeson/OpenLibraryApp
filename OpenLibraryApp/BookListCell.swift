import UIKit

class BookListCell: UITableViewCell {
    static let identifier = "BookListCell"
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.text = "Name"
        return label
    }()
    
    private let publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.text = "Publish Date"
        return label
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
    }
    
    private func setConstraints() {
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: -indent).isActive = true
        
        publishDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent).isActive = true
        publishDateLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: -indent).isActive = true
        publishDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
        
        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indent).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indent).isActive = true
    }
    
}

fileprivate let indent: CGFloat = 10
