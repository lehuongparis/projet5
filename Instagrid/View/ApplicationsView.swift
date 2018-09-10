//
//  ApplicationView.swift
//  Instagrid
//
//  Created by AMIMOBILE on 03/08/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class ApplicationsView: UIView {

    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIImageView!
    
    var currentTag: Int?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
       currentTag = sender.tag
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addButtonTapped"), object: nil)
    }
    
    var pattern: Pattern! {
        didSet {
            displayDidChanged()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromXib()
    }
    
    func loadViewFromXib() {
        let xib = UINib(nibName: "ApplicationsView", bundle: nil)
        let view = xib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func displayDidChanged() {
        let views = [topLeftView, topRightView, bottomLeftView, bottomRightView]
        for i in 0..<views.count {
            let value = pattern.display[i]
            views[i]?.isHidden = value
        }
    }
    
}
