//
//  FilterService.swift
//  Filter
//
//  Created by Matthew McClure on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FilterService {
  class func sepiaFromOriginalImage(original : UIImage,  context : CIContext) -> UIImage! {
    
    let image = CIImage(image: original)
    let filter = CIFilter(name: "CISepiaTone")
    filter.setValue(image, forKey: kCIInputImageKey)
    return filteredImageFromFilter(filter, context: context)
  }
  
  class func noirFromOriginalImage(original : UIImage, context : CIContext) -> UIImage! {
    let image = CIImage(image: original)
    let filter = CIFilter(name: "CIPhotoEffectNoir")
    filter.setValue(image, forKey: kCIInputImageKey)
    return filteredImageFromFilter(filter, context: context) 
  }
  
  class func chromeFromOriginalImage(original : UIImage, context : CIContext) -> UIImage! {
    let image = CIImage(image: original)
    let filter = CIFilter(name: "CIPhotoEffectChrome")
    filter.setValue(image, forKey: kCIInputImageKey)
    return filteredImageFromFilter(filter, context: context)
  }
  
  class func processFromOriginalImage(original : UIImage, context : CIContext) -> UIImage! {
    let image = CIImage(image: original)
    let filter = CIFilter(name: "CIPhotoEffectProcess")
    filter.setValue(image, forKey: kCIInputImageKey)
    return filteredImageFromFilter(filter, context: context)
  }
  
  class func fadeFromOriginalImage(original : UIImage, context : CIContext) -> UIImage! {
    let image = CIImage(image: original)
    let filter = CIFilter(name: "CIPhotoEffectFade")
    filter.setValue(image, forKey: kCIInputImageKey)
    return filteredImageFromFilter(filter, context: context)
  }
  
  class func maxComponentFromOriginalImage(original : UIImage, context : CIContext) -> UIImage! {
    let image = CIImage(image: original)
    let filter = CIFilter(name: "CIMaximumComponent")
    filter.setValue(image, forKey: kCIInputImageKey)
    return filteredImageFromFilter(filter, context: context)
  }

  private class func filteredImageFromFilter(filter : CIFilter, context : CIContext) -> UIImage {
    let outputImage = filter.outputImage
    let extent = outputImage.extent()
    let cgImage = context.createCGImage(outputImage, fromRect: extent)
    return UIImage(CGImage: cgImage)!
  }
}