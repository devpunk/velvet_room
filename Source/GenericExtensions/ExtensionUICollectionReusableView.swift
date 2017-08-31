import UIKit

extension UICollectionReusableView
{
    class var reusableIdentifier:String
    {
        get
        {
            let stringName:String = String(describing:type(of:self))
            
            return stringName
        }
    }
}
