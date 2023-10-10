//
//  OnboardingViewController.swift
//  NRCOnboarding
//
//  Created by 윤태웅 on 10/9/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // messages 갯수 가져오기
    let messages: [OnboardingMessage] = OnboardingMessage.messages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = .zero
        }
        
        // page control의 점을 총 몇개 보여줄 것인지
        pageControl.numberOfPages = messages.count
        
        // page control의 어떤 점이 밝게 빛날지 0,1,2... 아래에서 사용.
        // pageControl.currentPage
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        // cell에게 구성시켜 달라고 전달해줘야 한다.
        let message = messages[indexPath.item]
        cell.configure(message)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.bounds.width
//        let height = collectionView.bounds.height
//        return CGSize(width: width, height: height)
        // 이 코드 한줄과 같다.
        return collectionView.bounds.size
    }
    
    // cell 간의 spacing설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

// page control 설정
extension OnboardingViewController: UIScrollViewDelegate {
    // scrollViewDidScroll은 움직임을 계속 감지.
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    }
    
    // scrollViewDidEndDecelerating은 움직임을 멈출 시 감지.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 계산식. Int로 하여 몇번째 페이지에 멈출 시, 해당 Int가 뜬다.
        // 첫페이지->두번째페이지 이동 시 scrollView.contentOffset.x 는 (0,0)에서 (self.collectionView.bounds.width,0)로 계속 이동.
        let index = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)
        pageControl.currentPage = index
    }
}
