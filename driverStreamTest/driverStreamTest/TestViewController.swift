//
//  TestViewController.swift
//  driverStreamTest
//
//  Created by JiangQian on 12/10/2017.
//  Copyright © 2017 JiangQian. All rights reserved.
//

import SnapKit

class TestViewController: UIViewController {
    lazy var box = UIView()
    //a label used to test the Auto Layout
    var nameLabel = UILabel()
    var testButton = UIButton()
    
    //When the button clicked
    @objc func buttonClicked(){
        //change namelabel
        nameLabel.text = "Marius"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(box)
        //initialize the box
        box.backgroundColor = UIColor.purple
        //initialize the label
        nameLabel.text = "Melody"
        nameLabel.textColor = UIColor.cyan
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.adjustsFontSizeToFitWidth = true
        //initialize the button
        testButton.backgroundColor = UIColor.brown
        testButton.setTitle("love you", for: UIControlState())
        testButton.layer.cornerRadius = 5
        testButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        box.addSubview(nameLabel)
        self.view.addSubview(testButton)
        nameLabel.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        testButton.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel).offset(20)
            make.bottom.equalTo(box).offset(50)
        }
        box.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.center.equalTo(self.view)
        }
        
    }
}
