//
//  ViewController.swift
//  Instagrid
//
//  Created by AMIMOBILE on 27/07/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Vars
    private let imagePicker = UIImagePickerController()
    private var orientation = UIDevice.current.orientation
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    // MARK: - Outlets
    @IBOutlet weak var leftPatternButton: UIButton!
    @IBOutlet weak var middlePatternButton: UIButton!
    @IBOutlet weak var rightPatternButton: UIButton!
    @IBOutlet weak var applicationsView: ApplicationsView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObserver()
        setUpBehaviors()
    }
    
    // MARK: - Action
    // Select pattern when button tapped
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
    
    // MARK: - Method
    //
    private func setUpObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(openSourceImage), name: Notification.Name(rawValue: "addButtonTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // Adding gesture for Application View
    private func setUpBehaviors() {
        applicationsView.pattern = .two
        imagePicker.delegate = self
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(sender:)))
        
        setupSwipeDirection()
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        applicationsView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    // Direction of swipe according to orientation of screen
   @objc private func setupSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    // Application View disappears at the end of animation
    func tranformApplicationsView() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            UIView.animate(withDuration: 2.0, animations: {
                self.applicationsView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            })
        } else {
            UIView.animate(withDuration: 2.0, animations: {
                self.applicationsView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
        }
    }
    
    // Sharing Application View for other application
    func shareApplicationsView() {
        guard let image = applicationsView.convertToUIImage() else { return }
        let activityApplicationsView = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityApplicationsView, animated: true, completion: nil)
        activityApplicationsView.completionWithItemsHandler = { _ , _ , _, _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.applicationsView.transform = .identity
            })
        }
    }
    
    // For animating and sharing Application View
    @objc func swipeAction(sender : UISwipeGestureRecognizer) {
        tranformApplicationsView()
        shareApplicationsView()
    }

    // Tapping for adding photos
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        applicationsView.currentTag = sender.view?.tag
        openSourceImage()
    }
    
    // selecting Source of Photos
    @objc func openSourceImage() {
        let alert = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
            self.openLibrary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Using Camera for taking photos
    func openCamera() {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Using Library for selecting photos
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - Swift updated
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}


// MARK: - Extension
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {return}
        guard let tag = applicationsView.currentTag else {return}
        
        let imageViews = [applicationsView.topLeftImageView,applicationsView.topRightImageView,applicationsView.bottomLeftImageView,applicationsView.bottomRightImageView]
        let buttons = [applicationsView.topLeftButton,applicationsView.topRightButton,applicationsView.bottomLeftButton,applicationsView.bottomRightButton]
        imageViews[tag]?.image = selectedImage
        buttons[tag]?.isHidden = true
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        imageViews[tag]?.addGestureRecognizer(imageTap)
        dismiss(animated: true, completion: nil)
    }
}
