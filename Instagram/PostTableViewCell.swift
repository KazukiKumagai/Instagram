//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 熊谷一騎 on 2017/03/12.
//  Copyright © 2017 熊谷一騎. All rights reserved.
//

import UIKit
import Foundation

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setPostData(postData: PostData){
        self.postImageView.image = postData.image
        
        captionLabel.numberOfLines = 3
        captionLabel.sizeToFit()
        let comments = commentManagement(caption: postData.caption!)
        //self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        self.captionLabel.text = "\(postData.name!) : " + comments
        let likeNumber = postData.likes.count
        likeLabel.text = "いいね!: "+"\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
    }
    
    func commentManagement(caption:String) -> String{
        var comments:String
        
        let arr:[String] = caption.components(separatedBy: "\n")
        comments=arr[0] + "\n" + arr[arr.count-1] + "\n" + arr[arr.count-2]
        
        return comments
    }
    
}
