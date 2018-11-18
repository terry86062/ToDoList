//
//  SecondViewController.swift
//  ToDoList
//
//  Created by 黃偉勳 Terry on 2018/9/24.
//  Copyright © 2018年 Terry. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    var infoFromViewOne:Int?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var myTextInput: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func textFieldDidChanged(_ sender: UITextField) {
        if sender.text != ""{
            myButton.setTitle("OK", for: .normal)
        }else{
            myButton.setTitle("Back", for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let text = myTextInput.text{
            guard let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController else{ return }
            if text != ""{
                if infoFromViewOne != nil{
                    firstViewController.toDos[infoFromViewOne!] = text
                    infoFromViewOne = nil
                }else{
                    firstViewController.toDos.append(text)
                }
                firstViewController.myTableView.reloadData()
                UserDefaults.standard.set(firstViewController.toDos, forKey: "todos")
            }else{
                if infoFromViewOne != nil{
                    firstViewController.toDos.remove(at: infoFromViewOne!)
                    firstViewController.myTableView.reloadData()
                    UserDefaults.standard.set(firstViewController.toDos, forKey: "todos")
                    infoFromViewOne = nil
                }
            }
        }
        myTextInput.text = ""
        myButton.setTitle("Back", for: .normal)
        //self.tabBarController?.selectedIndex = 0
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextInput.becomeFirstResponder()
        myTextInput.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if infoFromViewOne != nil{
            if let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController{
                myTextInput.text = firstViewController.toDos[infoFromViewOne!]
                myButton.setTitle("OK", for: .normal)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonPressed(UIButton())
        return true
    }
}

