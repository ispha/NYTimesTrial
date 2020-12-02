//
//  ArticleDetailsViewController.swift
//  OdiggoTask
//
//  Created by ispha on 11/14/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import UIKit
import SkeletonView
import RxSwift
import SafariServices
class ArticleDetailsViewController: UIViewController,SFSafariViewControllerDelegate {
    @IBOutlet var viewModel: ArticlesViewModel!
    @IBOutlet weak var outletoftableview: UITableView!
    @IBOutlet weak var outletOfLblOverview: UILabel!
    @IBOutlet weak var outletOfLblGeners: UILabel!
    @IBOutlet weak var outletOfLblrelaseYear: UILabel!
    @IBOutlet weak var outletOfLblRating: UILabel!
    @IBOutlet weak var outletOfLblTitle: UILabel!
    @IBOutlet weak var outletOfViewHeader: UIView!
    @IBOutlet weak var outletOfImgv: UIImageView!
    // MARK: - variables
    var disposeBag = DisposeBag()
    var arrayOfActors = [String]()
    var isLocationAccessDenied : Bool = false
    var articleID : Int?
    var articleModel : Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doAnyAdditionalSetup()
    }
    
    func doAnyAdditionalSetup()
    {
        registerNibFiles()
        outletoftableview.isSkeletonable = true
        outletoftableview.showAnimatedGradientSkeleton()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        configureDataBinding()
    }
    
    func registerNibFiles()
    {
        
        outletoftableview.register(UINib(nibName: ArticlesTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: ArticlesTableViewCell.identifier())
        
    }
    func configureDataBinding() {
        self.arrayOfActors = self.articleModel?.perFacet ?? []
        self.refreshScene()
        self.outletoftableview.isSkeletonable = false
        self.outletoftableview.hideSkeleton()
        self.outletoftableview.reloadData()
        
        
    }
    func refreshScene()
    {
        guard let model = articleModel
        else
        {
            return
        }
        outletOfLblTitle.text = "Title:\(model.title ?? "")"
        outletOfLblOverview.text = "Abstract: \(model.abstract ?? "")"
        outletOfImgv.kf.setImage(with: URL(string: (model.media ?? []).count > 0 ? ((model.media?[0].mediaMetadata ?? [] ).count > 2 ? model.media?[0].mediaMetadata?[2].url ?? "" : "") : "") , placeholder:HelpingMethods.colorWithHexString(Constants.Colors.imgColor).imageWithColor(width: outletOfImgv.frame.size.width, height: outletOfImgv.frame.size.height) )
        
        outletOfLblRating.text = "By: \(model.byline ?? "---")"
        outletOfLblGeners.text = "Source: \(model.source ?? "---")\n Section: \(model.section ?? "---")"
        outletOfLblrelaseYear.text = "Publish date: \(model.publishedDate ?? "---")"
        let h =  HelpingMethods.heightForLabel(text: outletOfLblTitle.text!, font: outletOfLblTitle.font, width: outletOfLblTitle.frame.size.width) + HelpingMethods.heightForLabel(text: outletOfLblOverview.text!, font: outletOfLblOverview.font, width: outletOfLblOverview.frame.size.width) + HelpingMethods.heightForLabel(text: outletOfLblRating.text!, font: outletOfLblRating.font, width: outletOfLblRating.frame.size.width) + HelpingMethods.heightForLabel(text: outletOfLblrelaseYear.text!, font: outletOfLblrelaseYear.font, width: outletOfLblrelaseYear.frame.size.width) + HelpingMethods.heightForLabel(text: outletOfLblGeners.text!, font: outletOfLblGeners.font, width: outletOfLblGeners.frame.size.width) + HelpingMethods.heightForLabel(text: outletOfLblRating.text!, font: outletOfLblRating.font, width: outletOfLblRating.frame.size.width) + CGFloat( 200 +  20 + 27 + 12 + 72 + 50 )
        outletOfViewHeader.frame = CGRect(x: outletOfViewHeader.frame.origin.x, y: outletOfViewHeader.frame.origin.y, width: outletOfViewHeader.frame.size.width, height: h)
        outletOfViewHeader.layoutIfNeeded()
        
        //
    }
    // MARK: - Actions
    @IBAction func actionOfBtnFav(_ sender: Any) {
        HelpingMethods.showAlert(title: "", messgae: "Comming soon!", delegate: self)
    }
    @IBAction func actionOfBtnRating(_ sender: Any) {
        
        guard let urlString = articleModel?.url else {
            return
        }
        if let  url = URL(string:urlString.replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\"", with: ""))
        {
            let controller = SFSafariViewController(url: url)
            
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
extension ArticleDetailsViewController : UITableViewDataSource, SkeletonTableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // we need one category only for image, titles come form venu it self, the contnet of seciton
        return HelpingMethods.emptyTableView(tableView: tableView, dataCount: arrayOfActors.count, dataCome: true, emptyTableViewMessage: "No articles Found!")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell")!
        let lblActor = cell.viewWithTag(1) as! UILabel
        
        if arrayOfActors.count > 0
        {
            cell.isSkeletonable = false
            cell.hideSkeleton()
            
            lblActor.isSkeletonable = false
            lblActor.hideSkeleton()
            lblActor.text = arrayOfActors[indexPath.row]
            
        }
        else
        {
            cell.isSkeletonable = true
            cell.showAnimatedGradientSkeleton()
            lblActor.isSkeletonable = true
            lblActor.showAnimatedGradientSkeleton()
        }
        
        // am showing title and address of venu plus image of first item in category
        
        
        
        return cell
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int
    {
        return 1
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfActors.count == 0 ? 20 : HelpingMethods.emptyTableView(tableView: skeletonView, dataCount: arrayOfActors.count, dataCome: true, emptyTableViewMessage: HelpingMethods.localizeKeyword(word: "no_content"))
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    {
        return ArticlesTableViewCell.identifier()
    }
    
}


