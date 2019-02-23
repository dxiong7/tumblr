//
//  ViewController.swift
//  tumble_demo
//
//  Created by patrick on 2019/2/15.
//  Copyright © 2019 codepath. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Network request snippet
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                //print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.section]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.photoImageView.af_setImage(withURL: url!)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        
        let label = UILabel(frame: CGRect(x: 50, y: 0, width: 320, height: 50))
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.text = "date goes here"
        /*let label = UILabel(frame: CGRect(x: 50, y: 0, width: 320, height: 50))
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.section]
        if let date = post["date"] as? [[String: Any]] {
            label.text = date
        }*/
        // Add a UILabel for the date here
        // Use the section number to get the right URL

        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass the selected movie to the details screen
        
        let detailsViewController = segue.destination as! PhotoDetailsViewController
        
        let cell = sender as! PhotoCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.section]
        //let photos = post["photos"]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            detailsViewController.url = URL(string: urlString)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    

}

