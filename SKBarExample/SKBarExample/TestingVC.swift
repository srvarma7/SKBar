//
//  TestingVC.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 26/02/23.
//

import UIKit
import EasyPeasy
import SKBar

class TestingVC: UIViewController {
    
    let skBarTEx1 = SKBar.tex4(edgePadding: 20, interItemSpacing: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        
        view.addSubview(skBarTEx1)
        skBarTEx1.easy.layout(Bottom(100).to(view, .bottomMargin), Leading(), Trailing(), Height(50))
        skBarTEx1.delegate = self
    }
    
}

extension TestingVC: SKBarDelegate {
    func didSelectSKBarItemAt(_ skBar: SKBar, _ index: Int) {
        print("Delegate - Selected item at", index)
    }
}
