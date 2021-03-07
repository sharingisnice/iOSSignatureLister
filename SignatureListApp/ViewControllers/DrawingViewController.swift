//
//  DrawingViewController.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import UIKit
import PencilKit

protocol DrawingViewDelegate {
    func getDrawing(drawing: UIImage)
}

class DrawingViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    
    @IBOutlet weak var canvasView: PKCanvasView!
    
    
    let canvasWidth: CGFloat = 600
    let canvasOverscrollHeight: CGFloat = 500
    var drawing = PKDrawing()
    var delegate: DrawingViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCanvas()
        
    }
    
    
    func setCanvas() {
        canvasView.delegate = self
        canvasView.drawing = drawing
        
        canvasView.alwaysBounceVertical = true
        canvasView.allowsFingerDrawing = true
//        canvasView.drawingPolicy = .anyInput


        if let window = parent?.view.window,
           let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            
            canvasView.becomeFirstResponder()
        }
        
    }

    @IBAction func saveDrawing(_ sender: Any) {
    
        let drawnImage = canvasView.asImage()
        delegate?.getDrawing(drawing: drawnImage)
        
        navigationController?.popViewController(animated: true)
    }
    
}
