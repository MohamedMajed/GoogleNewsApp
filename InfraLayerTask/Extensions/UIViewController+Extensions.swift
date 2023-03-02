//
//  UIViewController+Extensions.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 02/03/2023.
//

import UIKit
import FittedSheets

extension UIViewController {
    func presentSheetController(viewToPresent: BottomSheetVC, topCornersRadius: CGFloat = 12, fullScreenModel: Bool = false, height: CGFloat, dismissOnTap: Bool = true, dismissable: Bool = true, adjustToKeyboard: Bool = true){
            
            let mySize: SheetSize = .fixed(CGFloat(height))
            var sheet = SheetViewController(controller: viewToPresent, sizes: [mySize])
            if fullScreenModel{
                sheet = SheetViewController(controller: viewToPresent, sizes: [mySize, .fullscreen])
            }
            
            // autoAdjustToKeyboard : Show keyboard over the content of the sheet vc
            sheet.autoAdjustToKeyboard = adjustToKeyboard
            sheet.dismissOnPull = dismissable
            sheet.dismissOnOverlayTap = dismissOnTap
            sheet.allowPullingPastMaxHeight = false
            sheet.cornerRadius = topCornersRadius
            viewToPresent.sheetCtl = sheet
            self.present(sheet, animated: false, completion: nil)
        }
}
