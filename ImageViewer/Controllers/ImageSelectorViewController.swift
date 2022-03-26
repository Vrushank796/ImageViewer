//
//  ImageSelectorViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import UIKit

//Define AddImageDelegate protocol
protocol AddImageDelegate{
    func imageVCDidFinishWithImage(image:UIImage,title:String);
    func imageVCDidFinishWithCancel();
}

class ImageSelectorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //Define variable to use the delegate methods
    var imgDelegate:AddImageDelegate?
    
    //Define variables to use model data of ImageCollection
    var appImageCollection : ImageCollection?
    
    //IBOutlets Connection for the required UI elements
    @IBOutlet weak var selectedImage: UIImageView!
    
    let defaultImage = UIImage(named:"picture")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize variables to use model data
        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
        
        selectedImage.image = defaultImage
        
    }
    
    //selectPhoto action would be called when Take or Select Photo button would be tapped
    @IBAction func selectPhoto(_ sender: Any) {
        
        //AlertController to allow user to select option using actionsheet
        let selectImageOptions = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        //If Take a Photo option is selected then it would open a camera to take photo using UIImagePickerController
        let takePhotoAction = UIAlertAction(title: "Take a Photo", style:.default){ [self] (action) in
            let q = DispatchQueue.init(label: "imgSelection")
            q.async{
                //It should run in background not in main thread
                
                DispatchQueue.main.async{
                    let cameraImg = UIImagePickerController()
                    cameraImg.sourceType = .camera
                    cameraImg.allowsEditing = false
                    cameraImg.delegate = self
                    self.present(cameraImg,animated:true,completion:nil)
                }
            }
            
        }
        
        //If Select Photo from library option is selected then it would open a photo library to select photo using UIImagePickerController
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
    
    //addImage action would be called when user tap on save button
    @IBAction func addImage(_ sender: Any) {
        if(selectedImage.image != defaultImage){
            guard let correctImage = selectedImage.image else {showErrorMsg(); return }
            
            //Calling AddImageDelegate method to add selected image with title as Local Image
            imgDelegate?.imageVCDidFinishWithImage(image: correctImage, title: "Local Image")
            
            //Perform Unwind Segue to navigate back to the Root View Controller
            performSegue(withIdentifier: "unwindFromImgSelectorToRoot", sender: self)
        }
        else{
            showErrorMsg(); return
        }
        //function to show error message if any UI element is not set properly
        func showErrorMsg(){
            let imgErrorAlert = UIAlertController(title: "Error", message: "Image Missing!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
            
            imgErrorAlert.addAction(action)
            present(imgErrorAlert, animated: true, completion: nil)
        }
    }
    
    
    //addImage action would be called when user tap on Cancel button
    @IBAction func cancelImageSelection(_ sender: Any) {
        imgDelegate?.imageVCDidFinishWithCancel()
        dismiss(animated: true, completion: nil)
    }
    
    //Configuring the imagePickerController to set the UIImage on current VC
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
