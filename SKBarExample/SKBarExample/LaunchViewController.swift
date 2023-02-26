//
//  LaunchViewController.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 26/02/23.
//

import UIKit
import EasyPeasy

class LaunchViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = .systemFont(ofSize: 26, weight: .black)
        label.textAlignment = .center
        view.addSubview(label)
        label.easy.layout(Center())
        label.text = "SKBar"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
