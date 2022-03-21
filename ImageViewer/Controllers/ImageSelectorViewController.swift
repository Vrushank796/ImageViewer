//
//  ImageSelectorViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import UIKit

protocol AddImageDelegate{
    func imageVCDidFinishWithImage(image:UIImage,title:String);
    func imageVCDidFinishWithCancel();
}

class ImageSelectorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imgDelegate:AddImageDelegate?
    
    var appImageCollection : ImageCollection?
    
    @IBOutlet weak var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        
        let selectImageOptions = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take a Photo", style:.default){ [self] (action) in
            let q = DispatchQueue.init(label: "imgSelection")
            q.async{
                //It should run in background not in main thread
//                Thread.sleep(forTimeInterval: 20)
                
                DispatchQueue.main.async{
                    let cameraImg = UIImagePickerController()
                    cameraImg.sourceType = .camera
                    cameraImg.allowsEditing = false
                    cameraImg.delegate = self
                    self.present(cameraImg,animated:true,completion:nil)
                }
            }
            
        }
        
        let uploadPhotoAction = UIAlertAction(title: "Select Photo from library", style:.default){ [self] (action) in
            let imgLibrary = UIImagePickerController()
            imgLibrary.sourceType = .photoLibrary
            imgLibrary.allowsEditing = false
            imgLibrary.delegate = self
            present(imgLibrary,animated:true,completion:nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
       
        selectImageOptions.addAction(takePhotoAction)
        selectImageOptions.addAction(uploadPhotoAction)
        selectImageOptions.addAction(cancelAction)
        
        present(selectImageOptions, animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any) {
        guard let correctImage = selectedImage.image else {showErrorMsg(); return }
        
        imgDelegate?.imageVCDidFinishWithImage(image: correctImage, title: "Local Image")
        
        print("Calling DidFinishWithImage function")
        appImageCollection?.addNewImage(img: correctImage, imgTitle: "Local Image")
        print((appImageCollection?.allImages.count)!)
        dismiss(animated: true, completion: nil)
        
        func showErrorMsg(){
               let imgErrorAlert = UIAlertController(title: "Error", message: "Image Missing!", preferredStyle: .alert)
               
               let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
              
               imgErrorAlert.addAction(action)
               present(imgErrorAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelImageSelection(_ sender: Any) {
        imgDelegate?.imageVCDidFinishWithCancel()
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage{
            selectedImage.image = img
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
