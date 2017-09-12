import Foundation

extension MConnect
{
    //MARK: internal
    
    class func factoryWalk() -> [MConnectWalkProtocol]
    {
        let itemCover:MConnectWalkCover = MConnectWalkCover()
        let itemWifi:MConnectWalkWifi = MConnectWalkWifi()
        
        let items:[MConnectWalkProtocol] = [
            itemCover,
            itemWifi]
        
        return items
    }
}
