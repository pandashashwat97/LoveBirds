//
//  ScanViewController.swift
//  LoveBirds
//
//  Created by Shashwat Panda on 14/10/23.
//

import UIKit
import AVFoundation
import CoreImage.CIFilterBuiltins
import VisionKit

class ScanViewController: UIViewController, DataScannerViewControllerDelegate {
    @IBOutlet weak var scanButtonText: UIButton!
    @IBOutlet weak var receiverNameField: UILabel!
    var crud = CRUD()
    let filter = CIFilter()
    let context = CIContext()
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 150),
            view.heightAnchor.constraint(equalToConstant: 150)
        ])
        return view
    }()
    var scannerAvailable:Bool {
            DataScannerViewController.isSupported && DataScannerViewController.isAvailable

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Core Data Fetch Name
        receiverNameField.text = crud.fetchName(entitySelected: "RName", key: "receiverName")
        //crud.saveName(entitySelected: "RName", name: "def@gmail.com")
        
        if((receiverNameField.text!.contains("@"))){
            scanButtonText.titleLabel?.text = "Disconnect"
            scanButtonText.titleLabel?.textColor = UIColor.systemRed
        }else{
            scanButtonText.titleLabel?.text = "ScanQR"
            scanButtonText.titleLabel?.textColor = UIColor.systemBlue
        }
        
        let image = createQRCode(from: crud.fetchName(entitySelected: "SName", key: "senderName"))
        imageView.image = image
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func createQRCode(from string: String)-> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    //QR Scanner
    
    @IBAction  func startScanningPressed(_ sender: UIButton){
        if(crud.fetchName(entitySelected: "RName", key: "receiverName") != "NA"){
            crud.deleteName(entitySelected: "RName")
            scanButtonText.titleLabel?.text = "ScanQR"
            scanButtonText.titleLabel?.textColor = UIColor.systemBlue
            receiverNameField.text = "NA"
        }else{
            guard scannerAvailable == true else{
                print("Error: Scanner NA")
                return
            }
            let datascanner = DataScannerViewController(recognizedDataTypes: [.barcode()], isHighlightingEnabled: true)
            datascanner.delegate = self
            present(datascanner, animated: true){
                try?datascanner.startScanning()
            }
        }
      }
      func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
          switch item {
          case .barcode(let code):
              guard let rname = code.payloadStringValue else {return}
              //Core Data save Receiver Name
              crud.saveName(entitySelected: "RName", name: rname)
              receiverNameField.text = rname
              dataScanner.stopScanning()
          default:
              print("Unexpected Item")
          }
      }

}
