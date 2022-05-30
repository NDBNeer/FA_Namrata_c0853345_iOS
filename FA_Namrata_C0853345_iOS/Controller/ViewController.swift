//
//  ViewController.swift
//  FA_Namrata_C0853345_iOS
//
//  Created by Namrata Barot on 2022-05-30.
//

import UIKit

class ViewController: UIViewController
{
    let coreDataController: CoreDataController = CoreDataController()
    let currentBoardState: BoardModel = BoardModel()
    let currentPlayerScore: PlayerModel = PlayerModel(player1Score: 0, player2Score: 0)
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = BoardModel( ) 
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var lastBox: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        initBoard()
        //initBoardAndPlayerScores()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
                
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        lblPlayer1Score.text = "0"
        lblPlayer2Score.text = "0"
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
            resetGame()
        }
            
        if (sender.direction == .right) {
            resetGame()
            
        }
    }
    
    func initBoard()
    {
        
        board.add(square: a1)
        board.add(square: a2)
        board.add(square: a3)
        board.add(square: b1)
        board.add(square: b2)
        board.add(square: b3)
        board.add(square: c1)
        board.add(square: c2)
        board.add(square: c3)
    }
    
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            lastBox.setTitle(nil, for: .normal)
            if(currentTurn == Turn.Cross){
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }else if(currentTurn == Turn.Nought){
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
        }
    }


    func updateBoard(checkedBoxAddress: String, checkedBoxPlayer: ViewController.Turn){
        var squareValue = 0
        if(checkedBoxPlayer == Turn.Nought){
            squareValue = 1
        }
        if(checkedBoxPlayer == Turn.Cross){
            squareValue = 2
        }
    }

    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkForVictory(CROSS)
        {
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
        }
        
        if checkForVictory(NOUGHT)
        {
            noughtsScore += 1
            resultAlert(title: "Noughts Win!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s :String) -> Bool
    {
        // Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        lblPlayer1Score.text = String(noughtsScore)
        lblPlayer2Score.text = String(crossesScore)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetGame(){
        resetBoard()
        noughtsScore = 0
        crossesScore = 0
        lblPlayer1Score.text = String(noughtsScore)
        lblPlayer2Score.text = String(crossesScore)

    }
    
    func resetBoard()
    {
        for button in board.board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool
    {
        for button in board.board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    
   
    func addToBoard(_ sender: UIButton)
    {
        lastBox = sender
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.Nought)
            {
//                updateBoard(checkedBoxAddress: recognizeSender(sender: sender), checkedBoxPlayer: Turn.Nought)
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
//                updateBoard(checkedBoxAddress: recognizeSender(sender: sender), checkedBoxPlayer: Turn.Cross)
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
}



