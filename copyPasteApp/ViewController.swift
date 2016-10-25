//
//  ViewController.swift
//  copyPasteApp
//
//  Created by Habib Miranda on 10/24/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit
import Foundation
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatImageView()
        formatTextView()
    }
    
    
    @IBAction func useCamera(_ sender: AnyObject) {
        selectImage(from: UIImagePickerControllerSourceType.camera)
    }
    
    @IBAction func fromLibrary(_ sender: AnyObject) {
        selectImage(from: .photoLibrary)
    }
    
    @IBAction func transcribeButton(_ sender: AnyObject) {
        transcribe()
    }
    
    func formatImageView() {
        imagePicked.layer.borderWidth = 2.0
        imagePicked.layer.borderColor = UIColor.red.cgColor
    }
    
    func formatTextView() {
        textView.layer.borderWidth = 5.0
        textView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func transcribe() {
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = imagePicked.image?.g8_blackAndWhite()
            tesseract.recognize()
            textView.text = tesseract.recognizedText
        }
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print ("Recognition Progress \(tesseract.progress)%")
    }
    
    
    func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Pick image finished, show selected image in a imageView
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
////        let scaledImage = scaleImage(image: image, maxDimension: 604)
//        // Show image
////        imagePicked.image = editingInfo?[UIImagePickerControllerOriginalImage] as? UIImage
////
////        self.dismiss(animated: true, completion: nil)
//        if let image = editingInfo?[UIImagePickerControllerOriginalImage] as? UIImage {
//            imagePicked.image = image
//            self.dismiss(animated: true, completion: nil)
//        }
////        let chosenImage = image //2
////        imagePicked.contentMode = .scaleAspectFit //3
////        imagePicked.image = chosenImage //4
////        self.dismiss(animated:true, completion: nil) //5
//    }
    
    func selectImage(from source: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = source
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }

}
