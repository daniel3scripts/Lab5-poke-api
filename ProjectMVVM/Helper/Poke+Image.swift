

import Foundation
import UIKit

class HelperImage {
    
    static func setImage(id: String) -> UIImage? {
        let url = URL(string: setUrlImage(id: id))
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            return image
        }
        
        return nil
    }

    static func setUrlImage(id: String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
