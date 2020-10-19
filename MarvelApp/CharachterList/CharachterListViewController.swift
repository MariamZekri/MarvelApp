//
//  CharachterListViewController.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import UIKit
import SVProgressHUD
import SystemConfiguration
import UIScrollView_InfiniteScroll

class CharachterListViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var searchHero: UISearchBar!
    @IBOutlet weak var heroTableView: UITableView!
    
    // MARK: - Helper variables
    let callNetwork = GenericService()
    var allCharacters = [Character?]()

    // MARK: - Paging
    var limit : Int = 5
    let offset : Int = 1
    let pageSize : Int = 5
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        heroTableView.delegate = self
        heroTableView.dataSource = self
        heroTableView.register(UINib(nibName: "charachterTableViewCell", bundle: nil), forCellReuseIdentifier: "charachterTableViewCell")
       
        self.getCharactersData()
        heroTableView.addInfiniteScroll { (tableView) -> Void in
            // update table view
            self.limit += self.pageSize
         
        self.getCharactersData(fromInfinite: true)
            // finish infinite scroll animation
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Helper Method To Get Data Networl Call
    func getCharactersData(fromInfinite:Bool = false){
        if !fromInfinite{
        SVProgressHUD.show(withStatus: "Loading...")
        }
        self.callNetwork.fetchCharacteres(limit: limit, offset: offset) { (results) in
            guard let result = results else{
                return
            }
            self.allCharacters = result
            DispatchQueue.main.async {
                self.heroTableView.reloadData()
                SVProgressHUD.dismiss()
                self.heroTableView.finishInfiniteScroll()
            }
        }
    }
    

    // MARK: - Actions
    @IBAction func searchAction(_ sender: Any) {
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
            vc?.allCharacters = allCharacters
            self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

// MARK: - Confirm TableView Protocols
extension CharachterListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charachterTableViewCell", for: indexPath ) as! charachterTableViewCell
        cell.setData(obj: allCharacters[indexPath.row]!)
        
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



