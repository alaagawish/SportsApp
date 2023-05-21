//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionDetails: UICollectionView!
    var leagueDetailsViewModel: LeagueDetailsViewModel!
    var upComing: [Event] = []
    var latest: [Event] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO save sport in user defaults
        leagueDetailsViewModel = LeagueDetailsViewModel(sport: "football")

        leagueDetailsViewModel.upComingArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
 
                self?.upComing = self?.leagueDetailsViewModel.upComingEvents ?? []
                print(self?.upComing[0].eventDay ?? "cant get date in upcoming")
            }
        }
        
        leagueDetailsViewModel.latestArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
 
                self?.latest = self?.leagueDetailsViewModel.latestEvents ?? []
                print(self?.latest[0].eventDay ?? "cant get date in latest")
            }
        }
//        leagueDetailsViewModel.getUpComingEvents()
//        leagueDetailsViewModel.getLatestEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell
        
        return cell
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    

    @IBAction func favButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        
    }
}
