//
//  ViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    var appImageCollection : ImageCollection?
    
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var imagePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
        
        self.imagePicker.delegate = self
        self.imagePicker.dataSource = self
        
//        imagePicker.selectRow(0, inComponent: 0, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imagePicker.reloadAllComponents()
        
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (appImageCollection?.allImages.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appImageCollection?.allImages[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let q = DispatchQueue.init(label:"imgPickerQueue")
        q.async{
            
            DispatchQueue.main.async{
                if ((self.appImageCollection?.allImages.count)! >= 1){
                    if let selectedImg = self.appImageCollection?.allImages[row].image{
                        self.imageViewer.image = selectedImg
                    }
                }
            }
        }
        
        
        
            
    }
    
    
}



