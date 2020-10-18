//
//  CharachterListViewController.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import UIKit
import SVProgressHUD

class CharachterListViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var searchHero: UISearchBar!
    @IBOutlet weak var heroTableView: UITableView!
    
    // MARK: - Helper variables
    let callNetwork = GenericService()
    var allCharacters = [Character?]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        heroTableView.delegate = self
        heroTableView.dataSource = self
        heroTableView.register(UINib(nibName: "charachterTableViewCell", bundle: nil), forCellReuseIdentifier: "charachterTableViewCell")
        getCharactersData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Helper Method To Get Data Networl Call
    func getCharactersData(){
        SVProgressHUD.show(withStatus: "Loading...")
        self.callNetwork.fetchCharacteres() { (results) in
            self.allCharacters = results!
            DispatchQueue.main.async {
                self.heroTableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    
}

// MARK: - Confirm TableView Protocols
extension CharachterListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charachterTableViewCell", for: indexPath ) as! charachterTableViewCell
        
        cell.heroNameLbl.text = allCharacters[indexPath.row]?.name
        
        let imageUrl : String  = (self.allCharacters[indexPath.row]?.thumbnail?.path)!
        let imageExtension : String  = (self.allCharacters[indexPath.row]?.thumbnail?.thumbnailExtension)!
        
        
        let imageFullPath = imageUrl+"."+imageExtension
        
        cell.heroImg.downloaded(from: imageFullPath)
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        heroTableView.deselectRow(at: indexPath, animated: false)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharachterDetailsViewController") as? CharachterDetailsViewController
        
        vc?.character = allCharacters[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
