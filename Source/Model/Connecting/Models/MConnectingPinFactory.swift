import Foundation

extension MConnectingPin
{
    private static let kFallBackPin:String = "000000000"
    private static let kPinLength:Int = 8
    private static let kMaxPinRandom:UInt32 = 99999999
    
    class func generatePin() -> String
    {
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = MConnectingPin.kPinLength
        numberFormatter.minimumIntegerDigits = MConnectingPin.kPinLength
        
        let random:UInt32 = arc4random_uniform(
            MConnectingPin.kMaxPinRandom)
        let number:NSNumber = random as NSNumber
        
        guard
        
            let pinString:String = numberFormatter.string(
                from:number)
        
        else
        {
            return MConnectingPin.kFallBackPin
        }
        
        return pinString
    }
}
