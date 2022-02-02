//
//  EntranceViewController.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 28/1/22.
//

import UIKit

class EntranceViewController: UIViewController {

    var maxRepetionsAnimation=3;
    
    @IBOutlet var imgViewLogoFaceA:UIImageView!
    @IBOutlet var imgViewLogoFaceB:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        prepareEntranceAnimation()
        performEntranceAnimation()
    }
    
    func prepareEntranceAnimation(){

        self.imgViewLogoFaceA.superview?.bringSubviewToFront(self.imgViewLogoFaceA)
        self.imgViewLogoFaceB.superview?.sendSubviewToBack(self.imgViewLogoFaceB)
        
        self.imgViewLogoFaceB.alpha=0.0
    }
    
    func performEntranceAnimation(){

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            
            self.imgViewLogoFaceA.alpha=0.0
            self.imgViewLogoFaceB.alpha=1.0

        } completion: { _ in

            self.imgViewLogoFaceA.alpha=1.0

            UIView.transition(from: self.imgViewLogoFaceB, to: self.imgViewLogoFaceA, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews]) { [self] _ in
                
                changeRootController()
            }
        }
    }
    
    func changeRootController(){
        
        guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "idScene_ListCharacters") else {
            return
        }
           
        guard let window = UIWindow.keyWindowAccordingiOSVersion else{
            return
        }        
        
        mainViewController.view.frame = window.bounds
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = mainViewController
        }, completion: nil)
    }
}
