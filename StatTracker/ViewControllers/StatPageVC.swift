//
//  StatPageVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/10/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class StatPageVC: UIViewController {
    
    var UserCharacterStats = [GameModes]() {
        didSet {
            print(UserCharacterStats[0].pvpQuickplay)
            print("Stats Received")
        }
    }
    
    var currentUserBeingDisplayed = String()
    var currentDisplayedCharacterIndex = Int() {
        didSet {
            rootCollectionView.reloadData()
        }
    }
    
    let cellId = "statCell"
    let rootCV_CellPadding = 16
    
    lazy var  rootCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PvPStatDisplayCollectionView.self, forCellWithReuseIdentifier: cellId)

        return collectionView
    }()
    
//    lazy var changebutton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Change", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .black
//        button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
//        return button
//    }()
    
    @objc func toggle() {
        if currentDisplayedCharacterIndex != UserCharacterStats.count - 1 { currentDisplayedCharacterIndex += 1 }
        else { currentDisplayedCharacterIndex = 0 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        currentDisplayedCharacterIndex = 0
        setUpRootCollectionView()
    }
    
    func setUpRootCollectionView() {
        view.addSubview(rootCollectionView)
//        view.addSubview(changebutton)
        rootCollectionView.backgroundColor = .lightGray
        
        // Constriants
        rootCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rootCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rootCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rootCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
//        changebutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        changebutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        changebutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        changebutton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
        // Delegate & Data Source
        rootCollectionView.delegate = self
        rootCollectionView.dataSource = self
    }
}


// Collection View Extenstions
extension StatPageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(400))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PvPStatDisplayCollectionView
        cell.pvpStats = self.UserCharacterStats
        cell.currentIndex = self.currentDisplayedCharacterIndex
        cell.setUpCellCollectionView()
        return cell
    }
}
