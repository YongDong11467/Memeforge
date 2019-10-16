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
    //var meme = Meme(id: <#T##String#>, name: "default", url: <#T##String#>, width: <#T##Int#>, height: <#T##Int#>, box_count: <#T##Int#>)
    var meme: Meme?
    var customImage: Image?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let meme = self.meme else {
            memeImage.image = customImage
            return
        }
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
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func didForge(_ sender: UIButton) {
        guard let saveMeme = memeImage.image else {return}
        UIImageWriteToSavedPhotosAlbum(saveMeme, self, nil, nil)
    }
    
//    func generateImageWithText(text: String) -> UIImage? {
//        let image = UIImage(named: "imageWithoutText")!
//
//        let imageView = UIImageView(image: image)
//        imageView.backgroundColor = UIColor.clear
//        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
//
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
//        label.backgroundColor = UIColor.clear
//        label.textAlignment = .center
//        label.textColor = UIColor.white
//        label.text = text
//
//        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
//        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        label.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return imageWithText
//    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
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
