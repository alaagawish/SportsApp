//
//  EventCollectionViewCell.swift
//  SportsApp
//
//  Created by Alaa on 21/05/2023.
//

import UIKit
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var secondTeamLogo: UIImageView!
    
    @IBOutlet weak var secondTeamName: UILabel!
    
    @IBOutlet weak var firstTeamLogo: UIImageView!
    
    @IBOutlet weak var firstTeamName: UILabel!
    
    @IBOutlet weak var result: UILabel!
    
    func setValuesUpComing(date: String, time: String, firstName: String, secondName: String, firstLogo: String, secondLogo: String){
        self.timeLabel.text = time
        self.dateLabel.text = date
        self.firstTeamName.text = firstName
        self.secondTeamName.text = secondName
        let urlFirst = URL(string: firstLogo)
        self.firstTeamLogo.kf.setImage(with: urlFirst,
                                       placeholder: UIImage(named: "noImg"))
        let url = URL(string: secondLogo)
        self.secondTeamLogo.kf.setImage(with: url,
                                        placeholder: UIImage(named: "noImg"))
        self.result.isHidden = true
    }
    
    func setValuesLatest(date: String, time: String, firstName: String, secondName: String, firstLogo: String, secondLogo: String, result: String){
        self.timeLabel.text = time
        self.dateLabel.text = date
        self.firstTeamName.text = firstName
        self.secondTeamName.text = secondName
        let urlFirst = URL(string: firstLogo)
        self.firstTeamLogo.kf.setImage(with: urlFirst,
                                       placeholder: UIImage(named: "noImg"))
        let url = URL(string: secondLogo)
        self.secondTeamLogo.kf.setImage(with: url,
                                        placeholder: UIImage(named: "noImg"))
        self.result.text = result
        self.result.isHidden = false
        
    }
}
