//
//  ProfileViewCustomCell.swift
//  MatchChallenge
//
//  Created by Jogamaya Panigrahi on 7/14/18.
//  Copyright © 2018 Jogamaya Panigrahi. All rights reserved.
//

import Foundation
import UIKit
class ProfileViewCustomCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var firstName: UILabel?
    @IBOutlet weak var lastName: UILabel?
    var cellIndex:IndexPath?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setProperties(withFirstName firstName:String ,lastName:String , and  imageData:Data) {
        self.firstName?.text = firstName
        self.lastName?.text = lastName
        self.profileImageView?.image = UIImage(data: imageData)

    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    @IBAction func highLightProfile(_ sender: UIButton) {
        if(sender.tag == 0){
            self.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.2696054711, blue: 0.278931234, alpha: 1)
            ProfileDataSingleton.sharedInstance.cellsHighlighted.append(self.cellIndex!)
            sender.tag = 1
        }
        else{
            self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            ProfileDataSingleton.sharedInstance.cellsHighlighted = ProfileDataSingleton.sharedInstance.cellsHighlighted.filter{$0 != self.cellIndex!}
            sender.tag = 0
        }
    }
}
