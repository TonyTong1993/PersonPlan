//
//  CaseLayoutViewController.swift
//  KnowledgeTips
//
//  Created by ZZHT on 2018/5/4.
//  Copyright © 2018年 ZZHT. All rights reserved.
//
/*

 
 -setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
 
 -layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
 
 如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局
 
 */
import UIKit

class CaseLayoutViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeLayoutViewFrame(_ sender: Any) {

        if self.heightConstraint.constant == 30.0 {
            self.heightConstraint.constant = self.view.frame.height - 200
        }else {
            self.heightConstraint.constant = 30.0
        }
        UIView.animate(withDuration: 2.0) {
//            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
