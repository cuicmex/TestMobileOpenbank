//
//  ListCharacterCell.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 31/1/22.
//

import UIKit
import SDWebImage

class ListCharacterCell: BaseCell {

    @IBOutlet weak var imgViewCharacter: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblName?.numberOfLines = 2
        self.lblDescription?.numberOfLines = 3
        self.lblName?.font=UIFont.boldSystemFont(ofSize: 16.0)
        self.lblDescription?.font=UIFont.systemFont(ofSize: 14.0)
        
        self.imgViewCharacter.contentMode = .scaleAspectFill
        self.imgViewCharacter.image=nil;
    }

    override func setupCell(info: Any){
        
        if let infoCharacter = info as? ListCharacterModel {
            
            self.lblName.text = infoCharacter.name
            self.lblDescription.text = infoCharacter.characterDescription
            self.imgViewCharacter.image=nil
            
            let imgUrlStr = infoCharacter.image.thumbnailPath
            if let url = URL(string: imgUrlStr) {
                            
                self.imgViewCharacter.sd_setImage(with: url) { img, error, cacheType, url in
                    if error != nil {
                        self.imageView?.image=nil
                    }
                }
            }
        }
    }
    
    override func resetCellInfo(){
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
        self.imageView?.image=nil
    }
}
