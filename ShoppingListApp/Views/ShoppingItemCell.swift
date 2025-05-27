import UIKit

final class ShoppingItemCell: UITableViewCell {

    static let reuseID = "ShoppingItemCell"

    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let categoryLabel = UILabel()
    private let checkmark = UIImageView(image: UIImage(systemName: "checkmark.circle"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ShoppingItem) {
        nameLabel.text = item.name
        quantityLabel.text = "Qty: \(item.quantity)"
        categoryLabel.text = "\(item.category)"
        checkmark.isHidden = !item.isCompleted
    }

    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [nameLabel, quantityLabel, categoryLabel])
        stack.axis = .vertical
        stack.spacing = 4

        contentView.addSubview(stack)
        contentView.addSubview(checkmark)

        stack.translatesAutoresizingMaskIntoConstraints = false
        checkmark.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmark.widthAnchor.constraint(equalToConstant: 24),
            checkmark.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
