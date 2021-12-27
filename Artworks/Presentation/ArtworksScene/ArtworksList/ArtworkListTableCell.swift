//
//  ArtworkListTableCell.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit
import SDWebImage

class ArtworkListTableCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    static let Id = "ArtworkListTableCell"
    let favoriteImageString = "heart.fill"
    let notFavoriteImageString = "heart"
    private var isFavorite = false {
        didSet{
            let imageString = isFavorite ? favoriteImageString : notFavoriteImageString
            favoriteImageView.image = UIImage(systemName: imageString)
        }
    }
    var url: String = ""
    weak var delegate: ArtworkListTableCellDelegate?
    var viewModel: ArtworksItemViewProtocol?{
        didSet{
            guard let viewModel = viewModel else { return }
            title.text = viewModel.title
            source.text = viewModel.source
            date.text = viewModel.date
            desc.text = viewModel.desc
            artworkImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isFavorite = false
        setupFavoriteImageView()
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        source.font = UIFont.preferredFont(forTextStyle: .subheadline)
        source.textColor = .systemBlue
        date.textColor = .secondaryLabel
        date.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    fileprivate func setupFavoriteImageView() {
        favoriteImageView.tintColor = .systemRed
        favoriteImageView.contentMode = .scaleAspectFit
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(favoriteBtnTapped)))
        favoriteImageView.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func favoriteBtnTapped(_ sender: Any) {
        isFavorite.toggle()
        delegate?.cell(urlString: url, updatesFavoriteState: isFavorite)
    }
}
