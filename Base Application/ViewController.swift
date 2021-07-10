//
//  ViewController.swift
//  Base Application
//
//  Created by Ahsanul Kabir on 17/2/21.
//  Copyright © 2021 sakibwrold. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIGestureRecognizerDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagecontrolIndicator: UIPageControl!
    

    var logoList = ["logo1","logo2","logo3"]
    var timerforImage = Timer()
    var counter = 0
    var numberOfImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: String(describing: LogoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: LogoCollectionViewCell.self))
        gestureTapSetup()
        self.updatePageView()
    }
    
    
    func gestureTapSetup(){
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected))
        swipeGestureUp.numberOfTouchesRequired = 1
        swipeGestureUp.direction = .up
        swipeGestureUp.delegate = self
        collectionView.addGestureRecognizer(swipeGestureUp)

        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected))
        swipeGestureDown.numberOfTouchesRequired = 1
        swipeGestureDown.direction = .down
        swipeGestureDown.delegate = self
        collectionView.addGestureRecognizer(swipeGestureDown)

        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected))
        swipeGestureLeft.numberOfTouchesRequired = 1
        swipeGestureLeft.direction = .left
        swipeGestureLeft.delegate = self
        collectionView.addGestureRecognizer(swipeGestureLeft)

        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected))
        swipeGestureRight.numberOfTouchesRequired = 1
        swipeGestureRight.direction = .right
        swipeGestureRight.delegate = self
        collectionView.addGestureRecognizer(swipeGestureRight)
    }
    
    @objc func swipeDetected(sender: UISwipeGestureRecognizer) {
        timerforImage.invalidate()
        if sender.direction == .left && sender.state == .ended{
            if counter < numberOfImage {
                let index = IndexPath.init(item: counter, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pagecontrolIndicator.currentPage = counter
                counter += 1
            }
        }else if sender.direction == .right && sender.state == .ended{
            if counter > 0 {
                counter -= 1
                let index = IndexPath.init(item: counter, section: 0)
                self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pagecontrolIndicator.currentPage = counter
            }
        }
        startImageTimer()
    }

    func updatePageView(){
        numberOfImage = logoList.count
        pagecontrolIndicator.numberOfPages = numberOfImage
        pagecontrolIndicator.currentPage = 0
        if numberOfImage == 0{
            pagecontrolIndicator.isHidden = true
        }else{
            pagecontrolIndicator.isHidden = false
            startImageTimer()
        }
        collectionView.reloadData()
    }

    func startImageTimer(){
        DispatchQueue.main.async {
            self.timerforImage = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    
    //marks:// change slider
    @objc func changeImage() {
        if counter < numberOfImage {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pagecontrolIndicator.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pagecontrolIndicator.currentPage = counter
            counter = 1
        }
    }
}


// MARK: ---------- EXTENSION: WGHomeRootViewController(UICollectionViewDataSource, UICollectionViewDelegate)
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: ---------- UICollectionViewDataSource ----------
    //  ----------------------------------------------------------------------
    // アイテム数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(logoList.count)
        return logoList.count
    }

    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let rowNo = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LogoCollectionViewCell.self), for: indexPath) as! LogoCollectionViewCell
        print("in ------------")

        if logoList.count > 0{
            cell.setImage(UIImage(named: logoList[rowNo]) ?? #imageLiteral(resourceName: "logo1"))
            return cell
        }
        print("out---------------")

       return cell
    }

    // MARK: ---------- UICollectionViewDelegateFlowLayout ----------
    //  ----------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 50)
    }

    //  ----------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    //  ----------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 列間
        return 0.0
    }

    // MARK: ---------- UICollectionViewDelegate ----------
    //  ----------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.alpha = 0.5
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.alpha = 1.0
        }
    }
    // セルを選択
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if numberOfImage > 0{
//            if let logoType = logoList?.arrLogoList?[indexPath.row].intLogoType {
//                if (logoType.rawValue == liveUpLogoType) {
//                    self.mainTabViewController.showLiveUpChatroom()
//                }else if(logoType.rawValue == normalLogoType){
//                    self.mainTabViewController.showLessonTab()
//                }
//            }
//        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
