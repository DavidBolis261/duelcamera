//
//  ContentView.swift
//  SwiftUI-CameraApp
//
//  Created by Gaspard Rosay on 28.01.20.
//  Copyright © 2020 Gaspard Rosay. All rights reserved.
//

import SwiftUI
import AVFoundation
import JPSVolumeButtonHandler
import AVKit

struct ContentView: View {
    @State var isFlashOn = false
    @State var volumeHandler: JPSVolumeButtonHandler?
    @State var theCamCont: ViewController!

    var body: some View {
        ZStack{
            CustomCamController().edgesIgnoringSafeArea(.all)
            //VideoPlayer(player: AVPlayer(url: FileManager.))
            VStack{
                Spacer()
                HStack{
                    Button(action:{
                        if(isFlashOn == false){
                            isFlashOn = true
                            toggleTorch(on: true)
                        } else {
                            isFlashOn = false
                            toggleTorch(on: false)
                          
                        }
                    }){
                        Image(systemName: isFlashOn ? "bolt.slash.circle" : "bolt.circle").font(.largeTitle).foregroundColor(isFlashOn ? Color.red : Color.white)
                    }.offset(y: -50)
                    Spacer()
                }
            }
              
        }
//        .onAppear{
//            volumeHandler = JPSVolumeButtonHandler(up: {
//
//            }, downBlock: {
//
//            })
//            volumeHandler?.start(true)
//        }

       
    }
    func toggleTorch(on: Bool){
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch{
            do{
                try device.lockForConfiguration()
                if on == true{
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
            } catch{
                print("Torch is not available")
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomCamController: UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Home")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
