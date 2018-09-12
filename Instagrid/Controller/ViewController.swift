//
//  ViewController.swift
//  Instagrid
//
//  Created by AMIMOBILE on 27/07/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionUp(_:)))
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionLeft(_:)))
    
    var orientation = UIDevice.current.orientation
    
    @IBOutlet weak var leftPatternButton: UIButton!
    @IBOutlet weak var middlePatternButton: UIButton!
    @IBOutlet weak var rightPatternButton: UIButton!
    
    @IBOutlet weak var applicationsView: ApplicationsView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applicationsView.pattern = .two
        NotificationCenter.default.addObserver(self, selector: #selector(openLibrary), name: Notification.Name(rawValue: "addButtonTapped"), object: nil)
        imagePicker.delegate = self
        
        swipeUp.direction = .up
        swipeUp.numberOfTouchesRequired = 1
        
        swipeLeft.direction = .left
        swipeLeft.numberOfTouchesRequired = 1
       
        
        if orientation == UIDeviceOrientation.portrait {
            applicationsView.addGestureRecognizer(swipeUp)
        } else {
             applicationsView.addGestureRecognizer(swipeLeft)
        }

        
    }
    
    @objc func swipeActionUp(_ : UISwipeGestureRecognizer) {
        applicationsView.isHidden = true
    }
    
    @objc func swipeActionLeft(_ : UISwipeGestureRecognizer) {
        applicationsView.isHidden = true
    }
    
    @IBAction func patternButtonTapped(_ sender: UIButton) {
    
        [leftPatternButton, middlePatternButton, rightPatternButton].forEach {$0.isSelected = false}
        sender.isSelected = true
        
        switch sender.tag {
        case 0:
            applicationsView.pattern = .one
        case 1:
            applicationsView.pattern = .two
        case 2:
           applicationsView.pattern = .three
        default:
            break
        }
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        openLibrary()
    }
    
    
    @objc func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        guard let tag = applicationsView.currentTag else {return}
        
        let imageViews = [applicationsView.topLeftImageView,applicationsView.topRightImageView,applicationsView.bottomLeftImageView,applicationsView.bottomRightImageView]
        let buttons = [applicationsView.topLeftButton,applicationsView.topRightButton,applicationsView.bottomLeftButton,applicationsView.bottomRightButton]
        
        imageViews[tag]?.image = selectedImage
        buttons[tag]?.isHidden = true
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        imageTap.numberOfTapsRequired = 1
        imageViews[tag]?.addGestureRecognizer(imageTap)
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}

