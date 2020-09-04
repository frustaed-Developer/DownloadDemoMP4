//
//  DownloadViewController.swift
//  DownloadDemoMP4
//
//  Created by Ankit Jadon on 04/09/20.
//  Copyright © 2020 Ankit Jadon. All rights reserved.
//

import UIKit
import AVKit

class DownloadViewController: UIViewController {

    @IBOutlet weak var dProgress: UIProgressView!
    var downloadTask: URLSessionDownloadTask!
    var destinationURL: URL?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = DownloadManager.shared.activate()
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                self.dProgress.progress = progress
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }
    
    @IBAction func StartDownload(_ sender: Any) {
        
        let url = URL(string:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
        downloadTask = DownloadManager.shared.activate().downloadTask(with: url)
        downloadTask.resume()
    }
    
    @IBAction func PauseDownload(_ sender: Any) {
       downloadTask.suspend()
    }
    
    @IBAction func ResumeDownload(_ sender: Any) {
         downloadTask.resume()
    }
    
    
    @IBAction func PlayDownloadedVideo(_ sender: Any) {
        
        destinationURL = UserDefaults.standard.url(forKey: "UrlLocation")
        
        if destinationURL != nil{
        playVideo(filepath: destinationURL!)
        }
    }
    
    func playVideo(filepath : URL)
    {
        
        let movieUrl:URL? = filepath
        
        if let final_url = movieUrl{
            
        let player = AVPlayer(url: final_url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
                    
        }
        
    }
    
}
