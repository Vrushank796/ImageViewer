//
//  ImageCollection.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import Foundation
import UIKit

class ImageCollection{
    var allImages : [Image] = [Image]()
    
    func addNewImage(img:UIImage,imgTitle:String){
        allImages.append(Image(img:img,name:imgTitle));
    }
}
