//
//  HelpingMethods.swift
//  NYTimesTrial
//
//  Created by ispha on 7/18/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration


@objc class HelpingMethods : NSObject
{
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
        
        
    }
    class  func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height:  CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
        
    }
    
    // when not in debug mode stop printing to consol
    
    static var amInDebugmodeSoPrintingIsAllwed = true
    
    // MARK: isphaSuperPrintFunction
    class  func printStringBy_ispha(string:String)
    {
        if amInDebugmodeSoPrintingIsAllwed == true
        {
            print(string)
        }
    }
    class  func printAnyobjectBy_ispha(anyObject:AnyObject)
    {
        if amInDebugmodeSoPrintingIsAllwed == true
        {
            print(anyObject)
        }
    }
    
    class  func printStringWithAnyobjectBy_ispha(string:String , anyObject:AnyObject)
    {
        if amInDebugmodeSoPrintingIsAllwed == true
        {
            print("\(string) , \(anyObject)")
        }
    }
    class  func printCustomObjectBy_ispha( anyObject:AnyObject)
    {
        if amInDebugmodeSoPrintingIsAllwed == true
        {
            
            print(" \(anyObject)")
            let mirrored_object = Mirror(reflecting: anyObject)
            
            for (index, attr) in mirrored_object.children.enumerated() {
                if let property_name = attr.label as String? {
                    print("🔥 Attr \(index): \(property_name) = \(attr.value)")
                }
            }
        }
    }
    class    func showAlertBy__ispha(title:String,messgae:String,delegate:UIViewController)
    {
        
        
        let alertController = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: NSLocalizedString("حسنا", comment: ""), style: .default) { (action) in
            //  delegate.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        delegate.present(alertController, animated: true, completion: nil)
    }
    class  func colorWithHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() //.stringByTrimmingCharactersInSet().uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    class  func noDataFound(tableView : UITableView,msg:String) {
        
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = msg
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        // noDataLabel.font = UIFont(name: "DroidKufi-Regular", size: 16)
        tableView.backgroundView  = noDataLabel
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    class func showAlert(title:String,messgae:String,delegate:UIViewController)
    {
        
        let alertController = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: HelpingMethods.localizeKeyword(word: "ok"), style: .default) { (action) in
            //  delegate.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        delegate.present(alertController, animated: true, completion: nil)
    }
    
    class func alertCompletion(title: String , message :String ,delegate:UIViewController, alertActionTitle:String,action : ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertActionTitle, style: .default, handler:action)
        alert.addAction(okAction)
        
        delegate.present(alert, animated: true, completion: nil)
        
        
    }
    
    class func alertCompletionwithCancel(title: String , message :String ,delegate:UIViewController, alertActionTitle:[String],action : ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertActionTitle[0], style: .destructive, handler:action)
        
        let cancelAction = UIAlertAction(title: alertActionTitle[1], style: .default, handler:nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        delegate.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    class func printString(string:String)
    {
        if amInDebugmodeSoPrintingIsAllwed == true
        {
            print(string)
        }
    }
    class func printStringWithAnyobject(string:String , anyObject:AnyObject)
    {
        if amInDebugmodeSoPrintingIsAllwed == true
        {
            print("\(string) , \(anyObject)")
        }
    }
    class func makeViewBorderRounder(view:UIView,cornerRadius:CGFloat,borderColor:UIColor = .white,borderWidth:CGFloat = 0){
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
        view.layer.masksToBounds = true
    }
    class func makeViewCorner(view: UIView , roundedCorners: UIRectCorner , cornerRadius: CGFloat = 8.0) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: roundedCorners , cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        view.layer.mask = rectShape
        print("")
    }
    
    class func calculateHeight(inString:String,size:Float,width:CGFloat) -> CGFloat {
        let messageString = inString
        let attributes  = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return ceil(requredSize.height)
    }
    class func retrieveImage(forKey key: String,
                             inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
               let fileData = FileManager.default.contents(atPath: filePath.path),
               let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
               let image = UIImage(data: imageData) {
                return image
                
            }
        }
        
        return nil
    }
    class func retrieveFont(forKey key: String,
                            inStorageType storageType: StorageType) -> UIFont? {
        
        if let filePath = self.filePath(forKey: key),
           let fileData = FileManager.default.contents(atPath: filePath.path),
           let dataProvider = CGDataProvider(data: fileData as CFData)
        {
            let cgFont = CGFont(dataProvider)
            
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(cgFont!, &error)
            {
                print("Error loading Font!=\(error.debugDescription)")
                //return nil
                let fontName = cgFont?.postScriptName
                let font = UIFont(name: String(fontName!) , size: 20)
                return font
                
            } else {
                let fontName = cgFont?.postScriptName
                let font = UIFont(name: String(fontName!) , size: 20)
                return font
                
            }
            
        }
        
        
        return nil
    }
    
    class  func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    public func retrieveImageAsData(forKey key: String,
                                    inStorageType storageType: StorageType) -> Data? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
               let fileData = FileManager.default.contents(atPath: filePath.path){
                return fileData
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data {
                return imageData
            }
        }
        
        return nil
    }
    
    
    public func retrieveImage(forKey key: String,
                              inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
               let fileData = FileManager.default.contents(atPath: filePath.path),
               let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
               let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return nil
    }
    public func store(data: Data,
                      forKey key: String,
                      withStorageType storageType: StorageType,imageName:String,categoryName:String) {
        
        
        UserDefaults.standard.set(true, forKey: imageName)
        
        
        //if let pngRepresentation = image.pngData() {
        switch storageType {
        case .fileSystem:
            if let filePath = filePath(forKey: key) {
                do  {
                    try data.write(to: filePath,
                                   options: .atomic)
                    DispatchQueue.main.async {
                        
                        
                    }
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
            
        case .userDefaults:
            UserDefaults.standard.set(data,
                                      forKey: key)
            DispatchQueue.main.async {
                
                
            }
        }
        //}
        
    }
    public func storeFont(data: Data,
                          forKey key: String,
                          withStorageType storageType: StorageType,imageName:String,categoryName:String) {
        
        
        switch storageType {
        case .fileSystem:
            if let filePath = filePath(forKey: "\(imageName)_font") {
                do  {
                    try data.write(to: filePath,
                                   options: .atomic)
                    DispatchQueue.main.async {
                        
                        
                    }
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
            
        case .userDefaults:
            UserDefaults.standard.set(data,
                                      forKey: "\(imageName)_font")
            DispatchQueue.main.async {
                
                
            }
        }
        
        
    }
    public func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key)
    }
    
    public func save(withName:String,img:Data?,categoryName:String) {
        
        if let buildingImage = img {
            DispatchQueue.global(qos: .background).async {
                self.store(data: buildingImage,
                           forKey: withName,
                           withStorageType: .fileSystem, imageName: withName, categoryName: categoryName)
                
            }
        }
    }
    
    class func secondsToHoursMinutesSeconds (seconds : Int) -> (d:Int,h:Int,m:Int,s:Int) {
        
        return (d:Int(seconds / 86400),h:Int((seconds % 86400) / 3600),m: Int((seconds % 3600) / 60),s: Int((seconds % 3600) % 60))
    }
    class func MakeCall(number:String,delegate:UIViewController)
    {
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
        else
        {
            showAlert(title: "", messgae: HelpingMethods.localizeKeyword(word: "Can't Makle call for this number"), delegate: delegate)
        }
    }
    
    class    func contentNotFound(tableView:UITableView,enable:Bool,msg:String) {
        
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.numberOfLines = 0
        noDataLabel.text = enable == true ? msg : ""
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        // noDataLabel.font = UIFont(name: "DroidKufi-Regular", size: 16)
        tableView.backgroundView  = noDataLabel
        
        tableView.reloadData()
    }
    
    
    class func emptyTableView(tableView:UITableView,dataCount:Int,dataCome:Bool,emptyTableViewMessage:String)->Int{
        if dataCome{
            if dataCount > 0
            {
                // tableView.separatorStyle = seperatorStyle
                tableView.backgroundView = nil
            }
            else
            {
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                noDataLabel.text          = emptyTableViewMessage
                noDataLabel.textColor     = UIColor.darkGray
                noDataLabel.textAlignment = .center
                tableView.backgroundView  = noDataLabel
                // tableView.separatorStyle  = seperatorStyle
            }
            return dataCount
        }
        return 0
    }
    
    class func alertCompletionBy__abonabih(title: String , message :String ,delegate:UIViewController, alertActionTitle:String,action : ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertActionTitle, style: .default, handler:action)
        alert.addAction(okAction)
        
        delegate.present(alert, animated: true, completion: nil)
        
        
    }
    
    class func cellStyle(containerView:UIView)
    {
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOpacity = 4
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 5
    }
    
    class func makeViewBorder(view: UIView,borderWidth: CGFloat = 0.0,borderColor:UIColor = .clear)
    {
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
    }
    class func makeViewShadow(view:UIView,shadowOpacity:Float,shadowRadius:CGFloat,shadowColor:UIColor)
    {
        
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = shadowRadius
    }
    
    class func localizeKeyword(word:String)->String
    {
        return NSLocalizedString(word, comment: "")
    }
    class func showToast(controller:UIViewController,message:String,seconds:Double,success:Bool)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        if success
        {
            alert.view.backgroundColor = UIColor.green
        }
        else
        {
            alert.view.backgroundColor = UIColor.red
        }
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
        
    }
    
    class func dropBtnTextShadow(btn:UIButton)
    {
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowRadius = 1
        btn.layer.shadowOpacity = 1.0
    }
    class func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 0.5
        
        UIView.animate(withDuration: animationDuration, delay: delay, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            view.alpha = 0
        }, completion: { _ in
            view.alpha = 1
        })
        
    }
    
    
    
}

enum StorageType {
    case userDefaults
    case fileSystem
}
