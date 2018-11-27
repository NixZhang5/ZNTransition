//
//  ViewController.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var sourceArray: [String] = ["backScale", "erect", "erect present"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "1"
        self.view.backgroundColor = UIColor.init(red: CGFloat((arc4random() % 256)) / 255.0, green: CGFloat((arc4random() % 256)) / 255.0, blue: CGFloat((arc4random() % 256)) / 255.0, alpha: 1.0)
        
        tableView.dataSource = self
        tableView.delegate = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = sourceArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = sourceArray[indexPath.row]
        switch type {
        case "backScale":
            let vc = CircleViewController()
            self.navigationController?.zn_pushBackScaleViewController(vc)
            break
        case "erect":
            let vc = CircleViewController()
            self.navigationController?.zn_pushViewController(vc, style: .erect)
            break
        case "erect present":
            let vc = CircleViewController()
            self.navigationController?.zn_presentErectVC(vc, completion: nil)
            break
        default:
            break
        }
    }
}

