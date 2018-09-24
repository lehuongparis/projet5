//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by AMIMOBILE on 21/09/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    open override var shouldAutorotate: Bool { return true }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .all }
}
