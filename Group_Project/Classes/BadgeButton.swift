import UIKit

class BadgeButton: UIButton {
    
    // A UILabel that will serve as the badge.
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 10 // For a circular badge
        label.clipsToBounds = true
        label.isHidden = true  // Hide by default
        return label
    }()
    
    // This property updates the badge when set.
    var badgeValue: String? {
        didSet {
            updateBadge()
        }
    }
    
    // Called when loaded from the storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBadge()
    }
    
    // Add the badge label as a subview and set its constraints.
    private func setupBadge() {
        addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            // Position the badge at the top-right corner of the button.
            badgeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -5),
            badgeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // Update the badge's appearance based on badgeValue.
    private func updateBadge() {
        if let text = badgeValue, !text.isEmpty, text != "0" {
            badgeLabel.text = text
            badgeLabel.isHidden = false
        } else {
            badgeLabel.isHidden = true
        }
    }
}
