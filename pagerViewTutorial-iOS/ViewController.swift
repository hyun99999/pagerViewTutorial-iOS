//
//  ViewController.swift
//  pagerViewTutorial-iOS
//
//  Created by kimhyungyu on 2021/01/20.
//

import UIKit
import FSPagerView

class ViewController: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {
   
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var myPagerView: FSPagerView! {
        didSet {
            //페이저뷰에 cell 등록
                self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize
            //무한스크롤 설정
            self.myPagerView.isInfinite = true
            //자동스크롤 설정
            self.myPagerView.automaticSlidingInterval = 3.0
            self.myPagerView.transformer = FSPagerViewTransformer(type: .overlap)
            }
    }
    
    @IBOutlet weak var myPagerControl: FSPageControl! {
        didSet {
            self.myPagerControl.numberOfPages = self.imageNames.count
            self.myPagerControl.contentHorizontalAlignment = .center
            self.myPagerControl.itemSpacing = 16
            self.myPagerControl.interitemSpacing = 16
        }
    }
    
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mypagerView 의 데이터소스와 델리게이트를 설정(FSPagerViewDataSource,FSPagerViewDelegate)
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height/2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height/2
    }
    //MARK: - IBAction
    @IBAction func onLeftBtnClicked(_ sender: UIButton) {
        print("ViewController - onLeftBtnClicked() called")
        self.myPagerControl.currentPage = self.myPagerControl.currentPage-1
        //해당 인덱스로 화면이 변경
        self.myPagerView.scrollToItem(at: self.myPagerControl.currentPage, animated: true)
        //1에서 왼쪽버튼 한번더 누르면 4로 돌아감.
    }
    @IBAction func onRightBtnClicked(_ sender: UIButton) {
        print("ViewController - onRightBtnClicked() called")
        
        //out of range error 해결
        if self.myPagerControl.currentPage == self.imageNames.count-1 {
            self.myPagerControl.currentPage = 0
        } else {
            self.myPagerControl.currentPage = self.myPagerControl.currentPage+1
        }
        //해당 인덱스로 화면이 변경
        self.myPagerView.scrollToItem(at: self.myPagerControl.currentPage, animated: true)
    }
    //MARK: - FSPagerView datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    //각 셀에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
//            cell.textLabel?.text =
        //셀에 들어가는 컨텐트는 꽉차는 것이 아닌 fit 이다.
        cell.imageView?.contentMode = .scaleAspectFit
            return cell
    }
    //MARK: - FSPagerView delegate
    //수동으로 스와이프할때 pagercontrol 의 인덱스 변경
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int){
        self.myPagerControl.currentPage = targetIndex
    }
    //자동으로 스와이프할때 pagercontrol 의 인데스 변경
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPagerControl.currentPage = pagerView.currentIndex
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

