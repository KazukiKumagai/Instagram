//
//  SettingViewController.swift
//  Instagram
//
//  Created by 熊谷一騎 on 2017/03/07.
//  Copyright © 2017 熊谷一騎. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import SVProgressHUD

class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 表示名を取得してTextFieldに設定する
        let user = FIRAuth.auth()?.currentUser
        if let user = user{
            displayNameTextField.text = user.displayName
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text{
            // 表示名が入力されていない時はHUDを出して何もしない
            if displayName.characters.isEmpty{
                SVProgressHUD.showError(withStatus: "表示名を入力してください")
                return
            }
            // 表示名を設定する
            let user = FIRAuth.auth()?.currentUser
            if let user = user{
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges{ error in
                    if let error = error{
                        print("DEBUG_PRINT: " + error.localizedDescription)
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName)]の設定に成功しました。")
                    // HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }else{
                print("DEBUG_PRINT: displayNameの設定に失敗しました。")
            }
        }
        // キーボードを閉じる
        self.view.endEditing(true)
    }
    // ログアウトボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleLogoutButton(_ sender: Any) {
        //ログアウト処理
        try! FIRAuth.auth()?.signOut()
        
        // ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        // ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
        let tabBarController = parent as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: true)
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
