//
//  CharachterDetailsViewController.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/19/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import UIKit

class CharachterDetailsViewController: UIViewController {
    
    // MARK: - Helper variables
    var character: Character?

    // MARK: - Outlets
    @IBOutlet weak var selectedHereImg: UIImageView!
    @IBOutlet weak var heroNameLbl: MySubTitleLabel!
    @IBOutlet weak var heroDescLbl: MySubTitleLabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Helper Method To Set Data
    func setData(){
        heroNameLbl.text = character?.name
        if character?.description == "" {
           heroDescLbl.text = "Description is empty"
        }else{
        heroDescLbl.text = character?.description
        }
        
        let imageUrl : String  = (self.character?.thumbnail?.path)!
        let imageExtension : String  = (self.character?.thumbnail?.thumbnailExtension)!
        
        let imageFullPath = imageUrl+"."+imageExtension
        selectedHereImg.downloaded(from: imageFullPath)

    }

    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
