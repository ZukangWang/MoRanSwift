//
//  GBMPublishViewController.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/8.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import UIKit
import CoreLocation;

class GBMPublishViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UIAlertViewDelegate,GBMRequestDelegate,GBMLocationRequestDelegate{
    
    //MARK: - Properties
    
    @IBOutlet weak var commentTextView : UITextView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    var tag = 0
    var publishPhoto = UIImage()
    
    private var isShowLocation = false
    private var locationView : UIView?
    private var locationBlackView : UIControl?
    private var locationTableView : UITableView?
    
    private var locationManager: CLLocationManager?
    private var currentLocationLatitude:String?
    private var currentLocationLongitude:String?
    private var locationArray: NSArray?
    
    //MARK: - View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoView.image = self.publishPhoto
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 106/255, blue: 58/255, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 230/255, green: 106/255, blue: 58/255, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, 100, 30))
        titleLabel.text = "发布照片"
        titleLabel.textColor = UIColor.whiteColor()
        
        self.navigationItem.titleView = titleLabel
        
        let publishButton = UIButton(frame: CGRectMake(0,0,49,30))
        publishButton.backgroundColor = UIColor.whiteColor()
        publishButton.alpha = 0.6
        publishButton.setTitle("发布", forState: .Normal)
        publishButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        publishButton.addTarget(self, action: "publish", forControlEvents: .TouchUpInside)
        publishButton.layer.cornerRadius = 3.0
        publishButton.clipsToBounds = true
        
        let rightBarButton = UIBarButtonItem(customView: publishButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let backButton = UIButton(frame: CGRectMake(0,0,49,30))
        backButton.backgroundColor = UIColor.whiteColor()
        backButton.alpha = 0.6
        backButton.setTitle("取消", forState: .Normal)
        backButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        backButton.addTarget(self, action: "canclePublish", forControlEvents: .TouchUpInside)
        backButton.layer.cornerRadius = 3.0
        backButton.clipsToBounds = true
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton

        self.commentTextView.delegate = self
                
        self.getLongitudeAndLatitude()
    }
    
    //MARK: - Publish Methods
    
    @objc func publish(){
        
        let request = GBMPublishRequest()
        
        var params = [String:AnyObject]()
        params["user_id"] = GBMGlobal.user!.userId
        params["token"] = GBMGlobal.user!.token
        params["data"] = UIImageJPEGRepresentation(self.publishPhoto, 0.00001)
        params["title"] = self.commentTextView.text
        params["location"] = self.locationButton.titleLabel?.text
        params["longitude"] = "121.47794"
        params["latitude"] = "31.22516"
        
        request.sendRequest(params, requestDelegate: self)
    }
    
    @objc func canclePublish(){
        
        if self.tag == 1{
            self.commentTextView.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else if self.tag == 2{
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    //MARK: - Request Delegate Methods
    
    func requestSuccess(request: GBMRequestBase, data: AnyObject?) {
        self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        if self.tag == 1{
            self.commentTextView.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else if self.tag == 2{
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func locationRequestSuccess(request: GBMLocationRequest, data: NSArray) {
        self.locationArray = data;
        self.createLocationView()
    }
    
    func requestFailed(request: GBMRequestBase, error: NSError) {
        self.showErrorMessage(error.description)
    }
    
    //MARK: - UITextViewDelegate Methods
    
    func textViewDidChange(textView: UITextView){
        
        let currentTextViewTextCount = textView.text.characters.count
        
        if currentTextViewTextCount > 25 {
            textView.resignFirstResponder()
        }
        
        self.numberLabel.text = "\(currentTextViewTextCount)/25"
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "你想说的话" {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.characters.count <= 0 {
            textView.text = "你想说的话"
        }
    }
    
    @IBAction func touchDownAction(sender: AnyObject) {
        self.commentTextView.resignFirstResponder()
    }
    
    //MARK: - CLLocationManager Delegate Methods
    
    private func getLongitudeAndLatitude(){
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager?.distanceFilter = 1000.0
        self.locationManager?.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.startUpdatingLocation()
        }
        else{
            let locationErrorAlert = UIAlertView(title: "错误", message: "定位失败", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "取消")
            
            locationErrorAlert.show()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        let currentLatitude = newLocation.coordinate.latitude
        let currentLongitude = newLocation.coordinate.longitude
        self.currentLocationLatitude = "\(currentLatitude)"
        self.currentLocationLongitude = "\(currentLongitude)"
        
        let revGeo = CLGeocoder()
        
        revGeo.reverseGeocodeLocation(newLocation, completionHandler: { (placeMarks:[CLPlacemark]?, error:NSError?) in
            if error == nil && placeMarks!.count > 0 {
                
                let placeMark = placeMarks![0] as CLPlacemark
                
                self.locationButton.setTitle(placeMark.name, forState: .Normal)
                
            }
            else{
                print(error)
            }
        })
        
        //停止位置更新
        manager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    //MARK: - Select Location Method
    
    @IBAction func locationButtonClicked(sender: AnyObject){
    
        let locationRequest = GBMLocationRequest()
        
        var params = [String:AnyObject]()
        params["currentLatitude"] = self.currentLocationLatitude!
        params["currentLongitude"] = self.currentLocationLongitude!
        
        locationRequest.sendRequest(params, requestDelegate: self)
    }
    
    @objc private func locationBlackViewClicked(){
        self.hideLocationView()
    }
    
    private func hideLocationView(){
        if self.isShowLocation == true{
            self.locationView?.alpha = 0
            self.locationView = nil
            self.isShowLocation = false
        }
    }
    
    func createLocationView(){
        
        if self.isShowLocation == true {
            return
        }
        
        let locationViewX:CGFloat = 0
        let locationViewY:CGFloat = 0
        let locationViewWidth:CGFloat = self.view.frame.size.width
        let locationViewHeight:CGFloat = self.view.frame.size.height
        
        self.locationView = UIView(frame: CGRectMake(locationViewX,locationViewY,locationViewWidth,locationViewHeight))
        
        let locationTableViewX:CGFloat = locationViewX
        let locationTableViewY:CGFloat = locationViewHeight - 235
        let locationTableViewWidth:CGFloat = locationViewWidth
        let locationTableViewHeight:CGFloat = 235
        
        self.locationTableView = UITableView(frame: CGRectMake(locationTableViewX,locationTableViewY , locationTableViewWidth, locationTableViewHeight),style: .Plain)
        self.locationTableView?.registerNib(UINib(nibName: "GBMPublishCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PublishCell")
        self.locationTableView?.delegate = self
        self.locationTableView?.dataSource = self
        
        self.locationView?.addSubview(self.locationTableView!)
        
        let locationBlackViewX:CGFloat = locationViewX
        let locationBlackViewY:CGFloat = locationViewY
        let locationBlackViewWidth:CGFloat = locationViewWidth
        let locationBlackViewHeight:CGFloat = locationViewHeight - 235
        
        self.locationBlackView = UIControl(frame:CGRectMake(locationBlackViewX, locationBlackViewY, locationBlackViewWidth, locationBlackViewHeight))
        self.locationBlackView?.backgroundColor = UIColor.blackColor()
        self.locationBlackView?.alpha = 0.5
        self.locationBlackView?.addTarget(self, action: "locationBlackViewClicked", forControlEvents: .TouchUpInside)
        
        self.locationView?.addSubview(self.locationBlackView!)
        
        self.view.addSubview(self.locationView!)
        self.isShowLocation = true
    }
    
    //MARK: - UITableView Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.locationArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let publishCell = tableView.dequeueReusableCellWithIdentifier("PublishCell") as! GBMPublishCell
        
        let currentLocationModel = self.locationArray![indexPath.row] as! GBMLocationModel
        publishCell.locationLabel.text = currentLocationModel.address as String
        publishCell.locationNameLabel.text = currentLocationModel.name as String
        
        return publishCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentLocationModel = self.locationArray![indexPath.row] as! GBMLocationModel
        
        self.locationButton.setTitle(currentLocationModel.name as String, forState: .Normal)
        
        self.hideLocationView()
    }
    
}
