//
//  UIDeviceExtension.swift
//
//
//  Created by Lucas Frazão on 25/09/21.
//

import UIKit

enum iPad: CGFloat {
    
    case iPadPro12_9 = 1024
    case iPadPro11, iPadPro10_5, iPadAir10 = 834
    case iPadPro9_7, iPadAir9_7 = 768
    case iPad10_2 = 810
    
}

extension UIDevice {
    
    func iPadSize(for iPad: iPad) -> CGFloat {
        switch iPad {
            case .iPadPro12_9:
                return 1024
            case .iPadPro11:
                return 834
            case .iPadPro10_5:
                return 834
            case .iPadAir10:
                return 834
            case .iPadPro9_7:
                return 768
            case .iPadAir9_7:
                return 768
            case .iPad10_2:
                return 810
        }
        
    }
    
}



