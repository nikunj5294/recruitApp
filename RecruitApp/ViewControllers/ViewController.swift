//
//  ViewController.swift
//  RecruitApp
//
//  Created by MAC on 30/01/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var imgSplash: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Setup UI

    func setupView() {
        imgSplash.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    
        UIView.animate(withDuration: 1.0) {
            self.imgSplash.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } completion: { (true) in
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.redirectToWelcomeScreen), userInfo: nil, repeats: false)
        }
    }
    
    @objc func redirectToWelcomeScreen() {
        
        if isUserLoggedIn(){
            let aVC = self.storyboard?.instantiateViewController(withClass: WelcomeViewController.self)
            self.navigationController?.pushViewController(aVC!, animated: false)
        }else{
            let aVC = self.storyboard?.instantiateViewController(withClass: WelcomeViewController.self)
            self.navigationController?.pushViewController(aVC!, animated: true)
        }
    }

}

