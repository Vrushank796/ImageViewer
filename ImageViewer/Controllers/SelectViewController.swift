//
//  SelectViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-20.
//

import UIKit

class SelectViewController: UIViewController,AddImageDelegate{
    
    //Define variables to use model data of ImageCollection
    var appImageCollection : ImageCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize the variables to use model data
        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
    }
    
    //Define AddImageDelegate method
    func imageVCDidFinishWithImage(image: UIImage, title: String) {
        //Call the imageCollection model method to add the new image in allImages
        appImageCollection?.addNewImage(img: image, imgTitle: title)
    }
    
    func imageVCDidFinishWithCancel() {
        
    }
    
    //Prepare function to define the current VC as delegate to receive the response from other VCs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toImgURLSelector"{
            let imgURLVC = segue.destination as! ImageURLSelectorViewController
            imgURLVC.delegate = self
        }
        else if segue.identifier == "toImgSelector"{
            let imgSelectorVC = segue.destination as! ImageSelectorViewController
            imgSelectorVC.imgDelegate = self
        }
    }
    
}
