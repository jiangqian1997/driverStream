//
//  TestViewController.swift
//  driverStreamTest
//
//  Created by JiangQian on 12/10/2017.
//  Copyright © 2017 JiangQian. All rights reserved.
//

import SnapKit
import Alamofire
import SwiftyJSON

let user = "user"
let password = "password"

var headers: HTTPHeaders = [:]









class TestViewController: UIViewController {
    //通过一个数组获取原来的资源信息
    var recordInfo = [String]()
    lazy var box = UIView()
    //a label used to test the Auto Layout
    var nameLabel = UILabel()
    var testButton = UIButton()
    
    //When the button clicked
    @objc func buttonClicked(){
        //change namelabel
        nameLabel.text = "Marius"
    }
    
    //获取请求
    func makeRequest() {
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password){
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request("http://127.0.0.1:8888/api/home").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            let json = JSON(data: response.data!)
            for index in 0..<json["data"].count{
                if let loverName = json["data"][index][1].string {
                    self.recordInfo.append(loverName)
                }
            }
//            self.nameLabel.text = self.recordInfo[1]
        }
    }

    
    
    override func viewDidLoad() {
        let delay: TimeInterval = 0.5
        self.makeRequest()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            print(self.recordInfo.count)
            super.viewDidLoad()
            self.view.addSubview(self.box)
            //initialize the box
            self.box.backgroundColor = UIColor.purple
            //initialize the label
            self.nameLabel.text = self.recordInfo[1]
            self.nameLabel.textColor = UIColor.cyan
            self.nameLabel.textAlignment = NSTextAlignment.center
            self.nameLabel.adjustsFontSizeToFitWidth = true
            //initialize the button
            self.testButton.backgroundColor = UIColor.brown
            self.testButton.setTitle("Level", for: UIControlState())
            self.testButton.layer.cornerRadius = 5
            self.testButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
            self.box.addSubview(self.nameLabel)
            self.view.addSubview(self.testButton)
            self.nameLabel.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.center.equalTo(self.view)
            }
            self.testButton.snp.makeConstraints { (make) in
                make.left.equalTo(self.nameLabel).offset(20)
                make.bottom.equalTo(self.box).offset(50)
            }
            self.box.snp.makeConstraints { (make) in
                make.width.height.equalTo(200)
                make.center.equalTo(self.view)
            }
        }
        
        
    }
}
