//
//  UtilityAlerts.swift
//  MVVM
//
//  Created by Ghous Ansari on 14/06/23.
//

import UIKit

struct AlertsConstants {
    static let AlertTitle = "Alert"
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
}

class UtilityAlerts {

    /// add a call back action for yes and cancel
    static func displayAlert(title: String, actionTitle: String, cancelTitle: String = AlertsConstants.CancelAlertTitle, isBothAlertRequired: Bool = false, message: String, handler: @escaping ((_ okTapped: Bool, _ cancelTapped: Bool) -> Void)) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAlert = UIAlertAction(title: actionTitle, style: .default) { _ in
            handler(true, false)
        }
        alertController.addAction(okAlert)
        
        let cancelAlert = UIAlertAction(title: cancelTitle, style: .default) { _ in
            handler(false, true)
        }
        
        if isBothAlertRequired {
            alertController.addAction(cancelAlert)
        }

        guard let viewController = UIApplication.shared.windows.last(where: { $0.isKeyWindow })?.rootViewController else {
            fatalError("keyWindow has no rootViewController")
        }

        DispatchQueue.main.async {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }

}
