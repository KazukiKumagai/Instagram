//
//  CommentViewController.swift
//  Instagram
//
//  Created by 熊谷一騎 on 2017/03/19.
//  Copyright © 2017 熊谷一騎. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    var postData:PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentLabel.numberOfLines = 0
        commentLabel.sizeToFit()
        //commentLabel.lineBreakMode = NSLineBreakByWordWrapping
        
        commentLabel.text = postData.caption!
        // Do any additional setup after loading the view.
    }
    @IBAction func commentButton(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)

        
        // Firebaseに保存するデータの準備
        if (FIRAuth.auth()?.currentUser?.uid) != nil {
            if commentTextField.text != nil {
                postData.caption = postData.caption! + "\n" + "[" + dateString + "]" + postData.name! + ":"+commentTextField.text!
                // コメントをFirebaseに保存する
                let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id!)
                let captions = ["caption": postData.caption]
                postRef.updateChildValues(captions)
                
                // HUDで完了を知らせる
                SVProgressHUD.showSuccess(withStatus: "コメントを完了しました")
                commentLabel.text = postData.caption!
            }
            
        }

    }
    @IBAction func backButton(_ sender: Any) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
