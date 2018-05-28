//
//  ViewController.swift
//  MyOmikujiApp
//
//  Created by 吉永秀和 on 2018/05/22.
//  Copyright © 2018年 吉永秀和. All rights reserved.
//

import UIKit
import SpriteKit
class ViewController: UIViewController {
     var skView: SKView?
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func getOmikuji(_ sender: Any) {
        let results = ["大吉", "吉", "中吉", "凶", "大凶"]
//        let random = arc4random_uniform(3)
        let random = arc4random_uniform(UInt32(results.count))
//         self.myLabel.text = results[Int(random)]
        print(myLabel.frame)
        var result = results[Int(random)]
        
        let alertController = UIAlertController(title: "お前の運勢", message: "\(result)だべ", preferredStyle: .alert)
        
        if result == "大吉" {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.myLabel.alpha = 0.0
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseIn], animations: {
                    self.myLabel.alpha = 1.0
                }, completion: nil)
            self.myLabel.text = "おめおめ〜"})
        alertController.addAction(defaultAction)
        } else if result == "吉" {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.myLabel.alpha = 0.0
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseIn], animations: {
                    self.myLabel.alpha = 1.0
                }, completion: nil)
                self.myLabel.text = "よかったね"})
            alertController.addAction(defaultAction)

        } else if result == "中吉" {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.myLabel.alpha = 0.0
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseIn], animations: {
                    self.myLabel.alpha = 1.0
                }, completion: nil)
                self.myLabel.text = "まあまあ"})
            alertController.addAction(defaultAction)
            
        } else if result == "凶" {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.myLabel.alpha = 0.0
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseIn], animations: {
                    self.myLabel.alpha = 1.0
                }, completion: nil)
                self.myLabel.text = "どんまい"})
            alertController.addAction(defaultAction)
            
        } else if result == "大凶" {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.myLabel.alpha = 0.0
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseIn], animations: {
                    self.myLabel.alpha = 1.0
                }, completion: nil)
                self.myLabel.text = "ざまあww"})
            alertController.addAction(defaultAction)
            
        }
        
        self.present(alertController, animated: true, completion: nil)
        alertController.view.layer.cornerRadius = 25
        
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = myLabel.bounds.width / 2
        myLabel.layer.borderColor = UIColor.orange.cgColor
        myLabel.layer.borderWidth = 5
        
        // SKView作成
        createSKView()
        // Sceneを追加
        setupParticle()
        
        self.view.bringSubview(toFront: myButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ①アニメーショングループの作成
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.5
        animationGroup.fillMode = kCAFillModeBackwards
        
        // ②サイズのアニメーション作成
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 2.5
        scaleAnimation.toValue = 1.0
        
        // ③回転のアニメーション作成
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = CGFloat(M_PI_2)
        rotateAnimation.toValue = 0.0
        
        // ④透過のアニメーション作成
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0
        
        // ⑤作成したアニメーションを組み合わせる
        animationGroup.animations = [scaleAnimation, rotateAnimation, opacityAnimation]
        
        // ⑥ViewのLayerにアニメーションをセットする
        myLabel.layer.add(animationGroup, forKey: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createSKView() {
        self.skView = SKView(frame: self.view.frame)
        self.skView!.allowsTransparency = true
    }
    
    func setupParticle() {
        let scene = SKScene(size: self.view.frame.size)
        scene.backgroundColor = UIColor.clear
        
        let path = Bundle.main.path(forResource: "MyParticle", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        particle.name = "MyParticle"
        particle.position = CGPoint(x:self.view.frame.width / 2, y:self.view.frame.height)
        scene.addChild(particle)
        
        self.skView!.presentScene(scene)
        self.view.addSubview(self.skView!)
    }


}

