//
//  SetTimeForRide.swift
//  io
//
//  Created by gv on 22/08/2023.
//

import UIKit

struct DateInfo {
    let value: Date
    let title: String
}

enum PickerData {
    case hour([Int])
    case minute([Int])
    case date([DateInfo])
    
    static func initData(_ type: PickerData) -> PickerData {
        switch type {
        case .hour(_):
            return .hour(Array(1...12))
        case .minute(_):
            return .minute(Array(0...60))
        case .date(_):
            var dates: [DateInfo] = [.init(value: Date(), title: "Hôm nay")]
            _ = Array(1...10).map { offset in
                if let next = Date().offset(.day, value: offset) {
                    dates.append(.init(value: next, title: ""))
                }
            }
            return .date(dates)
        }
    }
    
    func count() -> Int {
        switch self {
        case .hour(let array): return array.count
        case .minute(let array): return array.count
        case .date(let array): return array.count
        }
    }
}

final
class SetTimeForRide: BottomSheetController {

    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var minutePicker: UIPickerView!
    @IBOutlet weak var datePicker: UIPickerView!
    
    var hourData: PickerData = .initData(.hour([]))
    var minuteData: PickerData = .initData(.minute([]))
    var dateData: PickerData = .initData(.date([]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourPicker.delegate = self
        minutePicker.delegate = self
        datePicker.delegate = self
        
        hourPicker.dataSource = self
        minutePicker.dataSource = self
        datePicker.dataSource = self
        
        print(hourData)
        print(minuteData)
        print(dateData)
    }
}

extension SetTimeForRide: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case hourPicker: return hourData.count()
        case minutePicker: return minuteData.count()
        case datePicker: return dateData.count()
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var title: String = ""
        
        switch pickerView {
        case hourPicker:
            if case .hour(let array) = hourData,
               let item = array[safe: row] {
                title = "\(item)"
            }
            
        case minutePicker:
            if case .minute(let array) = minuteData,
               let item = array[safe: row] {
                title = "\(item)"
            }
            
        case datePicker:
            if case .date(let array) = dateData,
                  let item = array[safe: row] {
                title = "\(item)"
                
                if row == 0 {
                    title = item.title
                } else {
                    title = item.value.toString(
                        format: .custom("EEEE, dd MMMM"),
                        locale: Locale(identifier: "vi_VN")
                    ) ?? ""
                }
            }
        default: ()
        }
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14) // Set your desired font size here
        label.text = title
        return label
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        var title: String = ""
//        
//        switch pickerView {
//        case hourPicker:
//            if case .hour(let array) = hourData,
//               let item = array[safe: row] {
//                title = "\(item)"
//            }
//            
//        case minutePicker:
//            if case .minute(let array) = minuteData,
//               let item = array[safe: row] {
//                title = "\(item)"
//            }
//            
//        case datePicker:
//            if case .date(let array) = dateData,
//                  let item = array[safe: row] {
//                title = "\(item)"
//                
//                if row == 0 {
//                    title = item.title
//                } else {
//                    title = item.value.toString(format: .custom("EEE, dd MMMM")) ?? ""
//                }
//            }
//        default: ()
//        }
//        
//        guard let font = UIFont(name: "NunitoSans", size: UIFont.labelFontSize) else {
//            return NSAttributedString(string: title)
//        }
//        
//        return NSAttributedString(
//            string: title,
//            attributes: [
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9),
////                NSAttributedString.Key.foregroundColor: UIColor.black
//            ]
//        )
//    }
}
