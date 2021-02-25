//
//  PostCell.swift
//  RedditApp
//
//  Created by iceice on 2/23/21.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "PostCell"

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(with post: Post) {
        authorLabel.text = post.author
        timeLabel.text = "\(post.created)"
        titleLabel.text = post.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
