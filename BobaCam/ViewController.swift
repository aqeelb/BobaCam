//
//  CameraViewController.swift
//  BobaCam
//
//  Created by Aqeel Bhat on 27/10/16.
//  Copyright © 2016 PIXERF PTE LTD. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    /*
     
     To-do List:
     1 - Show a preview of camera on screen
     2 - Remove deprecated API's
     3 - Save photo
     4 - Save photo with exif
     5 - Save photo with exif to custom album
     6 - Pick photo from Library
     7 - Get lat, long
     8 - Write lat, long to exif
     9 - Save photo with exif, tiff, gps to custom album
     
     */
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImage: UIView!
    
    // MARK: Declarations
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // @info: prepare capture session
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewView.layer.addSublayer(previewLayer!)
                
                captureSession!.startRunning()
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = previewView.bounds
    }
    
    // MARK: - UIViewController
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Actions
    
    @IBAction func didPressCapture(_ sender: UIButton) {
        print("didPressCapture Button")
    }
    
}
