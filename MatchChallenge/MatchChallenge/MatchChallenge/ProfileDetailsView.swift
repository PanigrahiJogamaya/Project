//
//  ProfileDetailsView.swift
//  MatchChallenge
//
//  Created by Jogamaya Panigrahi on 7/15/18.
//  Copyright © 2018 Jogamaya Panigrahi. All rights reserved.
//

import Foundation
import UIKit
class ProfileDetailsView:UIViewController{
     var profile:Result?
     var imageData: Data?
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var nameValue: UILabel?
    @IBOutlet weak var ageValue: UILabel?
    @IBOutlet weak var phoneNumberValue: UILabel?
    @IBOutlet weak var emailValue: UILabel?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = imageData,let profile = profile{
            self.profileImage?.image = UIImage(data: image)
            self.nameValue?.text = "\(profile.name.first)  \(profile.name.last)"
            self.ageValue?.text = "\(profile.dob.age)"
            self.phoneNumberValue?.text = "\(profile.phone)"
            self.emailValue?.text = "\(profile.email)"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

