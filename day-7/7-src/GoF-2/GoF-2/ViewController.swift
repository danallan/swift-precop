//
//  ViewController.swift
//  GoF-2
//
//  Created by Dan Armendariz on 7/5/16.
//  Copyright © 2016 Dan Armendariz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var countdown = 3
    var animating = false

    // create an array of tiles
    var tiles: [UIButton] = []
    
    func startTimer(interval: Int)
    {
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(interval), target: self, selector: #selector(ViewController.timerFired), userInfo: nil, repeats: false)
    }
    
    func timerFired()
    {
        countdown -= 1
        
        switch(countdown)
        {
        case -1:
            countdownLabel.hidden = true
        case 0:
            countdownLabel.text = "GO!!!"
            startTimer(2)
        default:
            countdownLabel.text = String(countdown)
            startTimer(1)
        }
    }
    
    func tileTapped(sender: UIButton)
    {
        if animating
        {
            print("tileTapped: already animating!! abort mission!!!")
            return
        }
        
        print("tileTapped: \(sender.tag)")
        
        // swap tiles
        animating = true
        
        // find the two tiles I want to swap
        let tile0 = boardView.viewWithTag(0)!
        let tile1 = boardView.viewWithTag(1)!
        
        // obtain their frames
        let frame0 = tile0.frame
        let frame1 = tile1.frame
        
        UIView.animateWithDuration(4, animations:
            { () -> Void in
                // swap the frames to swap their positions on screen
                tile0.frame = frame1
                tile1.frame = frame0
            }, completion: { (_: (Bool)) -> Void in
                print("tileTapped: animation complete!")
                self.animating = false
        })
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        let tileSize = round((boardView.bounds.size.width - CGFloat(16.0)) / 4.0)
        
        for i in 0 ... 1
        {
            let rect = CGRect(x: tileSize*CGFloat(i), y: 0.0, width: tileSize, height: tileSize)
            
            let newTile = UIButton(frame: rect)
            
            // set the caption of the button
            newTile.setTitle(String(i+1), forState: UIControlState.Normal)
            
            // let the button know which tile it is
            newTile.tag = i
            
            // change the background color of the tile
            newTile.backgroundColor = UIColor.lightGrayColor()
            
            // set a border
            newTile.layer.borderColor = UIColor.blackColor().CGColor
            newTile.layer.borderWidth = 2
            
            // add a shadow!!!!!
            newTile.layer.shadowRadius = 2
            newTile.layer.shadowColor = UIColor.blackColor().CGColor
            newTile.layer.shadowOffset = CGSizeMake(2.0, 2.0)
            newTile.layer.shadowOpacity = 0.5
            
            newTile.addTarget(self, action: #selector(ViewController.tileTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            // remember this tile for later use
            tiles.append(newTile)
            
            // add the tile to the board
            boardView.addSubview(newTile)
        }
        
        countdownLabel.text = String(countdown)
        startTimer(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

