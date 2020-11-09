//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Steven Liu on 11/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    // Class variables must be initialized to a value
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    // Show fav/unfav icon depending on the state: RED/GREY
    func setFavorite(_ isFavorited:Bool) {
        // set method for the "favorited" field
        favorited = isFavorited
        if(isFavorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    // Show (already retweeted)/(not retweeted yet) icon according to the state; Disable the retweet button if it's already been retweeted: GREEN/GREY
    func setRetweeted(_ isRetweeted:Bool) {
        // set method for the "retweeted" field
        retweeted = isRetweeted
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    // Call the twitter API to fav/unfav the tweet (ACTUALLY from your Twitter account) when pressed by the user
    @IBAction func favTweet(_ sender: Any) {
        if(!favorited) {
            TwitterAPICaller.client?.favTweet(tweetId: tweetId, success: {
                // the "favorited" field value toggled
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favoriting a tweet did NOT succeed: \(Error) \n")
            })
        }else{
            TwitterAPICaller.client?.unfavTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavoriting a tweet did NOT succeed: \(Error) \n")
            })
        }
//        favorited = !favorited
    }
    
    // Call the twitter API to retweet the tweet (ACTUALLY from your Twitter account) when pressed by the user; ONLY IF it hasn't been retweeted
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Retweet failed: \(Error) \n")
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
