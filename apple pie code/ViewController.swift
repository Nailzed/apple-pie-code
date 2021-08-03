//
//  ViewController.swift
//  apple pie code
//
//  Created by Сергей Земсков on 09.07.2021.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    let buttonStackView = UIStackView()
    let correctWordLabel = UILabel()
    var letterButtons = [UIButton]()
    let scoreLabel = UILabel()
    let stackView = UIStackView()
    let topStackView = UIStackView()
    let treeImageView = UIImageView()
    
    //MARK: Methods
    @objc func  buttonPressed(_ sender: UIButton) {
        print(#line, #function, sender.title(for: .normal) ?? "nil")
    }
    
    func initLetterButtons (fontSize: CGFloat = 17 ) {
        //init letter buttons
        let buttonTitles = "ЙЦУКЕНГШЩЗХЪЁ_ФЫВАПРОЛДЖЭ___ЯЧСМИТЬБЮ__"
        for buttonTitle in buttonTitles {
            let title: String = buttonTitle == "_" ? "" : String(buttonTitle)
            let button = UIButton()
            if buttonTitle != "_" {
            button.addTarget(self, action: #selector (buttonPressed(_ :)), for: .touchUpInside)
            }
            button.setTitle(title, for: [])
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.systemTeal, for: .highlighted)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            letterButtons.append(button)
        }
        
        let buttonRows = [UIStackView(), UIStackView(), UIStackView()]
        let rowCount = letterButtons.count / 3
        
        
        for row in 0 ..< buttonRows.count{
            for index in 0 ..< rowCount{
                buttonRows[row].addArrangedSubview(letterButtons[row * rowCount + index])
            }
            buttonRows[row].distribution = .fillEqually
            buttonStackView.addArrangedSubview(buttonRows[row])
        }
    }
    
    
    func updateUI(to size: CGSize){
        topStackView.axis = size.height < size.width ? .horizontal : .vertical
        topStackView.frame = CGRect(x: 8, y: 8, width: size.width - 16, height: size.height - 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = view.bounds.size
        let factor = min(size.height, size.width)
        
        //Setup button stack view
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        
        //Setup correct word label
        correctWordLabel.font = UIFont.systemFont(ofSize: factor / 10)
        correctWordLabel.text = "Word"
        correctWordLabel.textAlignment = .center
        
        //Setup letter buttons
        initLetterButtons()
        
        //Setup score label
        scoreLabel.font = UIFont.systemFont(ofSize: factor / 16)
        scoreLabel.text = "Score"
        scoreLabel.textAlignment = .center
        
        //Setup stack view
        stackView.addArrangedSubview(buttonStackView)
        stackView.addArrangedSubview(correctWordLabel)
        stackView.addArrangedSubview(scoreLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        //Setup top Stack view
        topStackView.distribution = .fillEqually
        topStackView.addArrangedSubview(treeImageView)
        topStackView.addArrangedSubview(stackView)
        topStackView.spacing = 16
        
        
        //setup tree image view
        treeImageView.contentMode = .scaleAspectFit
        treeImageView.image = UIImage(named: "Tree3.pdf")
        
        //Setup view
        view.backgroundColor = .white
        view.addSubview(topStackView)
        
        updateUI(to: view.bounds.size)

    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }

}

