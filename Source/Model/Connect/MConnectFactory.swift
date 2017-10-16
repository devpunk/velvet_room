import Foundation

extension MConnect
{
    //MARK: internal
    
    class func factoryWalk() -> [MConnectWalkProtocol]
    {
        let itemCover:MConnectWalkCover = MConnectWalkCover()
        let itemWifi:MConnectWalkWifi = MConnectWalkWifi()
        let itemCma:MConnectWalkCma = MConnectWalkCma()
        
        let items:[MConnectWalkProtocol] = [
            itemCover,
            itemWifi,
            itemCma]
        
        return items
    }
}
