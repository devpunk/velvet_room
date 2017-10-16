import Foundation

final class MConnectingPin
{
    let length:Int
    private let pinString:String
    
    init()
    {
        pinString = MConnectingPin.generatePin()
        length = pinString.count
    }
    
    //MARK: internal
    
    func digitAtIndex(index:Int) -> String
    {
        let startIndex:String.Index = pinString.startIndex
        let digitIndex:String.Index = pinString.index(
            startIndex,
            offsetBy:index)
        let digitCharacter:Character = pinString[digitIndex]
        let digitString:String = String(digitCharacter)
        
        return digitString
    }
    
    func validatePin(pinString:String) -> Bool
    {
        let equal:Bool = self.pinString == pinString
        
        return equal
    }
}
