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

    let config = SKBarConfiguration(titleColor: .black,
                                    font: .systemFont(ofSize: 18),
                                    selectedTitleColor: .systemPink,
                                    selectedFont: .systemFont(ofSize: 15),
                                    highlightedTitleColor: .blue,
                                    indicatorColor: .systemPink,
                                    separatorColor: .systemPink.withAlphaComponent(0.2))
    
    let content = [
        SKBarContentModel(title: "Welcome"),
        SKBarContentModel(title: "to"),
        SKBarContentModel(title: "SRVAppBar"),
        SKBarContentModel(title: "This"),
        SKBarContentModel(title: "is"),
        SKBarContentModel(title: "a"),
        SKBarContentModel(title: "very"),
        SKBarContentModel(title: "simple"),
        SKBarContentModel(title: "example"),
        SKBarContentModel(title: "project"),
        SKBarContentModel(title: "with"),
        SKBarContentModel(title: "Title"),
        SKBarContentModel(title: "theme"),
    ]
    
    let titleTheme: SKBarContentType = .title
    
    lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(skBar)
        skBar.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 50)
        
        skBar.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        skBar.interItemSpacing = 20
        skBar.configuration = config
        skBar.items = content
    }


}

