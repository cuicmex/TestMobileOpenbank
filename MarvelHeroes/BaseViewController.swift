//
//  BaseViewController.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 31/1/22.
//

import UIKit
import Lottie

protocol BaseViewControllerDisplayLogic: AnyObject
{
    func startActivityIndicator()
    func stopActivityIndicator()
}

class BaseViewController: UIViewController {

    private let tagViewContActivityIndicator = 100000
    private let tagViewActivityIndicator = 100001
    private let tagViewLoadError = 100002

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Display Logic (Presenter protocol communication)
    
    func startActivityIndicator(){
        showActivityIndicator()
    }
    
    func stopActivityIndicator(){
        hideActivityIndicator()
    }
}

extension BaseViewController {
    
    func showActivityIndicator(){
        
        let viewCont = UIView(frame: self.view.bounds)
        viewCont.tag = tagViewContActivityIndicator
        viewCont.backgroundColor = UIColor.clear
        self.view.addSubview(viewCont)
        
        let animationView = AnimationView(name: "svgBlueStar")
        animationView.tag = tagViewActivityIndicator
        animationView.translatesAutoresizingMaskIntoConstraints = false
        viewCont.addSubview(animationView)
        
        animationView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        animationView.centerYAnchor.constraint(equalTo: viewCont.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: viewCont.centerXAnchor).isActive = true
        
        animationView.clipsToBounds = true
        animationView.loopMode = LottieLoopMode.loop
        
        animationView.play(completion: nil)
    }
    
    func hideActivityIndicator(){
        
        if let viewCont = self.view.viewWithTag(tagViewContActivityIndicator), let animationView = viewCont.viewWithTag(tagViewActivityIndicator) as? AnimationView {
            
            if animationView.isAnimationPlaying{
                animationView.stop()
            }
            
            UIView.animate(withDuration: 0.25) {
                viewCont.alpha = 0.0
            } completion: { finish in
                viewCont.removeFromSuperview()
            }

        }
    }
    
    func  createLoadErrorView(titleBtn: String, selector: Selector){
        
        let viewLoadError = LoadErrorView(frame: CGRect.zero)
        viewLoadError.alpha = 0.0
        viewLoadError.tag = tagViewLoadError
        viewLoadError.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewLoadError)
        
        NSLayoutConstraint.activate([
            viewLoadError.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewLoadError.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewLoadError.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewLoadError.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        
        viewLoadError.btnRetry .setTitle(titleBtn, for: .normal)
        viewLoadError.btnRetry.addTarget(self, action: selector, for: .touchUpInside)
         
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25) {
            viewLoadError.alpha = 1.0
        }

    }
    
    func removeLoadErrorView(completion: (() -> ())?){
        if let viewLoadError = self.view.viewWithTag(tagViewLoadError) {
            UIView.animate(withDuration: 0.25) {
                viewLoadError.alpha = 0.0
            } completion: { finished in
                viewLoadError.removeFromSuperview()
                completion?()
            }
        }else{
            completion?()
        }
    }

}
