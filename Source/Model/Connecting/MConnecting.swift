import Foundation

final class MConnecting:Model<ArchConnecting>
{
    var status:MConnectingStatusProtocol?
    private(set) var modelPin:MConnectingPin?
    
    required init()
    {
        super.init()
        statusLoading()
    }
    
    //MARK: internal
}
