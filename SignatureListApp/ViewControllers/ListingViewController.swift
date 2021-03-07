//
//  ViewController.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import UIKit

class ListingViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var drawings = [UIImage]()
    var dates = [String]()
    var mainStoryboard : UIStoryboard?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDatas()
        setupView()
    }
    
    
    func getDatas() {
        fetchOldImages()
    }
    
    
    func fetchOldImages() {
        let arr = DataBaseHelper.shareInstance.fetchImage()
        
        if !arr.isEmpty {
            for item in arr
            {
                if let image = UIImage(data: item.img!) {
                    drawings.append(image)
                    
                }
                if let date = item.date {
                    dates.append(date)
                }
            }
        }
        
        tableView.reloadData()
        
    }
    
    
    func setupView() {
        mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
        
        tableView.tableFooterView = UIView()
        
    }
    
    
    @IBAction func createSignature(_ sender: Any) {
        let DrawingVC = (mainStoryboard!.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController)!
        DrawingVC.delegate = self
        
        navigationController?.pushViewController(DrawingVC, animated: true)
    }
    
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    
    func saveDrawing(drawing: UIImage) {
        let currentDate = getCurrentDate()
        drawings.append(drawing)
        dates.append(currentDate)
        DataBaseHelper.shareInstance.saveImage(data: drawing.pngData()!, date: currentDate)
        
        tableView.reloadData()
    }
    
    
    func navigateToPreview(_ item : UIImage ) {
        let previewVC = mainStoryboard!.instantiateViewController(identifier: "PreviewViewController") as! PreviewViewController
        self.present(previewVC, animated: true)
        previewVC.delegate = self
        previewVC.previewImage.image = item
    }
    
    
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignatureTableViewCell") as! SignatureTableViewCell
        
        cell.DateField.text = "Saved on: \(dates[indexPath.row])"
        cell.imageView?.image = drawings[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPreview(drawings[indexPath.row])
    }
    
}

extension ListingViewController: DrawingViewDelegate, PreviewDelegate {
    func deleteItem() {
        
    }
    
    func getDrawing(drawing: UIImage) {
        saveDrawing(drawing: drawing)
    }
    
    
}
