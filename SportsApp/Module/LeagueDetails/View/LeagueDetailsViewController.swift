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
    var teams: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            if index == 0{
                print("upcoming")
                return self.drawUpComingSection()
            }else if index == 1 {
                print("latest")
                return self.drawLatestSection()
                
            }else{
                print("teams")
                return self.drawTeamsSection()
            }
        }
        collectionDetails.setCollectionViewLayout(layout, animated: true)
        
        //TODO save sport in user defaults
        leagueDetailsViewModel = LeagueDetailsViewModel(sport: "football")

        leagueDetailsViewModel.upComingArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
 
                self?.upComing = self?.leagueDetailsViewModel.upComingEvents ?? []
                print(self?.upComing[0].eventDay ?? "cant get date in upcoming")
                self?.collectionDetails.reloadData()
            }
        }
        
        leagueDetailsViewModel.latestArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
 
                self?.latest = self?.leagueDetailsViewModel.latestEvents ?? []
                print(self?.latest[0].eventDay ?? "cant get date in latest")
                self?.collectionDetails.reloadData()
            }
        }
        leagueDetailsViewModel.getUpComingEvents()
        leagueDetailsViewModel.getLatestEvents()
    }
    func drawUpComingSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    func drawLatestSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        // section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 16, bottom: 16, trailing: 0)
        
        
        return section
        
    }
    func drawTeamsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return upComing.count
        }else if section == 1 {
            return latest.count
        }else{
            return teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell
            let event = upComing[indexPath.row]
            cell.setValuesUpComing(date: event.eventDay ?? "", time: event.eventTime ?? "", firstName: event.eventHomeTeam ?? "", secondName: event.eventAwayTeam ?? "", firstLogo: event.homeTeamLogo ?? "", secondLogo: event.awayTeamLogo ?? "")
            return cell
            
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell
          
            let event = latest[indexPath.row]
            cell.setValuesLatest(date: event.eventDay ?? "", time: event.eventTime ?? "", firstName: event.eventHomeTeam ?? "", secondName: event.eventAwayTeam ?? "", firstLogo: event.homeTeamLogo ?? "", secondLogo: event.awayTeamLogo ?? "", result: event.finalResult ?? "")
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! TeamsCollectionViewCell
            cell.setValues(teamName: "hhh", teamLogo: "")
            return cell
        }
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         
        return 3
    }
    

    @IBAction func favButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        
    }
}
