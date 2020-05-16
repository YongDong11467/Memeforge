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
    
    var meme: Meme?
    var customImage: Image?
    var captions: [Caption] = []
    var textfields: [UITextField] = []
    var totalCaptions = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        guard let meme = self.meme else {
            memeImage.image = customImage
            return
        }
        guard let url = URL(string: meme.url) else { return }
        memeImage.af_setImage(withURL: url)
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        hideKeyboardWhenTappedAround()
        memeImage.layer.borderWidth = 10
        memeImage.layer.cornerRadius = 5
        memeImage.layer.borderColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        memeImage.layer.masksToBounds = true
    }
    
    @objc func textFieldDrag(pan: UIPanGestureRecognizer) {
        let loc = pan.location(in: self.view)
        pan.view?.center = loc
    }
    
    @IBAction func didAddCaption(_ sender: UIButton) {
        //if (totalCaptions >= box_count
        let center = memeImage.center
        let textfield: UITextField = UITextField(frame: CGRect(x: center.x / 2, y: center.y / 2, width: 175.00, height: 50.00));
        textfield.backgroundColor = UIColor.black
        textfield.borderStyle = .roundedRect
        textfield.textColor = UIColor.white
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(textFieldDrag(pan:)))
        textfield.addGestureRecognizer(gesture)
        //memeImage.addSubview(caption)
        view.addSubview(textfield)
        self.textfields.append(textfield)
        totalCaptions += 1
    }
    
    func populateCaptions() {
        for textfield in self.textfields {
            let x = textfield.frame.origin.x
            let y = textfield.frame.origin.y
//            let x = textfield.frame.midX
//            let y = textfield.frame.midY
            let caption = Caption(id: self.totalCaptions, message: textfield.text!, locationX: Double(x), locationY: Double(y))
            self.captions.append(caption)
        }
        print(self.captions)
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func didForge(_ sender: UIButton) {
        guard let saveMeme = memeImage.image else {return}
        var imageWithText = UIImage()
        populateCaptions()
//        for caption in self.captions {
//            let point = CGPoint(x: caption.locationX, y: caption.locationY)
//            imageWithText = textToImage(drawText: caption.message, inImage: saveMeme, atPoint: point)
//        }
        imageWithText = textToImage(drawCaptions: self.captions, inImage: saveMeme)
        UIImageWriteToSavedPhotosAlbum(imageWithText, self, nil, nil)
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
        let textFont = UIFont(name: "Helvetica Bold", size: 20)!

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
    
    func textToImage(drawCaptions captions: [Caption], inImage image: UIImage) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 20)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        for caption in captions {
            let point = CGPoint(x: caption.locationX, y: caption.locationY)
            let rect = CGRect(origin: point, size: image.size)
            caption.message.draw(in: rect, withAttributes: textFontAttributes)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
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
