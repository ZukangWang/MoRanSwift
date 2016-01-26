//
//  GBMViewDetailController.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/2.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMViewDetailController: UIViewController,UITableViewDelegate,UITableViewDataSource,GBMRequestDelegate {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var photoView : UIImageView!
    
    var pic_id = ""
    var pic_url = ""
    var commentArr = NSArray()
    
    //MARK: - View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let activity = UIActivityIndicatorView(frame: CGRectMake(0,0,30,30))
        
        let width = self.view.frame.size.width/2
        activity.center = CGPointMake(width, 160)
        activity.activityIndicatorViewStyle = .WhiteLarge
        
        self.view.addSubview(activity)
        
        activity.startAnimating()
        
        self.photoView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.pic_url as String)!)!)
        self.photoView.contentMode = .ScaleAspectFill
        
        activity.stopAnimating()
        
        let viewDetailRequest = GBMDetailRequest()
        
        var params = [String:AnyObject]()
        params["user_id"] = GBMGlobal.user!.userId
        params["token"] = GBMGlobal.user!.token
        params["pic_id"] = self.pic_id
        
        viewDetailRequest.sendRequest(params, requestDelegate: self)
    }
    
    //MARK: - Request Delegate Methods
    
    func requestSuccess(request: GBMRequestBase, data: AnyObject?) {
        self.commentArr = data as! NSArray
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
    }
    
    func requestFailed(request: GBMRequestBase, error: NSError) {
        self.showErrorMessage(error.description)
    }
    
    //MARK: - TableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.commentArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentListCell", forIndexPath: indexPath) as! GBMCommentListCell
        
        let viewDetailModel = self.commentArr[indexPath.row] as! GBMDetailModel
        
        cell.commentLabel.text =  viewDetailModel.comment
        cell.dateLabel.text = viewDetailModel.modified
        
        return cell
    }
}
