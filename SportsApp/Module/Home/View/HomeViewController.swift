//
//  ViewController.swift
//  SportsApp
//
//  Created by Alaa on 17/05/2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let sports = [Sport(name: "Football", image: "football"),
                    Sport(name: "Basketball", image: "basketball"),
                    Sport(name: "Cricket", image: "cricket"),
                    Sport(name: "Tennis", image: "tennis")]
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCollectionViewCell
        
        cell.sportImg.image = UIImage(named: sports[indexPath.row].image)
        cell.sportName.text = sports[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.499, height: self.view.frame.height * 0.24)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(sports[indexPath.row].name.lowercased())
         
        if  let leagues = self.storyboard?.instantiateViewController(withIdentifier:  "leagues") as? LeaguesViewController{
            
            leagues.sport = sports[indexPath.row].name.lowercased()
             
            navigationController?.pushViewController(leagues, animated: true)
           
        }
        
    }

}

