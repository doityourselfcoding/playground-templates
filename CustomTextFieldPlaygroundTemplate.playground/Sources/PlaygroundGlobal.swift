//
//  PlagroundGlobal.swift
//  PkUpCustomer
//
//  Created by PkUp App on 3/24/16.
//  Copyright © 2016 PkUp LLC. All rights reserved.
//


import UIKit

public enum ScreenSize{
    case xSmall
    case small
    case medium
    case large
    
    public func toWidth() -> CGFloat{
        switch self {
        case .xSmall:
            return CGFloat(320)
        case .small:
            return CGFloat(320)
        case .medium:
            return CGFloat(375)
        case .large:
            return CGFloat(414)
        }
    }
    
    
    public func toHeight() -> CGFloat{
        switch self {
        case .xSmall:
            return CGFloat(480)
        case .small:
            return CGFloat(568)
        case .medium:
            return CGFloat(667)
        case .large:
            return CGFloat(736)
        }
    }
    
    public func toSize() -> CGSize{
        
        return CGSize(width: toWidth(), height: toHeight())
        
    }
    
    public func toFrame() -> CGRect{
        
        return CGRect(x:0,y:0,width:toWidth(),height:toHeight())
        
    }
    
    
}


public let screenSize = ScreenSize.xSmall

public let style = StyleKit(width: screenSize.toWidth())
