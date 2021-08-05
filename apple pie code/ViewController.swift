//
//  ViewController.swift
//  apple pie code
//
//  Created by Сергей Земсков on 09.07.2021.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - UI Properties
    let buttonStackView = UIStackView()
    let correctWordLabel = UILabel()
    var letterButtons = [UIButton]()
    let scoreLabel = UILabel()
    let stackView = UIStackView()
    let topStackView = UIStackView()
    let treeImageView = UIImageView()
    
    //MARK: - Properties
    var currentGame: Game!
        let incorrectMovesAllowed = 7
        var listOfWords = [
            "Австралия",
            "Австрия",
            "Азербайджан",
            "Албания",
            "Англия",
            "Андорра",
            "Аргентина",
            "Армения",
            "Афганистан",
            "Белоруссия",
            "Бельгия",
            "Болгария",
            "Боливия",
            "Босния и Герцеговина",
            "Бразилия",
            "Бруней",
            "Буркина - Фасо",
            "Великобритания",
            "Венгрия",
            "Венесуэла",
            "Вьетнам",
            "Гаити",
            "Гана",
            "Гватемала",
            "Гвинея",
            "Германия",
            "Гибралтар",
            "Гондурас",
            "Гонконг",
            "Греция",
            "Грузия",
            "Дания",
            "Египет",
            "Зимбабве",
            "Израиль",
            "Индия",
            "Индонезия",
            "Иордания",
            "Ирак",
            "Иран",
            "Ирландия",
            "Исландия",
            "Испания",
            "Италия",
            "Йемен",
            "Кабо - Верде",
            "Казахстан",
            "Камбоджа",
            "Камерун",
            "Канада",
            "Катар",
            "Кения",
            "Киргизия",
            "Китай",
            "Колумбия",
            "Корея",
            "Коста - Рика",
            "Куба",
            "Кувейт",
            "Лаос",
            "Латвия",
            "Либерия",
            "Ливан",
            "Ливия",
            "Литва",
            "Лихтенштейн",
            "Люксембург",
            "Маврикий",
            "Мавритания",
            "Мадагаскар",
            "Малайзия",
            "Мали",
            "Мальдивы",
            "Мальта",
            "Марокко",
            "Мексика",
            "Мозамбик",
            "Молдавия",
            "Монако",
            "Монголия",
            "Намибия",
            "Непал",
            "Нигерия",
            "Нидерланды",
            "Никарагуа",
            "Новая Зеландия",
            "Норвегия",
            "ОАЭ",
            "Оман",
            "Пакистан",
            "Панама",
            "Папуа — Новая Гвинея",
            "Парагвай",
            "Перу",
            "Польша",
            "Португалия",
            "Пуэрто - Рико",
            "Кипр",
            "Россия",
            "Руанда",
            "Румыния",
            "Сальвадор",
            "Самоа",
            "Саудовская Аравия",
            "Северная Ирландия",
            "Северная Македония",
        ].shuffled()
        var totalWins = 0{
            didSet {
                newRound()
            }
        }
        var totalLosses = 0{
            didSet {
                newRound()
            }
        }
        
        //MARK: - Methods
        func enableButtons(_ enable: Bool = true) {
            for button in letterButtons{
                button.isEnabled = enable
            }
        }
        
        
        func newRound () {
            enableButtons(false)
            guard !listOfWords.isEmpty else {
                updateUI()
                return
            }
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
            updateUI()
            enableButtons()
        }
        
        func updateState(){
            if currentGame.incorrectMovesRemaining < 1{
                totalLosses += 1
            }else if currentGame.guessedWord == currentGame.word{
                totalWins += 1
            }else{
                updateUI()
            }
        }
        
        
        func updateCorrectWordLabel(){
            var displayWord = [String]()
            for letter in currentGame.guessedWord{
                displayWord.append(String(letter))
            }
            correctWordLabel.text = displayWord.joined(separator: " ")
        }
        
        func updateUI(){
            let movesRemaining = currentGame.incorrectMovesRemaining
            let imageNumber = movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7
            //let imageNumber = (movesRemaining + 64) % 8 другой вариант
            let image = "Tree\(imageNumber)"
            treeImageView.image = UIImage(named: image)
            updateCorrectWordLabel()
            scoreLabel.text = "Выигрыши:\(totalWins), Проигрыши:\(totalLosses)"
        }
    
    //MARK: - UI Methods
    @objc func  letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    
    func initLetterButtons (fontSize: CGFloat = 17 ) {
        //init letter buttons
        let buttonTitles = "ЙЦУКЕНГШЩЗХЪЁ_ФЫВАПРОЛДЖЭ___ЯЧСМИТЬБЮ__"
        for buttonTitle in buttonTitles {
            let title: String = buttonTitle == "_" ? "" : String(buttonTitle)
            let button = UIButton()
            if buttonTitle != "_" {
            button.addTarget(self, action: #selector (letterButtonPressed(_ :)), for: .touchUpInside)
            }
            button.setTitle(title, for: [])
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.systemTeal, for: .highlighted)
            button.setTitleColor(.systemGray, for: .disabled)
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
        correctWordLabel.adjustsFontSizeToFitWidth = true
        correctWordLabel.textColor = .black
        
        //Setup letter buttons
        initLetterButtons()
        
        //Setup score label
        scoreLabel.font = UIFont.systemFont(ofSize: factor / 16)
        scoreLabel.text = "Score"
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .blue
        
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
        
        newRound()

    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }

}

