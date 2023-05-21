//
//  FavouriteViewController.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favouriteTable: UITableView!
    
    var leagues: [LeagueLocal] = []
    var favouriteViewModel: FavouriteViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteViewModel = FavouriteViewModel(localSource: LocalSource())
        
        favouriteTable.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        
        
        favouriteViewModel.refreshFavouriteLeagues = {
            [weak self] in
            DispatchQueue.main.async {
                self?.leagues = self?.favouriteViewModel.leagues ?? []
                self?.favouriteTable.reloadData()
            }
        }
        let _ = favouriteViewModel.getLeagues()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        
        
        cell.leagueName.text = leagues[indexPath.row].name
        
        let url = URL(string: leagues[indexPath.row].logo)
        cell.leagueImage.kf.setImage(with: url,
                                     placeholder: UIImage(named: "noImg"))
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        favouriteViewModel.returnFavouriteLeague = {
            [weak self] in
            DispatchQueue.main.async {
                print("selected item is \(self?.favouriteViewModel.league?.name ?? "")")
            }
            
        }
        let _ = favouriteViewModel.getSelectedLeague(name: leagues[indexPath.row].name,
                                                     key: self.leagues[indexPath.row].key )
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Delete League from favourites", message: "ARE YOU SURE TO DELETE?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
            print("delete begin")
            self?.leagues.remove(at: indexPath.row)
            self?.favouriteViewModel.deleteLeague(name: self?.leagues[indexPath.row].name ?? "", key: self?.leagues[indexPath.row].key ?? 0)
            self?.favouriteTable.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
