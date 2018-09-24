//
//  UIView.swift
//  Instagrid
//
//  Created by AMIMOBILE on 21/09/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

extension UIView {
    func convertToUIImage()->UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}



