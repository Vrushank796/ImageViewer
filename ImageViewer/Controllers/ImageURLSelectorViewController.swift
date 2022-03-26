//
//  ImageURLSelectorViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-20.
//

import UIKit

class ImageURLSelectorViewController: UIViewController {
    
    //Define variable to use the delegate methods
    var delegate:AddImageDelegate?
    
    //IBOutlets Connection for the required UI elements
    @IBOutlet weak var imgTitleLabel: UITextField!
    @IBOutlet weak var imgURL: UITextField!
    
    //Define variables to use model data of ImageCollection
    var appImageCollection : ImageCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the variables to use model data
        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
        
    }
    
    //addImageWithURL action would be called when Save button would be tapped by user
    @IBAction func addImageWithURL(_ sender: Any) {
        guard let correctImageTitle = imgTitleLabel.text else {showErrorMsg(); return }
        guard let correctImageURL = imgURL.text else {showErrorMsg(); return }
        guard !correctImageTitle.isEmpty && !correctImageURL.isEmpty else {showErrorMsg(); return }
        
        //Configure app to download the image from url
        let imageURL = URL(string:self.imgURL.text!)
        let imgData = try? Data(contentsOf: imageURL!)
        let getImg = UIImage(data: imgData!)!
        
        //Calling AddImageDelegate method to add selected image with title as Local Image
        delegate?.imageVCDidFinishWithImage(image: getImg, title: correctImageTitle)
        
        //Perform Unwind Segue to navigate back to the Root View Controller
        performSegue(withIdentifier: "unwindFromImgURLToRoot", sender: self)
        
        //function to show error message if any UI element is not set properly
        func showErrorMsg(){
            let imgErrorAlert = UIAlertController(title: "Error", message: "Missing Image info!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
            
            imgErrorAlert.addAction(action)
            present(imgErrorAlert, animated: true, completion: nil)
        }
    }
    
    //addImage action would be called when user tap on Cancel button
    @IBAction func cancelImageSelectionWithURL(_ sender: Any) {
        delegate?.imageVCDidFinishWithCancel()
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
