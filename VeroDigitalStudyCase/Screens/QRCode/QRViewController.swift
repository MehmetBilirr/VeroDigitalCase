//
//  QRViewController.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 26.03.2023.
//
import UIKit
import AVFoundation
import ProgressHUD

protocol QRViewInterface:AnyObject {
    func configurePreviewLayer()
    func handleInput()
    func handleOutput()
}

final class QRViewController: UIViewController{
    private var captureSession =  AVCaptureSession()
    private lazy var viewModel = QRViewModel(view: self)
        override func viewDidLoad() {
            super.viewDidLoad()

            viewModel.viewDidLoad()
        }
    }

extension QRViewController:QRViewInterface {
    
    func handleInput() {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {return}
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        } else {
            failedScan()
        }
    
    }
    
    func handleOutput() {
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput){
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failedScan()
        }
    }
    
    func configurePreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    private func failedScan() {
        ProgressHUD.showFailed("Scanning not supported")
        captureSession.stopRunning()
    }
}


extension QRViewController:AVCaptureMetadataOutputObjectsDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(text: stringValue)
            captureSession.stopRunning()
            dismiss(animated: true)
        }
        
    }
    
    private func found(text: String) {
        NotificationCenter.default.post(name: .QRName, object: text)
    }
}
