//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionDetails: UICollectionView!
    
    var leagueDetailsViewModel: LeagueDetailsViewModel!
    var upComing: [Event] = []
    var latest: [Event] = []
    var sport: String!
    var leagueID: Int!
    var teams: [Team] = []
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
        
        leagueDetailsViewModel = LeagueDetailsViewModel(sport: sport,leagueId: leagueID)
        
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)) // Set the header size
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    func drawLatestSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        // section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25)) // Set the header size
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
        
    }
    func drawTeamsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension:  .absolute(UIScreen.main.bounds.height/6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25)) // Set the header size
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return upComing.count
        }else if section == 1 {
            return latest.count
        }else{
             teams = []
            for item in upComing {
                self.teams.append(Team(teamLogo: item.awayTeamLogo, teamName: item.eventAwayTeam, teamKey: item.awayTeamKey))
                self.teams.append(Team(teamLogo: item.homeTeamLogo, teamName: item.eventHomeTeam, teamKey: item.homeTeamKey))
            }
            for item in latest {
                self.teams.append(Team(teamLogo: item.awayTeamLogo, teamName: item.eventAwayTeam, teamKey: item.awayTeamKey))
                self.teams.append(Team(teamLogo: item.homeTeamLogo, teamName: item.eventHomeTeam, teamKey: item.homeTeamKey))
            }
            teams = Array(Set(teams))
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamsCollectionViewCell
            cell.setValues(teamName: teams[indexPath.row].teamName ?? "", teamLogo: teams[indexPath.row].teamLogo ?? "")
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
            
            if indexPath.section == 0 {
                
                header.headerTitle.text = "Up Coming Events"
            }else if indexPath.section == 1{
                header.headerTitle.text = "Latest Results"
            }else{
                header.headerTitle.text = "Teams"
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    
    @IBAction func favButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
