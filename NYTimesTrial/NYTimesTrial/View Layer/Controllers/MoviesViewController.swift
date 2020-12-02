//
//  ViewController.swift
//  OddigoTask
//
//  Created by ispha on 7/17/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation
import SkeletonView
class ArticlesViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet var viewModel: ArticlesViewModel!
    @IBOutlet weak var outletoftableview: UITableView!
     // MARK: - variables
    var disposeBag = DisposeBag()
    var arrayOfItems = [Item]()
    var locationManager : CLLocationManager = CLLocationManager()
    var isLocationAccessDenied : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doAnyAdditionalSetup()
    }
    
    func doAnyAdditionalSetup()
    {
        outletoftableview.delegate = self
        registerNibFiles()
        outletoftableview.isSkeletonable = true
        outletoftableview.showAnimatedGradientSkeleton()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        configureDataBinding()
        fetchAndKeepState()
    }
    
    func registerNibFiles()
    {
        
        outletoftableview.register(UINib(nibName: MoviesTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MoviesTableViewCell.identifier())
        
    }
    func configureDataBinding() {
        
        // self.tableView.setContentOffset(.zero, animated: true)
        viewModel.isLoading.skip(1).subscribe(onNext: { [weak self] (isLoading) in
            
            guard let `self` = self else {
                return
            }
            DispatchQueue.main.async {
                
                if isLoading {
                    
                    self.arrayOfItems = self.viewModel.arrayOfItems
                    self.outletoftableview.isSkeletonable = false
                    self.outletoftableview.hideSkeleton()
                    self.outletoftableview.reloadData()
                }
            }
            
        }).disposed(by: disposeBag)
        
        
    }
    
    
    
}
extension ArticlesViewController : UITableViewDelegate, SkeletonTableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // we need one category only for image, titles come form venu it self, the contnet of seciton
        return HelpingMethods.emptyTableView(tableView: tableView, dataCount: arrayOfItems.count, dataCome: true, emptyTableViewMessage: "No movies Found!")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier()) as! MoviesTableViewCell
        if arrayOfItems.count > 0
        {
            cell.isSkeletonable = false
            cell.hideSkeleton()
            let movie = arrayOfItems[indexPath.row]
            cell.configureCellWithPlaceItem(item: movie)
        }
        else
        {
            cell.isSkeletonable = true
            cell.showAnimatedGradientSkeleton()
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
        return arrayOfItems.count == 0 ? 20 : HelpingMethods.emptyTableView(tableView: skeletonView, dataCount: arrayOfItems.count, dataCome: true, emptyTableViewMessage: HelpingMethods.localizeKeyword(word: "no_content"))
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    {
        return MoviesTableViewCell.identifier()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayOfItems.count > indexPath.row
        {
            let detailsVC = UIStoryboard(name: Constants.StoryboardIDs.Main, bundle: nil).instantiateViewController(identifier: Constants.StoryboardVCsIDs.MovieDetailsViewController) as! MovieDetailsViewController
            detailsVC.movieModel = arrayOfItems[indexPath.row]
            self.show(detailsVC, sender: self)
        }
    }
    
}

extension ArticlesViewController{
    func fetchAndKeepState()
    {
        self.viewModel.getData()
        // addPrefetchFeature()
    }
    /*func addPrefetchFeature(){
     // here we check either to go offline or online based on if data fetched once before
     if Storage.fileExists(Constants.TeamsOffline, in: .documents){
     arrayOfTeams = Storage.retrieve(Constants.TeamsOffline , from: .documents, as: [Team].self)
     outletoftableview.reloadData()
     
     }
     else
     {
     self.viewModel.getData(view: self.view)
     
     
     }
     }*/
}
