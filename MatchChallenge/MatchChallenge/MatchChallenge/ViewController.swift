//
//  ViewController.swift
//  MatchChallenge
//
//  Created by Jogamaya Panigrahi on 7/13/18.
//  Copyright © 2018 Jogamaya Panigrahi. All rights reserved.
//

import UIKit
let API_URL = "https://randomuser.me/api/?results=50"
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UINavigationControllerDelegate {
 
    
    @IBOutlet var profileListTableView: UITableView?
    var activityIndicator = UIActivityIndicatorView()
    var profiles:[Result]?
    var profilesCount = 0
    var images:[Data] = []
    //Custom animation controller
    let customAnimationController = CustomAnimationController()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Reset the highlighted cells array
        ProfileDataSingleton.sharedInstance.reset()
        // Do any additional setup after loading the view, typically from a nib.
        //Register custom cell
        profileListTableView?.register(UINib(nibName: "ProfileViewCustomCell", bundle: nil), forCellReuseIdentifier: "ProfileViewCustomCell")
        //Get profiles  from API
        self.fetchProfiles()
        self.navigationController?.delegate = self
        
    }
    /*
     Function to fetch 50 profiles
     */
    func fetchProfiles(){
        let urlValue = API_URL
        guard let url = URL(string: urlValue) else {return}
        //Display Activity view
        self.showActivityView()
        URLSession.shared.dataTask(with: url){(data,response,error) in
            //If there is an error, display an alert
            if let errorObject = error{
                let alertView = UIAlertController.init(title: "Error", message: errorObject.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    self.hideActivityView()
                }))
                self.present(alertView, animated: true,completion: nil)
                return
            }
            guard let data = data else{return}
            do{
                let profileData = try JSONDecoder().decode(Profile.self, from: data)
                DispatchQueue.main.async {
                    self.hideActivityView()
                    //Populate data source array for table view
                    self.profiles = profileData.results
                    self.profilesCount = profileData.results.count
                    //Populate image data array
                    for profile in profileData.results{
                        if let urlString = URL(string: profile.picture.large),let data = try? Data(contentsOf:urlString ){
                            self.images.append(data)
                        }
                    }
                    //If there are no profiles , display an alert
                    if(self.profilesCount==0){
                        let alertView = UIAlertController.init(title: "", message: "ProfilesNotAvailable", preferredStyle: UIAlertControllerStyle.alert)
                        self.present(alertView, animated: true,completion: nil)
                        return
                    }
                    else{
                        //Reload table view
                        self.profileListTableView?.reloadData()
                    }

                }
            }catch let exception{
                print(exception)
            }
            
            }.resume()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnCount = 0
        if let count = self.profiles?.count{
            returnCount = count
        }
        return returnCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCustomCell", for: indexPath) as? ProfileViewCustomCell{
            //Set the index of cell as index path.Add this index path to highlighted cells array of singleton
            cell.cellIndex = indexPath
            //Check the highlighted cells array and highlight those cells whose index is present in the array
            if( ProfileDataSingleton.sharedInstance.cellsHighlighted.contains(indexPath)){
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.2696054711, blue: 0.278931234, alpha: 1)
            }
            else{
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            //set the properties of the cell
            if let profiles = self.profiles{
                let imageDataArray = self.images
                let profileObject = profiles[indexPath.row]
                cell.setProperties(withFirstName: profileObject.name.first, lastName: profileObject.name.last, and:imageDataArray[indexPath.row] )
            }
             return cell
        }
        else{
            return UITableViewCell()
        }
       

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Display profiles details view
        if let profiles = self.profiles{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let detailsView = sb.instantiateViewController(withIdentifier: "ProfileDetailsView") as? ProfileDetailsView{
                detailsView.profile = profiles[indexPath.row]
                detailsView.imageData = self.images[indexPath.row]
                self.navigationController?.pushViewController(detailsView, animated: true)
            }

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     Function to show activity view
     */
    func showActivityView(){
        activityIndicator.frame = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 200, height: 200)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    /*
     Function to hide activity view
     */
    func hideActivityView(){
        activityIndicator.stopAnimating()
    }
    //Set custom animation for navigation
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customAnimationController.isReverseDirection = operation == .pop
        return customAnimationController
    }
    
}

