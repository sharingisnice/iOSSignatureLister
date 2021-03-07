//
//  SignatureTableViewCell.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import UIKit

class SignatureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DateField: UILabel!
    @IBOutlet weak var signatureView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
