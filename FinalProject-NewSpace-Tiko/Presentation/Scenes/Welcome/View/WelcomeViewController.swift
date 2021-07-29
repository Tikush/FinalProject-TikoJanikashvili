
//
//  WelcomeViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK: - Private Properties
    private var datasource: WelcomeDataSource!
    private var welcomeData: WelcomeData!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDataSource()
    }
    
    //MARK: - Private Functions
    private func setupLayout(){
        collectionView.registerNib(class: WelcomeCell.self)
        collectionView.backgroundColor = .clear
        navigationController?.isNavigationBarHidden = true
        loginButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        registerButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func setupDataSource(){
        welcomeData = WelcomeData()
        datasource = WelcomeDataSource(collectionView: collectionView, welcomeData: welcomeData.welcomeData, pageControl: pageControl)
    }

    // MARK: - IBActions
    @IBAction private func login(_ sender: Any) {
        coordinator?.login(with: self)
    }
    
    @IBAction private func register(_ sender: Any) {
        coordinator?.register(with: self)
    }
}
