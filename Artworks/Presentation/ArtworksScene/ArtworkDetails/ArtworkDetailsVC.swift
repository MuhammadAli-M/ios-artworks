//
//  ArtworkDetailsVC.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit
import SDWebImage

class ArtworkDetailsVC: UIViewController, StoryboardInstantiable {
    
    // MARK: Outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var artistInfoStackView: UIStackView!
    @IBOutlet weak var artworkTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    private lazy var seeMoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("See more", for: .normal)
        btn.addTarget(self, action: #selector(seeMoreBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator1 = UIActivityIndicatorView(style: .medium)
        return activityIndicator1
    }()
    
    // MARK: Properties
    private var presenter: ArtworkDetailsPresenterProtocol!
    private let theme: ThemeProtocol = DefaultTheme()
    
    // MARK: LifeCycle
    class func create(with presenter: ArtworkDetailsPresenterProtocol) -> ArtworkDetailsVC {
        let vc = ArtworkDetailsVC.instantiateViewController()
        vc.presenter = presenter
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(viewModel: presenter.getViewModel())
    }
    
    // MARK: Actions
    @objc private func seeMoreBtnTapped(){
        debugLog("")
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        artistInfoStackView.addArrangedSubview(activityIndicator)
        seeMoreBtn.isHidden = true
        activityIndicator.startAnimating()
        
        presenter.fetchArtistInfo()
    }

    // MARK: Methods
    private func addSeeMoreBtnUI(){ // Added it from code as the storyboard button sizing from code was not working properly.
        seeMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        artistInfoStackView.addArrangedSubview(seeMoreBtn)
    }
    
    private func updateUI(viewModel: ArtworksItemViewModel){
        artworkTitle.text = viewModel.title
        mainImageView.sd_setImage(with: viewModel.imageUrl)
        
        
        guard let artistTitle = viewModel.artistTitle else {
            themeUpdated(theme: theme)
            return
        }
        
        addSeeMoreBtnUI()
        
        artistName.text = "By: " + artistTitle
        themeUpdated(theme: theme)
    }
    
}

extension ArtworkDetailsVC:ArtworkDetailsViewProtocol{
    
    func themeUpdated(theme: ThemeProtocol){
        view.backgroundColor = theme.backgroundColor
        [artworkTitle,
         artistName,
        ].forEach{ $0.font = theme.font}
        
        seeMoreBtn.titleLabel?.font = theme.font
    }
    
    func artistInfoFetched(with result:Result<ArtistViewModel, Error> ){
        switch result{
        case .success(let model):
            
            let info =
"""
Birth: \(model.birthDate),
Death: \(model.deathDate)
"""
            artistName.text?.append(contentsOf: "\n" + info)
            activityIndicator.stopAnimating()
            
        case .failure(let error):
            errorLog("\(error.localizedDescription)")
            activityIndicator.stopAnimating()
            seeMoreBtn.isHidden = false
        }
    }
}
