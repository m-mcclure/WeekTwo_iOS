//
//  GalleryViewController.swift
//  Filter
//
//  Created by Matthew McClure on 8/14/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Photos

protocol ImageSelectedDelegate : class {
  func controllerDidSelectImage(UIImage) -> (Void)
}

class GalleryViewController: UIViewController {
  
  var fetchResult : PHFetchResult!
  let cellSize = CGSize(width: 100, height: 100)
  var desiredFinalImageSize : CGSize!
  var startingScale : CGFloat = 0
  var scale : CGFloat = 0
  
  @IBOutlet weak var collectionView: UICollectionView!
  weak var delegate : ImageSelectedDelegate?
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)

      collectionView.dataSource = self
      collectionView.delegate = self
      
      
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchRecognized:")
      //***what would would a target be other than "self"?
      
      collectionView.addGestureRecognizer(pinchGesture)
      
    }

  func pinchRecognized(pinch : UIPinchGestureRecognizer) {
    //println(pinch.scale)
    
    if pinch.state == UIGestureRecognizerState.Began {
      println("began!")
      startingScale = pinch.scale
    }
    
    if pinch.state == UIGestureRecognizerState.Changed {
      println("changed!")
    }
    
    if pinch.state == UIGestureRecognizerState.Ended {
      println("ended!")
      scale = startingScale * pinch.scale
      let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      let newSize = CGSize(width: layout.itemSize.width * scale, height: layout.itemSize.height * scale)
      
      collectionView.performBatchUpdates({ () -> Void in
        layout.itemSize = newSize
        layout.invalidateLayout()
        }, completion: nil )
    }
  }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: UICollectionViewDataSource
extension GalleryViewController : UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fetchResult.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as! ThumbnailCell
    
    if let asset = fetchResult[indexPath.row] as? PHAsset {
      PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: cellSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
        
        if let image = image {
          println("calling request handler for row :\(indexPath.row) for image size: \(image.size)")
          cell.imageView.image = image
        }
      }
    }
    return cell
  }
}

//MARK: UICollectionViewDelegate 
extension GalleryViewController : UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
    
    let options = PHImageRequestOptions()
    options.synchronous = true
    
    if let asset = fetchResult[indexPath.row] as? PHAsset {
      PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: desiredFinalImageSize, contentMode: PHImageContentMode.AspectFill, options: options) { (image, info) -> Void in
        
        if let image = image {
          println("calling request handler for row :\(indexPath.row) for image size: \(image.size)")
          self.delegate?.controllerDidSelectImage(image)
          self.navigationController?.popViewControllerAnimated(true)
        } else {
          println("image didn't load")
        }
      }
    }
  }
}
