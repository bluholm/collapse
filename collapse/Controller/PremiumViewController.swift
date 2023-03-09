//
//  PremiumViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-13.
//

import Foundation
import UIKit

/// This class is a view controller that displays information about premium features and allows the user to subscribe.
final class PremiumViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstLineLabel: UILabel!
    @IBOutlet var secondLineLabel: UILabel!
    @IBOutlet var thirdLineLabel: UILabel!
    @IBOutlet var titleBoxOneLabel: UILabel!
    @IBOutlet var titleBoxTwoLabel: UILabel!
    @IBOutlet var titleBoxThreeLabel: UILabel!
    @IBOutlet var priceBocOneLabel: UILabel!
    @IBOutlet var priceBoxTwoLabel: UILabel!
    @IBOutlet var priceBoxThreeLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    @IBOutlet var restoreButton: UIButton!
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
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupTextView()
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
    
    // MARK: - Privates
    private func setupTextView() {
        titleLabel.text = "PREMIUM_TITLE".localized()
        firstLineLabel.text = "FIRST_LINE_TITLE".localized()
        secondLineLabel.text = "SECOND_LINE_TITLE".localized()
        thirdLineLabel.text = "THIRD_LINE_TITLE".localized()
        #if DEBUG
        priceBocOneLabel.text = "0,99$"
        priceBoxTwoLabel.text = "3,99$"
        priceBoxThreeLabel.text = "14,99$"
        #else
        priceBocOneLabel.text = ""
        priceBoxTwoLabel.text = ""
        priceBoxThreeLabel.text = ""
        #endif
        titleBoxOneLabel.text = "TITLE_BOX_ONE".localized().capitalized
        titleBoxTwoLabel.text = "TITLE_BOX_TWO".localized().capitalized
        titleBoxThreeLabel.text = "TITLE_BOX_THREE".localized().capitalized
        purchaseButton.setTitle("PURCHASE_BUTTON_TITLE".localized(), for: .normal)
        restoreButton.setTitle("RESTORE_BUTTON_TITLE".localized(), for: .normal)
        
    }
    
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
