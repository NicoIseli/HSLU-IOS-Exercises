//
//  ViewController.swift
//  ComAndCon
//
//  Created by nico on 20.10.20.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    // MARK: - PROPERTIES OF THE CLASS
    
    @IBOutlet weak var picker : UIPickerView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    var images: [ImageInfo] = []
    var imageFiles : [UIImage] = []
    
    let url = URL(string: "https://hslu.nitschi.ch/networking/data.json")!
    
    struct Response: Codable {
        let images: [ImageInfo]
        let lastUpdate: Date
        let info: String
    }
    
    struct ImageInfo: Codable{
        let identifier: Int
        let title: String
        let text: String
        let url: URL
    }
    
    
    
    // MARK: - FUNCTIONS OF APP LIFE-CYCLE
    
    //FUNCTION CALLED AFTER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.images = loadListSync()!
        
        self.titleLabel.text = images[0].title
        self.imageView.image = loadImageSync(image: images[0])
        
    }

    
    
    //MARK: - FUNCTIONS FOR API CALLS
    
    // LOAD AND PARSE IMAGEINFOS FROM API
    func loadListSync() -> [ImageInfo]? {
        
        var responseData : [ImageInfo] = []
        
        do{
            let data = try Data(contentsOf: url)
            
            let jsonData = try JSONDecoder().decode(Response.self, from: data)
            responseData = jsonData.images
            
        } catch {
            print("error")
        }
        
        return responseData
    }
    
    // LOAD AND RETURN A SPECIFIC IMAGE FROM IMAGEINFO
    func loadImageSync(image: ImageInfo) -> UIImage? {
        var imageFile: UIImage?
        
        do{
            let data = try Data(contentsOf: image.url)
            
            imageFile = UIImage(data: data)
            
        } catch {
            print("error")
        }
    
        return imageFile

    }
    
    // FUNCTION GIVEN BY THE TASK - NOT IMPLEMENTED YET
    func loadImageAsync(image: ImageInfo, completion: @escaping (UIImage?) -> Void) {
        
    }
 
    
    
    // MARK: - FUNCTIONS OF PICKER VIEW
    
    // NUMBER OF COMPONENTS IN THE PICKERVIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // GIVE THE PICKERVIEW THE TITLES OF THE LOADED IMAGEINFO FROM THE API
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.images[row].title
    }
    
    // GIVE THE PICKER VIEW THE AMOUNT OF IMAGEINFOS LOADED FROM THE API
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.images.count
    }
    
    // SET THE IBOUTLETS TO THE CURRENT IMAGEINFO ON THE PICKER VIEW
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.titleLabel.text = self.images[row].title

        DispatchQueue.global(qos: .background).async {
            let receivedImage: UIImage = self.loadImageSync(image: self.images[row])!
            
            DispatchQueue.main.async {
                self.imageView.image = receivedImage
            }
        }
    }
    
    
    // MARK: - SUPPORTING FUNCTIONS
    
    /*
    //MAKE HTTPS-CALL WITHOUT HELPER FUNCTION
    URLSession.shared.dataTask(with: url) {
        data, response, error in
        if let error = error{
            print("Data Task failed, errof: \(error)")
        }
        
        else if let data = data{
            let responseData = try? JSONDecoder().decode(Response.self, from: data)
            
            print(responseData?.images[0].title)
        }
    }.resume()
    */

}

