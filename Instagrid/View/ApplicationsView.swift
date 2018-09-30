//
//  ApplicationView.swift
//  Instagrid
//
//  Created by AMIMOBILE on 03/08/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class ApplicationsView: UIView {

    // MARK: - Outlet
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
    
    // MARK: - Vars
    var currentTag: Int?
    var pattern: Pattern! {
        didSet {
            displayDidChanged()
        }
    }
    
    // MARK: - Method
    
    // Action when we tap on the button, send the notification named "addButtonTapped" to Controller
    @IBAction func buttonTapped(_ sender: UIButton) {
       currentTag = sender.tag
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addButtonTapped"), object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromXib()
    }
    
    // Method for loading Xib to Storyboard
    func loadViewFromXib() {
        let xib = UINib(nibName: "ApplicationsView", bundle: nil)
        let view = xib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    // Method for changing pattern of view when we select the model desired
    func displayDidChanged() {
        let views = [topLeftView, topRightView, bottomLeftView, bottomRightView]
        for i in 0..<views.count {
            let value = pattern.display[i]
            views[i]?.isHidden = value
        }
    }
    
}
