//
//  ImageURLSelectorViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-20.
//

import UIKit

class ImageURLSelectorViewController: UIViewController {
    
    var delegate:AddImageDelegate?

    @IBOutlet weak var imgTitleLabel: UITextField!
    
    @IBOutlet weak var imgURL: UITextField!
    
    var appImageCollection : ImageCollection?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
        
    }
    
    @IBAction func addImageWithURL(_ sender: Any) {
        guard let correctImageTitle = imgTitleLabel.text else {showErrorMsg(); return }
        guard let correctImageURL = imgURL.text else {showErrorMsg(); return }
        guard !correctImageTitle.isEmpty && !correctImageURL.isEmpty else {showErrorMsg(); return }
        
        let imageURL = URL(string:imgURL.text!)
        let imgData = try? Data(contentsOf: imageURL!)
        let getImg = UIImage(data: imgData!)
        
        delegate?.imageVCDidFinishWithImage(image: getImg!, title: correctImageTitle)
        
        print("Calling DidFinishWithImage function")
    
        appImageCollection?.addNewImage(img: getImg!, imgTitle: correctImageTitle)
        print((appImageCollection?.allImages.count)!)
        
        dismiss(animated: true, completion: nil)
        
        func showErrorMsg(){
               let imgErrorAlert = UIAlertController(title: "Error", message: "Missing Image info!", preferredStyle: .alert)
               
               let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
              
               imgErrorAlert.addAction(action)
               present(imgErrorAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelImageSelectionWithURL(_ sender: Any) {
        delegate?.imageVCDidFinishWithCancel()
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
