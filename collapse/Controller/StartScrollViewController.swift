//
//  StartScrollViewController.swift
//  sincerity
//
//  Created by Marc-Antoine BAR on 2022-12-26.
//

import UIKit
import LoremSwiftum

/// This class is a view controller that displays a scrollable presentation with multiple sections.
class PresentationScrollViewController: UIViewController {
    
    // MARK: - Properties
    // @IBoutlets
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    // constants & properties
    private let imageNames = ["presentation2", "presentation3", "presentation1"]
    private let titles = ["START_TITLE_1".localized(), "START_TITLE_2".localized(), "START_TITLE_3".localized()]
    private let messages = ["START_DESCRIPTION_1".localized(),
                            "START_DESCRIPTION_2".localized(),
                            "START_DESCRIPTION_3".localized()]
    private let width = UIScreen.main.bounds.width
    private let heigt = UIScreen.main.bounds.height
    private let imagePageControl = "tree.fill"
    
    @available(iOS 14.0, *)
    open var preferredIndicatorImage: UIImage?
    
    // MARK: - Lifecycle Controller

    override func loadView() {
        super.loadView()
        if SettingsRepository.didReadPresentation {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "dashboard") else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titles[0]
        messageLabel.text = messages[0]
        doneButton.isHidden = true
        pageControl.isHidden = false
        self.setupPageControl()
        self.createScrollView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction func didDoneTapped(_ sender: Any) {
        SettingsRepository.didReadPresentation = true
    }
        
    // MARK: - Privates Methods
    
    private func setupPageControl() {
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.preferredIndicatorImage = UIImage.init(systemName: imagePageControl)
    }
    
    private func createScrollView() {
        self.setupScrollView()
        var startX: CGFloat = 0
        for value in 0..<imageNames.count {
            let frame = CGRect(x: startX, y: 0, width: width, height: heigt)
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: imageNames[value])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            startX += width
        }
    }
    
    private func setupScrollView() {
        let numberfPages: CGFloat = CGFloat(integerLiteral: imageNames.count)
        scrollView.contentSize = CGSize(width: width * numberfPages, height: heigt)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
    }
}

// MARK: - Extensions UIScrollViewDelegate

extension PresentationScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y>0 || scrollView.contentOffset.y<0 {
                scrollView.contentOffset.y = 0
            }
        let page  = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = page
        titleLabel.text = titles[page]
        messageLabel.text = messages[page]
        if pageControl.currentPage == imageNames.count-1 {
            doneButton.isHidden = false
            pageControl.isHidden = true
        } else {
            doneButton.isHidden = true
            pageControl.isHidden = false
        }
    }
}
