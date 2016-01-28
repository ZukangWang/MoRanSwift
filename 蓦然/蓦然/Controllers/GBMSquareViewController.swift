//
//  GBMSquareViewController.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/18.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMSquareViewController: UITableViewController,GBMRequestDelegate,GBMSquareCollectionCellDelegate {
    
    //MARK: - Property
    
    var addrArray = [String]()
    
    var dataDic = NSDictionary()
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //给navigationController设置背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.colorToRGB("#ee7f4l")
        
        let titleButton = UIButton(type: .Custom)
        titleButton.setTitle("全部", forState: .Normal)
        titleButton.frame = CGRect(x: 0, y: 0, width: 200, height: 35)
        titleButton.addTarget(self, action: nil, forControlEvents: .TouchDragInside)
        
        self.navigationItem.titleView = titleButton
        
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "square_selected")
    
        self.navigationController?.tabBarItem.setTitleTextAttributes(
        [NSForegroundColorAttributeName:UIColor.colorToRGB("#ee7f4l")],
        forState: .Selected)
        
        self.requestData()
    }
    
    func requestData(){
        
        let squareRequest = GBMSquareRequest()
        
        var params = [String:AnyObject]()
        params["user_id"] = GBMGlobal.user!.userId
        params["token"] = GBMGlobal.user!.token
        params["longitude"] = "121.47794"
        params["latitude"] = "31.22516"
        params["distance"] = "1000"
        
        squareRequest.sendRequest(params, requestDelegate: self)
    }

    //MARK: - GBMRequestDelegate Methods
    
    func requestSuccess(request: GBMRequestBase, data: AnyObject?) {
        
        let returnData = data as! Dictionary<String,Array<GBMPictureModel>>

        self.addrArray = [String](returnData.keys)
        
        self.dataDic = returnData
        
        self.tableView.reloadData()
    }
    
    func requestFailed(request: GBMRequestBase, error: NSError) {
        self.showErrorMessage(error.description)
    }
    
    //TableView Delegate Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addrArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("squareCell", forIndexPath: indexPath) as! GBMSquareCell
        
        cell.delegate = self

        let address = self.addrArray[indexPath.row]
        cell.locationLabel.text = address
        
        cell.dataArr = self.dataDic[address] as! Array<GBMPictureModel>
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func collectionCellSelected(picID: String, picUrl: String) {
        
        let mainStoryboard = UIStoryboard(name: "GBMMain", bundle: NSBundle.mainBundle())
        let viewDetailVC = mainStoryboard.instantiateViewControllerWithIdentifier("ViewDetailStoryboard") as! GBMViewDetailController
        viewDetailVC.pic_id = picID
        viewDetailVC.pic_url = picUrl
        
        self.navigationController?.pushViewController(viewDetailVC, animated: true)
    }
}
