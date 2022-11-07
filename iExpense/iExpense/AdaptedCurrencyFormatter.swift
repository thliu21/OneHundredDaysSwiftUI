import Foundation
import CurrencyFormatter

class AdaptedCurrencyFormatter: Formatter {
    private lazy var formatter: CurrencyFormatter = {
        let f = CurrencyFormatter()
        f.currency = Currency(rawValue: Locale.current.currencyCode ?? "USD") ?? .dollar
        return f
    }()
    
    override func string(for obj: Any?) -> String? {
        if let obj = (obj as? Double),
           let r = formatter.string(from: obj) {
            return r
        }
        return "$0.00"
    }
    
    override func getObjectValue(
        _ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
        for string: String,
        errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?
    ) -> Bool {
        if let unformatted = formatter.unformatted(string: string),
            let convertedValue = formatter.double(from: unformatted) {
            obj?.pointee = convertedValue as AnyObject
            return true
        } else {
            error?.pointee = "Invalid input \(string)" as NSString
            return false
        }
    }
}
