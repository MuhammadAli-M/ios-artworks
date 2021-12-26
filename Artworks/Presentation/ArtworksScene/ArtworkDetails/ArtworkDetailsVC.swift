//
//  ArtworkDetailsVC.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit
import SDWebImage

protocol ThemeProtocol{
    var backgroundColor: UIColor { get }
    var font: UIFont { get }
}

struct GoodSightTheme: ThemeProtocol{
    let backgroundColor: UIColor = .systemGreen
    let font: UIFont = .systemFont(ofSize: 12)
}

struct BadSightTheme: ThemeProtocol{
    let backgroundColor: UIColor = .systemRed
    let font: UIFont = .systemFont(ofSize: 30)
}

struct DefaultTheme:ThemeProtocol{
    let backgroundColor: UIColor = .systemBackground
    let font: UIFont = .systemFont(ofSize: 16)
}

class ArtworkDetailsVC: UIViewController, StoryboardInstantiable {
    
    // MARK: Outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var artistInfoStackView: UIStackView!
    @IBOutlet weak var artworkTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    lazy var seeMoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("See more", for: .normal)
        btn.addTarget(self, action: #selector(seeMoreBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator1 = UIActivityIndicatorView(style: .medium)
        return activityIndicator1
    }()
    
    // MARK: Properties
    var presenter: ArtworkDetailsPresenterProtocol!
    let theme: ThemeProtocol = DefaultTheme()
    
    // MARK: LifeCycle
    class func create(with presenter: ArtworkDetailsPresenterProtocol) -> ArtworkDetailsVC {
        let vc = ArtworkDetailsVC.instantiateViewController()
        vc.presenter = presenter
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(viewModel: presenter.getViewModel())
    }
    
    // MARK: Actions
    @objc func seeMoreBtnTapped(){
        debugLog("")
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        artistInfoStackView.addArrangedSubview(activityIndicator)
        seeMoreBtn.isHidden = true
        activityIndicator.startAnimating()
        
        presenter.fetchArtistInfo()
    }

    // MARK: Methods
    func addSeeMoreBtnUI(){ // Added it from code as a workaround as the sizing from code was not working properly.
        seeMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        artistInfoStackView.addArrangedSubview(seeMoreBtn)
    }
    
    func updateUI(viewModel: ArtworksItemViewModel){
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
        case .success(let info):
            
            let info =
"""
Birth: \(info.birthDate),
Death: \(info.deathDate)
"""
            artistName.text?.append(contentsOf: "\n" + info)
            activityIndicator.stopAnimating()
            
        case .failure(let error):
            errorLog("\(error.localizedDescription)")
            // TODO: Handle Error
        }
    }
}


