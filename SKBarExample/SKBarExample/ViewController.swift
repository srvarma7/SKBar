//
//  ViewController.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import SKBar
import EasyPeasy

class ViewController: UIViewController {
    
    let skBarEx1 = SKBar.ex1(edgePadding: 20, interItemSpacing: 28)
    let skBarEx2 = SKBar.ex2(edgePadding: 0, interItemSpacing: 15)
    let skBarEx3 = SKBar.ex3(edgePadding: 0, interItemSpacing: 10)
    let skBarEx4 = SKBar.ex4(edgePadding: 15, interItemSpacing: 28)
    let skBarEx5 = SKBar.ex5(edgePadding: 0, interItemSpacing: 28)
    let skBarEx6 = SKBar.ex6(edgePadding: 0, interItemSpacing: 5)
    
    let spacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(skBarEx1)
        skBarEx1.easy.layout(Top().to(view, .topMargin), Leading(), Trailing(), Height(50))
        skBarEx1.delegate = self
        
        view.addSubview(skBarEx2)
        skBarEx2.easy.layout(Top(spacing).to(skBarEx1), Leading(), Trailing(), Height(50))
        skBarEx2.delegate = self

        view.addSubview(skBarEx3)
        skBarEx3.easy.layout(Top(spacing).to(skBarEx2), Leading(), Trailing(), Height(50))
        skBarEx3.delegate = self

        view.addSubview(skBarEx4)
        skBarEx4.easy.layout(Top(spacing).to(skBarEx3), Leading(), Trailing(), Height(50))
        skBarEx4.delegate = self


        view.addSubview(skBarEx5)
        skBarEx5.easy.layout(Top(spacing).to(skBarEx4), Leading(), Trailing(), Height(50))
        skBarEx5.delegate = self

        view.addSubview(skBarEx6)
        skBarEx6.alignment = .leading
        skBarEx6.easy.layout(Top(spacing).to(skBarEx5), Leading(), Trailing(), Height(50))
        skBarEx6.delegate = self
    }
}

extension ViewController: SKBarDelegate {
    func didSelectSKBarItemAt(_ skBar: SKBar, _ index: Int) {
        print("Selected item at", index)
    }
}
