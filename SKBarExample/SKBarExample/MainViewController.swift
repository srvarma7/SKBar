//
//  MainViewController.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import SKBar
import EasyPeasy

class MainViewController: UIViewController {
    
    let skBarTEx1 = SKBar.tex1(edgePadding: 20, interItemSpacing: 4)
    let skBarTEx2 = SKBar.tex2(edgePadding: 0, interItemSpacing: 15)
    let skBarTEx3 = SKBar.tex3(edgePadding: 0, interItemSpacing: 10)
    let skBarTEx4 = SKBar.tex4(edgePadding: 20, interItemSpacing: 4)
    
    let skBarEx4 = SKBar.ex4(edgePadding: 15, interItemSpacing: 28)
    let skBarEx5 = SKBar.ex5(edgePadding: 0, interItemSpacing: 28)
    let skBarEx6 = SKBar.ex6(edgePadding: 0, interItemSpacing: 5)
    
    let spacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(skBarTEx1)
        skBarTEx1.easy.layout(Top().to(view, .topMargin), Leading(), Trailing(), Height(50))
        skBarTEx1.delegate = self
        
        view.addSubview(skBarTEx2)
        skBarTEx2.easy.layout(Top(spacing).to(skBarTEx1), Leading(), Trailing(), Height(50))
        skBarTEx2.delegate = self

        view.addSubview(skBarTEx3)
        skBarTEx3.easy.layout(Top(spacing).to(skBarTEx2), Leading(), Trailing(), Height(50))
        skBarTEx3.delegate = self
        
        view.addSubview(skBarTEx4)
        skBarTEx4.easy.layout(Top(spacing).to(skBarTEx3), Leading(), Trailing(), Height(50))
        skBarTEx4.delegate = self

        view.addSubview(skBarEx4)
        skBarEx4.easy.layout(Top(spacing).to(skBarTEx4), Leading(), Trailing(), Height(50))
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

extension MainViewController: SKBarDelegate {
    func didSelectSKBarItemAt(_ skBar: SKBar, _ index: Int) {
        print("Delegate - Selected item at", index)
    }
}
