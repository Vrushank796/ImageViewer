//
//  ViewController.swift
//  ImageViewer
//
//  Created by Vrushank on 2022-03-17.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    //Define variables to use model data of ImageCollection
    var appImageCollection : ImageCollection?
    
    //IBOutlets Connection for the required UI elements
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var imagePicker: UIPickerView!
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appImageCollection = (UIApplication.shared.delegate as! AppDelegate).imageCollection
        
        self.imagePicker.delegate = self
        self.imagePicker.dataSource = self
        
        
    }
    
    //viewWillAppear method is called before app scene is displayed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imagePicker.reloadAllComponents()
        
    }
    
    //Configure the methods to access the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (appImageCollection?.allImages.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appImageCollection?.allImages[row].title
    }
    
    //When any image title is selected from picker view, image would be fetched from the imageCollection
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



