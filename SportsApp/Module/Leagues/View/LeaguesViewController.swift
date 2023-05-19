//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var leaguesTable: UITableView!
    
    var leagues: [League] = []
    var sport: String?
    var leagueViewModel: LeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueViewModel = LeaguesViewModel(sport: sport ?? "football")
        
        leaguesTable.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        leagueViewModel.passArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
                self?.leagues = self?.leagueViewModel.leagues ?? []
                self?.leaguesTable.reloadData()
                
            }
        }
        leagueViewModel.getData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueName.text = leagues[indexPath.row].leagueName
                 
        let url = URL(string: leagues[indexPath.row].leagueLogo ?? "")
        cell.leagueImage.kf.setImage(with: url,
                              placeholder: UIImage(named: "cup"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
  

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
}
