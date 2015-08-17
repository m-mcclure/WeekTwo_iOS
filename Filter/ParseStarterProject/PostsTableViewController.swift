//
//  PostsTableViewController.swift
//  Filter
//
//  Created by Matthew McClure on 8/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class PostsTableViewController: UITableViewController {
  
  //var posts = [Post]()
  var imageArray = [UIImage]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    println("this is post count: \(imageArray.count)")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    let query = PFQuery(className: "Post")
    
    query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
      if let error = error {
        println(error.localizedDescription)
      } else if let posts = results as? [PFObject] {
        
        for post in posts {
          if let imageFile = post["image"] as? PFFile {
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
              if let error = error {
                println(error.localizedDescription)
              } else if let data = data,
                image = UIImage(data: data){
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    //let post = Post(image: image)
                    //                      posts.append(post)
                    let post = image
                    self.imageArray.append(post)
                    println(self.imageArray.count)
                    self.tableView.reloadData()
                  })
              }
            })
          }
        }
      }
      
      println("end of viewdidload imagearray count: \(self.imageArray.count)")
      self.viewWillAppear()
    }
    
  }
  func viewWillAppear() {
    tableView.reloadData()
  }
}

//MARK: UITableViewDataSource
extension PostsTableViewController : UITableViewDataSource {
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //just returning a few blank Xibs until I can get user timeline tweets to load
    return imageArray.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as! AlbumCell
    cell.albumPhoto.image = imageArray[indexPath.row]
//    let cell = UITableViewCell()
//    cell.textLabel?.text = "hmm"
//    cell.imageView?.image = imageArray[indexPath.row]
    //cell.imageView?.image = posts[indexPath.row]
    //cell.backgroundColor = UIColor.blackColor()
    return cell
}
}