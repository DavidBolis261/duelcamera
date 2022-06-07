//
//  ContentView.swift
//  SwiftUI-CameraApp
//
//  Created by Gaspard Rosay on 28.01.20.
//  Copyright © 2020 Gaspard Rosay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            CustomCamController().edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack{
                    Button(action:{ }){
                        Image(systemName: "bolt.circle")
                    }
                }
            }
        }
        
//        CameraViewController()
//            .edgesIgnoringSafeArea(.top)
       
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
