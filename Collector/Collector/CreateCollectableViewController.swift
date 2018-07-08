//
//  CreateCollectableViewController.swift
//  Collector
//
//  Created by Nikhil Ranjan on 08/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class CreateCollectableViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIImagePickerControllerDelegate, UINavigationControllerDelegate added above for below code
        pickerController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            //imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage
//        }
//        pickerController.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //can be used UIImagePickerControllerOriginalImage instead beleow, it will show edit screen to user after select
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            //imageView.contentMode = .scaleAspectFit
        }
        pickerController.dismiss(animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
    }

    
    @IBAction func directoryImageCollect(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        //pickerController.allowsEditing = false
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraImageCollect(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addImageCollect(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let collectable = Collectable(context: context)
            if let title = titleTextField.text {
                collectable.title = title
                // convert a UIImage into a Data using UIImagePNGRepresentation and UIImageJPEGRepresentation
                if let data = imageView.image {
                    collectable.image = UIImageJPEGRepresentation(data, 0.8)
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        // Go back to previous view controller
        navigationController?.popViewController(animated: true)
    }
    
}
