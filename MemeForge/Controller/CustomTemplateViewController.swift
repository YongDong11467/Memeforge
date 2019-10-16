//
//  CustomTemplateViewController.swift
//  MemeForge
//
//  Created by APPLE on 9/26/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import UIKit
import AlamofireImage

class CustomTemplateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var templateImage: UIImageView!
    
    let pickerViewController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewController.delegate = self
        pickerViewController.allowsEditing = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPickFromPhotoLib(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerViewController.sourceType = .photoLibrary
            present(pickerViewController, animated: true, completion: nil)
        }
        print("Can't access photo library")
    }
    
    @IBAction func didTakePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerViewController.sourceType = .camera
            present(pickerViewController, animated: true, completion: nil)
        }
        print("Can't access camera")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        //let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        templateImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didContinue(_ sender: UIButton) {
        if (templateImage.image != nil) {
            performSegue(withIdentifier: "customToMeme", sender: self)
        } else {
            //alert
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//        let indexPath = memeTableView.indexPath(for: cell)!
//        let meme = memes[indexPath.row]
//        let memeViewController = segue.destination as! MemeViewController
//        memeViewController.meme = meme
//        memeTableView.deselectRow(at: indexPath, animated: true)
        let memeViewController = segue.destination as! MemeViewController
        memeViewController.customImage = templateImage.image
    }
}
