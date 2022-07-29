//
//  HomeViewController.swift
//  FurEternity
//
//  Created by Saurabh on 08/05/22.
//


import UIKit


class HomeViewController: UIViewController  {
    
   // @IBOutlet weak var energyBarView: EnergyView!
    
   // let collectionCellCache = NSCache<NSString, CharSquarCollectionCell>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "me"
        
        self.navigationController?.navigationBar.isHidden = true
        

      
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
}


