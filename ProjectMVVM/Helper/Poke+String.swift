
import Foundation

class HelperString {
    
    static func getIdFromUrl(url: String) -> String {
        return url.components(separatedBy: "/").filter({$0 != ""}).last!
    }
}
