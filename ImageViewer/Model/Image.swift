//
//  Image.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import Foundation
import UIKit


class Image{
    
    //Define and Initialize the Image Properties such as title and image
    var image : UIImage;
    var title : String = ""
    
    init(img:UIImage,name:String){
        image = img;
        title = name;
    }
}
