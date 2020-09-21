//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by SindhuRam on 9/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    //var retweeted:Bool = false
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                 print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    /*func favoriteTweet(tweetId: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/favorites/create.json"
        TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    func unfavoriteTweet(tweetId: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/favorites/destroy.json"
        TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func retweet(tweetId: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
           let url = "https://api.twitter.com/1.1/statuses/retweet/:id.json"
           TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
               success()
           }, failure: { (task: URLSessionDataTask?, error: Error) in
               failure(error)
           })
       }*/
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error in retweeting:\(Error)")
        })
    }
    

    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red")  , for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
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
