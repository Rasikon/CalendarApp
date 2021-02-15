//
//  ViewController.swift
//  CalendarApp
//
//  Created by Rasikon on 15.02.2021.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    @IBOutlet var dateLabel: UILabel!
    
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataText = dateLabel.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 18000)
        if let date = dateFormatter.date(from: dataText) {
            startDate = date
        }
    }
    
    @IBAction func addEvent() {
        let store = EKEventStore()
        store.requestAccess(to: .event) { (granted, error) in
            if let error = error {
                print("request access error: \(error)")
            } else if granted {
                print("access granted")
            } else {
                print("access denied")
            }
        }
        
        let event = EKEvent(eventStore: store)
        let endDate = Date(timeInterval: 1800, since: startDate)
        event.calendar = store.defaultCalendarForNewEvents
        event.title = "Запись на сервис"
        event.startDate = startDate
        event.endDate = endDate
        do {
            try store.save(event, span: .thisEvent)
        } catch {
            print("saving event error: \(error)")
        }
    }
    
}

