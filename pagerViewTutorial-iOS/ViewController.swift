//
//  ViewController.swift
//  pagerViewTutorial-iOS
//
//  Created by kimhyungyu on 2021/01/20.
//

import UIKit
import FSPagerView

class ViewController: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {
   
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
            }
    }
    
    @IBOutlet weak var myPagerControl: FSPageControl!
    
    fileprivate let imageNames = ["1.png","2.png","3.png","4.png"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mypagerView 의 데이터소스와 델리게이트를 설정(FSPagerViewDataSource,FSPagerViewDelegate)
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
    }
    //MARK: - FSPagerView datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
//            cell.textLabel?.text =
            return cell
    }


}

