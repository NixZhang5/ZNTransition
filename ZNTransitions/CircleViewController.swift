//
//  CircleViewController.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "2"
        self.view.backgroundColor = UIColor.init(red: CGFloat((arc4random() % 256)) / 255.0, green: CGFloat((arc4random() % 256)) / 255.0, blue: CGFloat((arc4random() % 256)) / 255.0, alpha: 1.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    deinit {
        print("vc deinit")
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
