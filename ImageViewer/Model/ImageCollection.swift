//
//  ImageCollection.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import Foundation
import UIKit


class ImageCollection{
    
    //Define and initialize the allImages array to store the image information
    var allImages : [Image] = [Image]()
    
    //Function to add new image
    func addNewImage(img:UIImage,imgTitle:String){
        allImages.append(Image(img:img,name:imgTitle));
    }
}
