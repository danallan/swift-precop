//
//  ViewController.swift
//  ios4
//
//  Created by Dan Armendariz on 11/20/14.
//  Copyright (c) 2014 Dan Armendariz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // properties to store parsed data from the server
    var album: String = ""
    var photos = NSArray()
    var imageNum = 0

    // a connection to our "Get Next Image" button
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    // a connection to the title label
    @IBOutlet weak var titleLabel: UINavigationItem!

    // a connection to our UIImageView
    @IBOutlet weak var gallery: UIImageView!

    // when "Get Next Image" is clicked, fetch the next image
    @IBAction func getNextImage(sender: AnyObject) {
        self.fetchNextImage()
    }

    // this function is run once the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        // set our button to "loading"
        self.nextButton.title = "Loading data.."
        self.nextButton.enabled = false

        // fetch data
        self.fetchJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // provide a hint on the UI that an error has occurred
    func failure()
    {
        self.nextButton.title = "Error :("
        self.nextButton.enabled = false
    }
    
    // Pull an image from the web and insert it into the UIImageView
    func fetchNextImage()
    {
        // tell user what's going on
        self.nextButton.title = "Loading, please wait.."
        self.nextButton.enabled = false

        // calculate Nth image given the image count and the count of photos in the array
        let n = self.imageNum % self.photos.count
        
        // fetch the name and url of the Nth image
        let imageName = self.photos[n]["name"] as! String
        let imageURL = self.photos[n]["url"] as! String

        // create an NSURL object
        let url = NSURL(string: imageURL)
        if url == nil
        {
            print("Unable to parse \(imageURL) into NSURL")
            failure()
            return
        }
        
        // fetch the image data from the URL
        let imageData = NSData(contentsOfURL: url!)
        if imageData == nil
        {
            print("Unable to load image from \(imageURL)")
            failure()
            return
        }
        
        // create a UIImage object from the image data
        let image = UIImage(data: imageData!)
        if image == nil
        {
            print("Unable to parse the image data to an UIImage")
        }
        
        // finally, set the image into the view!
        gallery.image = image
        
        // iterate counter
        self.imageNum += 1

        // update gallery title
        self.titleLabel.title = "\(self.album): \"\(imageName)\""
        
        // re-enable button
        self.nextButton.title = "Get Next Image"
        self.nextButton.enabled = true

    }
    
    func fetchJSON()
    {
        let url = NSURL(string: "https://swift-precop-danallan.c9users.io/ios4.js")
        if url == nil
        {
            print("Unable to parse string into NSURL")
            return
        }

        let session = NSURLSession.sharedSession()

        // one way to fetch data from the Internet is to use a Task
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if error != nil
            {
                // An error is present, print it and abort
                print("Web request error: \(error!.localizedDescription)")
                self.failure()
                return
            }

            do {
                let parsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                

                // success!
                print("Success!")
                
                // store album and array info
                self.album = parsed["album"] as! String
                self.photos = parsed["photos"]! as! NSArray
                
                // set gallery title
                self.titleLabel.title = "\(self.album)"
                
                self.fetchNextImage()

            } catch {
                // print errors to the console
                print("JSON parse error: \(error)")
                self.failure()
                return
            }

        })
        
        task.resume()
    }
    

}

