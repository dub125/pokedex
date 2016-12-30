//
//  PokeCell.swift
//  PokeDex
//
//  Created by Dylan wichman on 12/29/16.
//  Copyright © 2016 Bulletproof Interactive. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5.0
    }
    
    
    var pokemon:Pokemon!
    
    func configureCell(_ pokemon:Pokemon){
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.id)")
        
        
        
    }

}
