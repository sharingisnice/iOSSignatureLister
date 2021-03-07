//
//  PreviewViewController.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import UIKit


protocol PreviewDelegate {
    func deleteItem(at index: Int)
}


class PreviewViewController: UIViewController {

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var delegate: PreviewDelegate?
    var itemIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func deleteSignature(_ sender: Any) {
        delegate?.deleteItem(at: itemIndex!)
        dismiss(animated: true, completion: nil)
        dateLabel.text = ""
    }
    
}
