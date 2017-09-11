import Foundation

extension MConnect
{
    //MARK: internal
    
    class func factoryWalk() -> [MConnectWalkProtocol]
    {
        let itemCover:MConnectWalkCover = MConnectWalkCover()
        
        let items:[MConnectWalkProtocol] = [
            itemCover]
        
        return items
    }
}
