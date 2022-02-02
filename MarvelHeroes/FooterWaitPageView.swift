//
//  FooterWaitPageView.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import UIKit

class FooterWaitPageView: UIView {

    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(spinner)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(spinner)
    }

    func startAnimating(){
        ubicaSpinner()
        self.spinner.startAnimating()
    }

    func stopAnimating(){

        ubicaSpinner()
        self.spinner.stopAnimating()
    }

    func ubicaSpinner(){
        var frame=self.spinner.frame;
        frame.origin.x=(self.frame.size.width-frame.size.width)/2.0;
        frame.origin.y=(self.frame.size.height-frame.size.height)/2.0;
        self.spinner.frame=frame;
    }
}
