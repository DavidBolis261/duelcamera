//
//  videoPLayer.swift
//  SwiftUI-CameraApp
//
//  Created by David Bolis on 15/6/2022.
//  Copyright © 2022 Gaspard Rosay. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import JPSVolumeButtonHandler

class videoPLayer: UIViewController {
    @IBOutlet weak var buttnLayout: UIButton!
    @IBOutlet weak var trashOulet: UIButton!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var cancelOutLet: UIButton!
    
    var thevideoURL: URL?
    @IBOutlet weak var heVideoOutlet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttnLayout.setTitle("", for: .normal)
        trashOulet.setTitle("", for: .normal)
        saveBTN.setTitle("", for: .normal)
        cancelOutLet.setTitle("", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let player = AVPlayer(url: thevideoURL!)
//        let layer = AVPlayerLayer(player: player)
//        layer.frame = view.bounds
//        view.layer.addSublayer(layer)
//        player.play()
//        //JustPrinting
//        print(thevideoURL!)
        playVideo()
        
    }
    func playVideo(){
        let player = AVPlayer(url: thevideoURL!)
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        self.heVideoOutlet.layer.addSublayer(layer)
        player.play()
        
        
        
        heVideoOutlet.bringSubviewToFront(buttnLayout)
        heVideoOutlet.bringSubviewToFront(trashOulet)
        heVideoOutlet.bringSubviewToFront(saveBTN)
        heVideoOutlet.bringSubviewToFront(cancelOutLet)
    }
    @IBAction func repeatVideo(_ sender: Any) {
        playVideo()
    }
    
    @IBAction func saveBTNAction(_ sender: Any) {
        self.saveMovieToPhotoLibrary(thevideoURL!)
    }
    @IBAction func trashBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    private func saveMovieToPhotoLibrary(_ movieURL: URL) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                // Save the movie file to the photo library and clean up.
                PHPhotoLibrary.shared().performChanges({
                    let options = PHAssetResourceCreationOptions()
                    options.shouldMoveFile = true
                    let creationRequest = PHAssetCreationRequest.forAsset()
                    creationRequest.addResource(with: .video, fileURL: movieURL, options: options)
                }, completionHandler: { success, error in
                    if !success {
                        print("\(Bundle.main.applicationName) couldn't save the movie to your photo library: \(String(describing: error))")
                    } else {
                        // Clean up
                        if FileManager.default.fileExists(atPath: movieURL.path) {
                            do {
                                try FileManager.default.removeItem(atPath: movieURL.path)
                            } catch {
                                print("Could not remove file at url: \(movieURL)")
                            }
                        }
                        
                    
                    }
                })
            } else {
                DispatchQueue.main.async {
                    let alertMessage = "Alert message when the user has not authorized photo library access"
                    let message = NSLocalizedString("\(Bundle.main.applicationName) does not have permission to access the photo library", comment: alertMessage)
                    let alertController = UIAlertController(title: Bundle.main.applicationName, message: message, preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
