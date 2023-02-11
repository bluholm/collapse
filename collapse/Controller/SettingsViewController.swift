//
//  SettingsViewController.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-11.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet var modeUITextView: UITextView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // swiftlint: disable line_length
        modeUITextView.text = "Lors de l'utilisation de l'application pour savoir si vous êtes prêt à faire face à un effondrement, vous rencontrerez des sujets divisés en trois modes différents : essentiel, intermédiaire et avancé. Le mode essentiel comprend les éléments les plus importants pour une préparation de base, qui sont faciles à mettre en œuvre et peu coûteux. Le mode intermédiaire comprend des éléments supplémentaires qui peuvent vous aider à vous préparer davantage à un effondrement. Le mode avancé comprend des éléments qui nécessitent plus de temps, d'argent ou de compétences pour être mis en œuvre. \n \n Par défaut, le mode avancé est sélectionné pour chaque sujet."
    }
    
}
