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
        
        fetchOldImages()
        setupView()
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
    
    
    func removeItemFromCoreData(at: Int) {
        let arr = DataBaseHelper.shareInstance.fetchImage()
        DataBaseHelper.shareInstance.deleteImage(data: arr[at])
    }
    
    
    func setupView() {
        mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
    
    
    func navigateToPreview(_ item : UIImage, index: Int ) {
        let previewVC = mainStoryboard!.instantiateViewController(identifier: "PreviewViewController") as! PreviewViewController
        self.present(previewVC, animated: true)
        previewVC.delegate = self
        previewVC.previewImage.image = item
        previewVC.itemIndex = index
        previewVC.dateLabel.text = "Saved on: \(dates[index])"
    }
    
    
    func removeItemFromList(at index: Int){
        drawings.remove(at: index)
        dates.remove(at: index)
        removeItemFromCoreData(at: index)
        
        tableView.reloadData()
    }
    
    
    @IBAction func createSignature(_ sender: Any) {
        let DrawingVC = (mainStoryboard!.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController)!
        DrawingVC.delegate = self
        navigationController?.pushViewController(DrawingVC, animated: true)
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
        navigateToPreview(drawings[indexPath.row], index: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            removeItemFromList(at: index)
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    
    
}

extension ListingViewController: DrawingViewDelegate, PreviewDelegate {
    func deleteItem(at index: Int) {
        removeItemFromList(at: index)
    }
    
    
    func getDrawing(drawing: UIImage) {
        saveDrawing(drawing: drawing)
    }
    
    
}
