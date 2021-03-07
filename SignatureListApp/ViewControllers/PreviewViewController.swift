//
//  PreviewViewController.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import UIKit


protocol PreviewDelegate {
    func deleteItem()
}


class PreviewViewController: UIViewController {

    @IBOutlet weak var previewImage: UIImageView!
    
    
    var delegate: PreviewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    func showPreviewImage() {
        
    }
    
    
    @IBAction func deleteSignature(_ sender: Any) {
        
        delegate?.deleteItem()
        navigationController?.popViewController(animated: true)
    }
    
}
