//
//  ViewController.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import UIKit

class ListingViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getDatas()
        setupView()
    }
    
    
    func getDatas() {
        
    }
    
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

    @IBAction func createSignature(_ sender: Any) {
    }
    
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
    
}
