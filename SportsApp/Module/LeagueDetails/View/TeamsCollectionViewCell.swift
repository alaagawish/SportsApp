//
//  TeamsCollectionViewCell.swift
//  SportsApp
//
//  Created by Alaa on 21/05/2023.
//

import UIKit
import Kingfisher

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    func setValues(teamName: String, teamLogo: String){
        
        self.teamName.text = teamName
//        self.teamLogo.contentMode = .scaleAspectFill
//        self.teamLogo.layer.cornerRadius =   self.teamLogo.frame.size.width / 2
//        self.teamLogo.layer.masksToBounds = true
        let url = URL(string: teamLogo)
        self.teamLogo.kf.setImage(with: url,
                                  placeholder: UIImage(named: "noImg"))
    }
}
