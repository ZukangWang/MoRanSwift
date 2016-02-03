//
//  GBMSquareCell.swift
//  蓦然
//
//  Created by 王祖康 on 15/12/24.
//  Copyright © 2015年 com.GeekBand. All rights reserved.
//

import UIKit

protocol GBMSquareCollectionCellDelegate{
    func collectionCellSelected(picID:String,picUrl:String)
}

class GBMSquareCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataArr = [GBMPictureModel]()
    
    var delegate:GBMSquareCollectionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! GBMSquareCollectionCell
        
        let pictureModel = dataArr[indexPath.row]
        
        var pic = pictureModel.pictureLink
        
        pic = pic.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let pic_url = NSURL(string: pic)
        
        cell.pictureImageView.kf_setImageWithURL(pic_url!)
        //cell.pictureImageView.contentMode = .ScaleAspectFill

        cell.titleLabel.text = pictureModel.title
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let pictureModel = dataArr[indexPath.row]
        
        self.delegate?.collectionCellSelected(pictureModel.picureId, picUrl: pictureModel.pictureLink)
    }
}
