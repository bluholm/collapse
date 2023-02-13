//
//  PremiumViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-13.
//

import Foundation
import UIKit

final class PremiumViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet var imageTop: UIImageView!
    @IBOutlet var viewBackground: UIView!
    // weekly
    @IBOutlet var weeklyView: UIView!
    @IBOutlet var weeklyTopColoredView: UIView!
    @IBOutlet var weeklyBottomView: UIView!
    // monthly
    @IBOutlet var monthlyView: UIView!
    @IBOutlet var monthlyBottomView: UIView!
    @IBOutlet var monthlyTopColoredView: UIView!
    // lifeTime
    @IBOutlet var lifeTimeView: UIView!
    @IBOutlet var lifeTimeBottomView: UIView!
    @IBOutlet var lifeTimeTopColoredView: UIView!
    
    @IBOutlet var ifdebugLabel: UILabel!
    @IBOutlet var fakePremiumDebugSegment: UISegmentedControl!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        #if DEBUG
        ifdebugLabel.isHidden = false
        fakePremiumDebugSegment.isHidden = false
        fakePremiumDebugSegment.selectedSegmentIndex = 1
        if SettingsRepository.userIsPremium {
            fakePremiumDebugSegment.selectedSegmentIndex = 0
        }
        #else
        ifdebugLabel.isHidden = true
        fakePremiumDebugSegment.isHidden = true
        #endif
        
    }
    
    // MARK: - Actions
    
    #if DEBUG
    @IBAction func didChanagePremium(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SettingsRepository.userIsPremium = true
        } else {
            SettingsRepository.userIsPremium = false
        }
        NotificationCenter.default.post(name: NSNotification.Name("dismissModal"), object: nil)
    }
    #endif
    
    @IBAction func didViewWeeklyTapped(_ sender: UIGestureRecognizer) {
        initializePricingViews()
        sender.view?.alpha = 1.0
        UIView.animate(withDuration: 0.5) {
            sender.view?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }
    }
    
    // MARK: - SetupView
    private func setupView() {
        viewBackground.layer.cornerRadius = 20
        
        weeklyView.tag = 1
        monthlyView.tag = 2
        lifeTimeView.tag = 3
        
        weeklyView.alpha = 0.5
        monthlyView.alpha = 1
        lifeTimeView.alpha = 0.5
        
        self.monthlyView.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
        
        weeklyView.layer.cornerRadius = 8
        weeklyBottomView.layer.cornerRadius = 8
        weeklyTopColoredView.layer.cornerRadius = 8
        
        monthlyView.layer.cornerRadius = 8
        monthlyBottomView.layer.cornerRadius = 8
        monthlyTopColoredView.layer.cornerRadius = 8
        
        lifeTimeView.layer.cornerRadius = 8
        lifeTimeBottomView.layer.cornerRadius = 8
        lifeTimeTopColoredView.layer.cornerRadius = 8
        
    }
    
    private func initializePricingViews() {
        weeklyView.alpha = 0.5
        monthlyView.alpha = 0.5
        lifeTimeView.alpha = 0.5
        UIView.animate(withDuration: 0.5) {
            self.weeklyView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.monthlyView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.lifeTimeView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
    }
}
