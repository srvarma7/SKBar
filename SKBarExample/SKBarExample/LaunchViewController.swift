//
//  LaunchViewController.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 26/02/23.
//

import UIKit
import EasyPeasy

class LaunchViewController: UIViewController {
    
    var isPlayground: Bool = false
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = .systemFont(ofSize: 26, weight: .black)
        label.textAlignment = .center
        view.addSubview(label)
        label.easy.layout(Center())
        label.text = "SKBar"
        if isPlayground {
            label.text = "SKBar Playground"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (isPlayground ? 0.5 : 2.0)) {
            let vc = self.isPlayground ? TestingVC() : MainViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
