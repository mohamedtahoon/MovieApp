//
//  MovieViewCell.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieYearLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
