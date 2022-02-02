//
//  LoadErrorView.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 31/1/22.
//

import UIKit

class LoadErrorView: BaseXibView {

    @IBOutlet var lblErrorText: UILabel!
    @IBOutlet var btnRetry: UIButton!
    
    override func commonInit(){
           
        super.commonInit()
        
        self.lblErrorText.numberOfLines = 0
        self.lblErrorText.font = UIFont.boldSystemFont(ofSize: 22.0)
        self.lblErrorText.text = NSLocalizedString("gral_msg_errorLoading", comment: "")
    }
}
