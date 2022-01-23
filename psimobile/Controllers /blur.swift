//
//  blur.swift
//  Psi
//
//  Created by Makafui Aheto on 06/09/2021.
//

import Foundation

import SwiftUI


struct Blur: UIViewRepresentable{
    
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
