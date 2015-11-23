//
//  ViewController.swift
//  Chatroom
//
//  Created by cedric jo on 11/12/15.
//  Copyright © 2015 cedric jo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var messages = [String?]()
    var socket: SocketIOClient?
    @IBOutlet weak var ConnectLabel: UITextField!
    @IBAction func ConnectButtonPressed(sender: UIButton) {
        socket = SocketIOClient(socketURL: ConnectLabel.text!)
        socket!.connect()
        socket!.on("connect") { data, ack in
            print("ios: sockets")
        }
        socket!.on("messageFromServer") { data, ack in
            print("\(data)")
            let d = data
            self.messages.append(d[0] as? String)
            print(self.messages)
            self.tableView.reloadData()
        }
    }
    //DISPLAYING THE LIST
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("HELLO")
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = self.messages[indexPath.row]
        // return cell so that Table View knows 'what to draw in each row
        print(cell)
        return cell
    }
    //NUMBER OF ROWS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    @IBOutlet weak var messageLabel: UITextField!
    @IBAction func messageButtonPressed(sender: UIButton) {
        socket?.emit("messageToServer", messageLabel.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

