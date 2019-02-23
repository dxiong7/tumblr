//
//  PhotoDetailsViewController.swift
//  tumble_demo
//
//  Created by Daniel Xiong on 2/22/19.
//  Copyright © 2019 codepath. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoView: UIImageView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.af_setImage(withURL: url!)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
