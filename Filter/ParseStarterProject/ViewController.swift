//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var alertButton: UIButton!
  @IBAction func buttonPreseed(sender: UIButton) {
    alert.modalPresentationStyle = UIModalPresentationStyle.Popover
    
    if let popover = alert.popoverPresentationController {
      popover.sourceView = view
      popover.sourceRect = alertButton.frame
    }
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  let picker: UIImagePickerController = UIImagePickerController()
  
  let alert = UIAlertController(title: "Button Clicked", message: "Yes the button was clicked", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
      println("alert cancelled")
    }
    
    let chooseOrTakePhotoAction = UIAlertAction(title: "Choose or Take Photo", style: UIAlertActionStyle.Default) { (alert) -> Void in
      self.presentViewController(self.picker, animated: true, completion: nil)
    }
    
    let sepia = UIAlertAction(title: "Sepia", style: .Default) { (alert) -> Void in
      
      let image = CIImage(image: self.imageView.image!)
      let sepiaFilter = CIFilter(name: "CISepiaTone")
      sepiaFilter.setValue(image, forKey: kCIInputImageKey)
      sepiaFilter.setValue(2.00, forKey: kCIInputIntensityKey)
      
      //cpu context, not as fast as GPU context
      let context = CIContext(options: nil)
      
      //gpu context
      let options = [kCIContextWorkingColorSpace : NSNull()]
      let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
      let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
      
      let outputImage = sepiaFilter.outputImage
      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
    }
    
    let noir = UIAlertAction(title: "Noir", style: .Default) { (alert) -> Void in
      
      let image = CIImage(image: self.imageView.image!)
      let noirFilter = CIFilter(name: "CIPhotoEffectNoir")
      noirFilter.setValue(image, forKey: kCIInputImageKey)
      
      //cpu context, not as fast as GPU context
      //let context = CIContext(options: nil)
      
      //gpu context
      let options = [kCIContextWorkingColorSpace : NSNull()]
      let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
      let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
      
      let outputImage = noirFilter.outputImage
      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
    }
    
    //not sure how to get this working... or where to pass in additional parameters... or the whole kCIInputImageKey thing...
    let bluePeriod = UIAlertAction(title: "Blue Period", style: UIAlertActionStyle.Default) { (alert) -> Void in
      
      let image = CIImage(image: self.imageView.image!)
      let outputImage = CIFilter(name: "CIColorMatrix", withInputParameters: [
        kCIInputImageKey : image,
        "inputRVector" : CIVector(x: 1, y: 0, z: 0, w: 0),
        "inputGVector" : CIVector(x: 0, y: 1, z: 0, w: 0),
        "inputBVector" : CIVector(x: 0, y: 0, z: 1.5, w: 0),
        "inputAVector" : CIVector(x: 0, y: 0, z: 0, w: 1),
        "inputBiasVector" : CIVector(x: 0, y: 0, z: 0, w: 0),
        ]).outputImage
      //colorMatrixFilter.setValue([0 1 1 1], forKey: kCIInputBVectorKey)
      
      //cpu context, not as fast as GPU context
      let context = CIContext(options: nil)
      
      //gpu context
      let options = [kCIContextWorkingColorSpace : NSNull()]
      let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
      let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
      

      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
    }
    
    alert.addAction(cancelAction)
    alert.addAction(chooseOrTakePhotoAction)
    alert.addAction(sepia)
    alert.addAction(noir)
    alert.addAction(bluePeriod)

    self.picker.delegate = self
    self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    
    //how could i set this uiimage size programatically?
//    var screenWidth = UIScreen.mainScreen().bounds.width
//    
//    var screenHeight = UIScreen.mainScreen().bounds.height
//    
//    var superViewHeight = self.view.frame.height
//    println(superViewHeight)
//    
//    var superViewWidth = self.view.frame.width
//    println(superViewWidth)
//    
//    imageView.frame.size.width = superViewWidth
//    imageView.frame.size.height = superViewHeight
    
    
    let testObject = PFObject(className: "TestObject")
    testObject["foo"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      println("Object has been saved.")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    self.imageView.image = image
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.picker.dismissViewControllerAnimated(true, completion: nil)
    println("Picker Cancelled")
  }
  
  
}


