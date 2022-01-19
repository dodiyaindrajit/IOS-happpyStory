//
//  ContactViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 23/12/21.
//

import UIKit
import AVFoundation
import Fusuma

class CameraViewController: UIViewController, FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        print("Image selected")
    }

    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        print("Image selected")
    }

    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Image selected")
    }

    func fusumaCameraRollUnauthorized() {
        print("Image selected")
    }

    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
        print("Image selected")
    }

    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode, metaData: [ImageMetadata]) {
        print("Image selected")
    }

    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        print("Image selected")
    }

    func fusumaClosed() {
        print("Image selected")
    }

    func fusumaWillClosed() {
        print("Image selected")
    }

    func fusumaLimitReached() {
        print("Image selected")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.availableModes = [FusumaMode.library, FusumaMode.camera, FusumaMode.video] // Add .video capturing mode to the default .library and .camera modes
        fusuma.cropHeightRatio = 0.6 // Height-to-width ratio. The default value is 1, which means a squared-size photo.
        fusuma.allowMultipleSelection = true // You can select multiple photos from the camera roll. The default value is false.
        self.present(fusuma, animated: true, completion: nil)
    }

    private func didTapTakePicture(){
        
    }


}
