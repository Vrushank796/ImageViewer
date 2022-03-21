//
//  SelectViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-20.
//

import UIKit

class SelectViewController: UIViewController,AddImageDelegate {
    
    var appImageCollection : ImageCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
    }
    

    func imageVCDidFinishWithImage(image: UIImage, title: String) {
    //        let q = DispatchQueue.init(label:"imgPickerQueue")
    //        q.async{
    //            self.appImageCollection?.addNewImage(img: image, imgTitle: title)
    //            DispatchQueue.main.async{
    //                self.imagePicker.reloadAllComponents()
    //            }
    //        }
        print("DidFinishWithImage function Called")
        appImageCollection?.addNewImage(img: image, imgTitle: title)
        print((appImageCollection?.allImages.count)!)
    }

    func imageVCDidFinishWithCancel() {
        
    }

}
