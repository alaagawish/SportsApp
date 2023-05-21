//
//  FavouriteViewController.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import UIKit
import Reachability

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var favouriteTable: UITableView!
    
    var leagues: [LeagueLocal] = []
    var favouriteViewModel: FavouriteViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteViewModel = FavouriteViewModel(localSource: LocalSource())
        
        let imgNoItems = UIImageView(frame: CGRect(x: 0, y: (self.view.frame.height - self.view.frame.width)/2, width: self.view.frame.width , height: self.view.frame.width ))
        imgNoItems.image = UIImage(systemName: "star.slash")
        self.view.addSubview(imgNoItems)
        
        favouriteTable.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        favouriteViewModel.refreshFavouriteLeagues = {
            [weak self] in
            DispatchQueue.main.async {
                self?.leagues = self?.favouriteViewModel.leagues ?? []
                self?.favouriteTable.reloadData()
                if self?.leagues.count == 0{
                    imgNoItems.isHidden = false
                    
                    self?.favouriteTable.isHidden = true
                }else{
                    imgNoItems.isHidden = true
                    self?.favouriteTable.isHidden = false
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
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
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            print("Network is available")
            let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "detailsOfLeague") as! LeagueDetailsViewController
            leagueDetails.modalPresentationStyle = .fullScreen
            
            leagueDetails.img = UIImage(systemName: "heart.fill")
            leagueDetails.sport = leagues[indexPath.row].sport
            leagueDetails.leagueID = leagues[indexPath.row].key
            leagueDetails.leagueDisplaying = LeagueLocal(sport: leagues[indexPath.row].sport , youtube: "", name: leagues[indexPath.row].name , logo: leagues[indexPath.row].logo , key: leagues[indexPath.row].key )
            present(leagueDetails, animated: true)
            
        } else {
            print("Network is not available")
            //alert
            let alert : UIAlertController = UIAlertController(title: "Internet Connection", message: "Check connection and try again", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        reachability.whenReachable = { reachability in
            print("Network is available")
        }
        reachability.whenUnreachable = { reachability in
            print("Network is not available")
            
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Delete League from favourites", message: "ARE YOU SURE TO DELETE?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
            
            self?.favouriteViewModel.deleteLeague(name: self?.leagues[indexPath.row].name ?? "", key: self?.leagues[indexPath.row].key ?? 0)
            self?.leagues.remove(at: indexPath.row)
            self?.favouriteTable.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
