//
//  CustomTemplateViewController.swift
//  MemeForge
//
//  Created by APPLE on 9/26/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import UIKit

class CustomTemplateViewController: UIViewController {

    @IBOutlet weak var templateImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPickFromPhotoLib(_ sender: UIButton) {
    }
    
    @IBAction func didTakePhoto(_ sender: UIButton) {
    }
    
    @IBAction func didContinue(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//        let indexPath = memeTableView.indexPath(for: cell)!
//        let meme = memes[indexPath.row]
//        let memeViewController = segue.destination as! MemeViewController
//        memeViewController.meme = meme
//        memeTableView.deselectRow(at: indexPath, animated: true)
    }
}
