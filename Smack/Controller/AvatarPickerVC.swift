//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Francisco Salom on 19/10/17.
//  Copyright © 2017 Francisco Salom. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //Outlets
    @IBOutlet weak var segmentAva: UISegmentedControl!
    @IBOutlet weak var avaCollectionView: UICollectionView!
    
    //Variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avaCollectionView.delegate = self
        avaCollectionView.dataSource = self
    }

    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChange(_ sender: Any) {
        
        if segmentAva.selectedSegmentIndex == 0{
            avatarType = AvatarType.dark
        } else {
            avatarType = AvatarType.light
        }
        avaCollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.getAvatarType(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numeroColumnas : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numeroColumnas = 4
        }
        let spaceBetweenCell : CGFloat = 10
        let padding : CGFloat = 40
        
        let cellDimension = ((avaCollectionView.bounds.width - padding) - (numeroColumnas - 1) * spaceBetweenCell) / numeroColumnas
        
        return CGSize(width: cellDimension, height: cellDimension)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            dataUserService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
            dismiss(animated: true, completion: nil)
        } else {
            dataUserService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
