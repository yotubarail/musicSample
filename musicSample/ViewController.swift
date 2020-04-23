//
//  ViewController.swift
//  musicSample
//
//  Created by 滝浪翔太 on 2020/04/23.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLAbel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!

    var player:  MPMusicPlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        player = MPMusicPlayerController.systemMusicPlayer
        player.repeatMode = .none
    }

    @IBAction func startBtn(_ sender: Any) {
        player.play()
//        player.pause()
    }
    @IBAction func backBtn(_ sender: Any) {
        player.skipToPreviousItem()
    }
    @IBAction func skipBtn(_ sender: Any) {
        player.skipToNextItem()
    }
    @IBAction func selectBtn(_ sender: Any) {
        let picker = MPMediaPickerController()
        picker.delegate = self
        picker.allowsPickingMultipleItems = false
        present(picker, animated: true, completion: nil)
    }
    
    // MediaPickerControllerで選択した曲が入ったとき
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        player.stop()
        player.setQueue(with: mediaItemCollection)
        
        dismiss(animated: true, completion: nil)
        player.play()
    }
    
    // MediaPickerControllerでの選択がキャンセルされたとき
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // 曲の情報を表示
    func updatesong(mediaItem: MPMediaItem) {
           songLabel.text = mediaItem.albumTitle
           artistLabel.text = mediaItem.albumArtist
           
           if let albumArt = mediaItem.artwork {
               let image = albumArt.image(at: artWork.bounds.size)
               artWork.image = image
           } else {
               //もしアートワークがなければ、何も表示しない
               artWork.image = nil
               artWork.backgroundColor = UIColor.gray
           }
        player.play()
       }
    
}

