//
//  ArtworksListVC.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//  Copyright © 2021 Muhammad Adam. All rights reserved.
//

import UIKit

class ArtworksListVC: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var artworksTableView: UITableView!
    
    // MARK: Properties
	var presenter: ArtworksListPresenterProtocol!

    class func create(with presenter: ArtworksListPresenterProtocol) -> ArtworksListVC {
        let vc = ArtworksListVC.instantiateViewController()
        vc.presenter = presenter
        return vc
    }
    // MARK: LifeCycle
	override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleAndBarButton()
        setupTableView(table: artworksTableView)
        presenter.viewDidLoad()
    }

    // MARK: Actions 

    // MARK: Methods
    fileprivate func setupTitleAndBarButton() {
        title = presenter.getTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension ArtworksListVC: StoryboardInstantiable{}


extension ArtworksListVC: UITableViewDelegate, UITableViewDataSource{
    func setupTableView(table: UITableView){
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 200
        table.rowHeight = UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getArtworksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtworkListTableCell.Id) as? ArtworkListTableCell else {return UITableViewCell()}
        
        cell.viewModel = presenter.viewModel(forCellAtIndex: indexPath.row)
        
        return cell
    }
}

extension ArtworksListVC: ArtworksListViewProtocol{
    func didFinishLoading(with error: Error?) { // TODO: Add error handling
        artworksTableView.reloadData()
    }
}
