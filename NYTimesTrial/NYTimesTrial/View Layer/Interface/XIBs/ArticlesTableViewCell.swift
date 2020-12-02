//
//  ArticlesTableViewCell.swift
//  NYTimesTrial
//
//  Created by ispha on 7/18/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import UIKit
import Kingfisher
import PocketSVG
import SkeletonView
class ArticlesTableViewCell: UITableViewCell {
    
    // MARK: - outlets
    
    @IBOutlet weak var outletOfLblTitle: UILabel!
    @IBOutlet weak var outletOfLblDate: UILabel!
    @IBOutlet weak var outletOfLblRating: UILabel!
    @IBOutlet weak var outletOfImgvPoster: UIImageView!
    
    // MARK: - variables
    override func awakeFromNib() {
        super.awakeFromNib()
        outletOfImgvPoster.isSkeletonable = true
        outletOfImgvPoster.showAnimatedGradientSkeleton()
        outletOfLblTitle.isSkeletonable = true
        outletOfLblTitle.showAnimatedGradientSkeleton()
        outletOfLblDate.isSkeletonable = true
        outletOfLblDate.showAnimatedGradientSkeleton()
        outletOfLblRating.isSkeletonable = true
        outletOfLblRating.showAnimatedGradientSkeleton()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    open class func identifier() -> String {
        return String(describing:   ArticlesTableViewCell.self)
    }
    func configureCellWithPlaceItem(item:Item)
    {
        outletOfImgvPoster.isSkeletonable = false
        outletOfImgvPoster.hideSkeleton()
        outletOfLblTitle.isSkeletonable = false
        outletOfLblTitle.hideSkeleton()
        outletOfLblDate.isSkeletonable = false
        outletOfLblDate.hideSkeleton()
        outletOfLblRating.isSkeletonable = false
        outletOfLblRating.hideSkeleton()
        outletOfLblTitle.text = item.title
        outletOfLblDate.text = item.publishedDate
        outletOfImgvPoster.kf.setImage(with: URL(string: (item.media ?? []).count > 0 ? ((item.media?[0].mediaMetadata ?? [] ).count > 0 ? item.media?[0].mediaMetadata?[0].url ?? "" : "") : "") , placeholder:HelpingMethods.colorWithHexString(Constants.Colors.imgColor).imageWithColor(width: outletOfImgvPoster.frame.size.width, height: outletOfImgvPoster.frame.size.height) )
        outletOfLblRating.text = "By \(item.byline ?? "---")"
        outletOfImgvPoster.layer.cornerRadius = outletOfImgvPoster.frame.size.width / 2
    }
    
    func snapshotImage(for view: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func setRating(rate:Int)
    {
        for tag in 100..<105
        {
            (self.viewWithTag(tag) as! UIButton).setBackgroundImage(UIImage(named: tag <= rate + 100 ? "selectedStar" : "ignoredStar"), for: .normal)
        }
    }
    
}
