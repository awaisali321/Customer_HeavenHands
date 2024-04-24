//
//  Chats_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 17/01/2024.
//

import UIKit

struct Message {
    let text: String
    let isSentByCurrentUser: Bool
    let timestamp: Date
    
    init(text: String, isSentByCurrentUser: Bool, timestamp: String) {
        self.text = text
        self.isSentByCurrentUser = isSentByCurrentUser
        self.timestamp = Date()
    }
}

class Chats_VC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var ChatsTbl:UITableView!
    @IBOutlet weak var messageFLd:UITextField!
    

    var isDataEven = false
    
    let numberOfChatCells = 5
    let numberOfOtherCells = 3
    
    var EvenChatsArray = [String]()
    var OddChatsArray = [String]()
    
    var evenIndexPaths = [IndexPath]()
    var oddIndexPaths = [IndexPath]()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        messageFLd.delegate = self
        ChatsTbl.estimatedRowHeight = 280
        ChatsTbl.rowHeight = UITableView.automaticDimension

        messages = [
            Message(text: "Hello", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "Hi there!", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "How Are You", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "I am fine", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "what about you", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "am good", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "how are you feeling", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "better", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "welldone", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "thanks", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "Hello", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "Hi there!", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "Hello", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "Hi there!", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "Hello", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "Hi there!", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "Hello", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "Hi there!", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            Message(text: "Additionally, you should double-check the logic where you're appending new messages to the messages array. Make sure that you're correctly adding new messages to the array and updating the table view data source before attempting to scroll to the bottom Additionally, you should double-check the logic where you're appending new messages to the messages array. Make sure that you're", isSentByCurrentUser: true, timestamp: getCurrentTimestamp()),
            Message(text: "Additionally, you should double-check the logic where you're appending new messages to the messages array. Make sure that you're correctly adding new messages to the array and updating the table view data source before attempting to scroll to the bottom Additionally, you should double-check the logic where you're appending new messages to the messages array. Make sure that you're correctly adding new messages to the array and updating the table view data source before attempting to scroll to the bottom", isSentByCurrentUser: false, timestamp: getCurrentTimestamp()),
            
                
            ]
        
//        populateIndexPathArrays()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        ChatsTbl.delegate = self
        ChatsTbl.dataSource = self
        
    }


    @IBAction func btn_open_menu(_ Sender:Any){
        self.sideMenuController?.toggle()

    }
    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

    }

//    func populateIndexPathArrays() {
//        for i in 0..<max(EvenChatsArray.count, OddChatsArray.count) {
//            if i < EvenChatsArray.count {
//                let indexPath = IndexPath(row: i * 2, section: 0)
//                evenIndexPaths.append(indexPath)
//            }
//
//            if i < OddChatsArray.count {
//                let indexPath = IndexPath(row: i * 2 + 1, section: 0)
//                oddIndexPaths.append(indexPath)
//            }
//        }
//    }
//    func toggleData() {
//        isDataEven.toggle()
//        scrollToBottomAndReloadData() // Reload the table view when data changes
//    }
//    func scrollToBottomAndReloadData() {
//        // Scroll the table view to the bottom
//        let lastSection = ChatsTbl.numberOfSections  - 1
//        let lastRow = ChatsTbl.numberOfRows(inSection: lastSection)  - 1
//        let indexPath = IndexPath(row: lastRow, section: lastSection)
//        ChatsTbl.scrollToRow(at: indexPath, at: .bottom, animated: true)
//
//        // Reload data
//        ChatsTbl.reloadData()
//    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
            self.ChatsTbl.scrollToRow(at: indexPath, at: .bottom, animated: true)
            self.ChatsTbl.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
//        textField.resignFirstResponder()

        // Call the method to handle sending the message
        sendMessage()

        // Return false to prevent line break
        return false
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Check if the return key was pressed
        if text != "" {
            // Call the method to handle sending the message
            sendMessage()

            // Return false to prevent line break
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the text field is the one you want to limit (if you have multiple text fields)
        if textField == messageFLd {
            // Calculate the new length of the text after replacement
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // Limit the number of characters to 200
            return updatedText.count <= 200
        }
        // For other text fields, return true to allow input
        return true
    }

    func sendMessage() {
        // Check if the text field is empty
        guard let messageText = messageFLd.text, !messageText.isEmpty else {
            // Show an alert or handle the empty message case as needed
            let alert = UIAlertController(title: "Error", message: "Please enter a message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Get current date and time
        let currentTime = Date()

        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Set the format to display only hours, minutes, and seconds

        // Format the current time to display only the time component
        let formattedTime = dateFormatter.string(from: currentTime)

        // Create a new Message object with the text from your text field and the current time
        let newMessage = Message(text: messageText, isSentByCurrentUser: true, timestamp: formattedTime)

        // Add the new message to your messages array
        messages.append(newMessage)

        // Reload the table view to reflect the changes
        ChatsTbl.reloadData()

        // Clear the text field
        messageFLd.text = ""

        // Scroll to the bottom to show the new message
        scrollToBottom()
    }

    
    @IBAction func sendMessageButtonTapped(_ sender: UIButton) {
        // Check if the text field is empty
        guard let messageText = messageFLd.text, !messageText.isEmpty else {
            // Show an alert or handle the empty message case as needed
            let alert = UIAlertController(title: "Error", message: "Please enter a message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Get current date and time
        let currentTime = Date()

        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Set the format to display only hours, minutes, and seconds

        // Format the current time to display only the time component
        let formattedTime = dateFormatter.string(from: currentTime)

        // Create a new Message object with the text from your text field and the current time
        let newMessage = Message(text: messageText, isSentByCurrentUser: true, timestamp: formattedTime)

        // Add the new message to your messages array
        messages.append(newMessage)

        // Reload the table view to reflect the changes
        ChatsTbl.reloadData()

        // Clear the text field
        messageFLd.text = ""

        // Scroll to the bottom to show the new message
        scrollToBottom()
    }

    func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " HH:mm"
        return dateFormatter.string(from: Date())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Chats_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return messages.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let message = messages[indexPath.row]
         if message.isSentByCurrentUser {
             let cell = tableView.dequeueReusableCell(withIdentifier: "Senders_Chats_Cell", for: indexPath) as! Senders_Chats_Cell
             
             let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "HH:mm"
             
             cell.SendersLbl.text = message.text
             cell.SendersLbl.numberOfLines = 0
//             cell.timeLbl.text = getCurrentTimestamp()
             cell.timeLbl.text = dateFormatter.string(from: message.timestamp)
             cell.timeLbl.textColor = .pHexColor(hex: "#FFFFFF")
             return cell
         } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "Recivers_Chats_Cell", for: indexPath) as! Recivers_Chats_Cell
             let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "HH:mm"
             
             cell.ReciversLbl.text = message.text
             cell.ReciversLbl.numberOfLines = 0
//             cell.timeLbl.text = getCurrentTimestamp()
             cell.timeLbl.text = dateFormatter.string(from: message.timestamp)
             cell.timeLbl.textColor = .pHexColor(hex: "#000000")
             
             return cell
         }
     }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messages[indexPath.row]
        let text = message.text

        let font = UIFont.systemFont(ofSize: 1) // Set the font size according to your design
        let maxWidth = tableView.bounds.width - /* Adjust if necessary for any padding/margins */ 20 // Assuming some padding or margins

        let textHeight = text.height(withConstrainedWidth: maxWidth, font: font)

        // Add some extra height for any additional UI elements in your cell
        let extraHeight = CGFloat (message.text.count)
        
        // Minimum height to ensure visibility
        let minHeight: CGFloat = 60

        if message.isSentByCurrentUser == true {
            // Adjust height for sender's cell
            
            return max(textHeight + extraHeight, minHeight)
        } else {
            // Adjust height for receiver's cell
            
            return max(textHeight + extraHeight, minHeight)
        }
        
       
    }

 }
    
// Extension to calculate height of text
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
    

