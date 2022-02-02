//
//  UIWindow_Extension.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 29/1/22.
//

import UIKit

extension UIWindow {
    
    static var keyWindowAccordingiOSVersion: UIWindow? {
        
        if #available(iOS 13, *) {
            
            if #available(iOS 15, *) {
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                
                return window
            }else{
                return UIApplication.shared.windows.first { $0.isKeyWindow }
            }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
