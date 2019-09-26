//
//  MemeViewController.swift
//  MemeForge
//
//  Created by APPLE on 9/25/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import UIKit
import AlamofireImage

class MemeViewController: UIViewController {
    
    @IBOutlet weak var memeImage: UIImageView!
    //var captions = [UITextField]()
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: meme.url) else { return }
        memeImage.af_setImage(withURL: url)
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDrag(pan: UIPanGestureRecognizer) {
        let loc = pan.location(in: self.view)
        pan.view?.center = loc
    }
    
    @IBAction func didAddCaption(_ sender: UIButton) {
        let center = memeImage.center
        let caption: UITextField = UITextField(frame: CGRect(x: center.x / 2, y: center.y / 2, width: 175.00, height: 50.00));
        caption.backgroundColor = UIColor.black
        caption.borderStyle = .roundedRect
        caption.textColor = UIColor.white
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(textFieldDrag(pan:)))
        caption.addGestureRecognizer(gesture)
        //memeImage.addSubview(caption)
        view.addSubview(caption)
    }
    
    @IBAction func didForge(_ sender: UIButton) {
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
