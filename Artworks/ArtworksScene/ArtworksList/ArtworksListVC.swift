//
//  ArtworksListVC.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//  Copyright © 2021 Muhammad Adam. All rights reserved.
//

import UIKit

class ArtworksListVC: UIViewController, ArtworksListViewProtocol {
    // MARK: Outlets
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
        print("hello")
        presenter.viewDidLoad()
    }

    // MARK: Actions 

    // MARK: Methods
}

extension ArtworksListVC: StoryboardInstantiable{}


public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
