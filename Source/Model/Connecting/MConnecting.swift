import Foundation

final class MConnecting:Model<ArchConnecting>
{
    private(set) var status:MConnectingStatusProtocol?
    
    required init()
    {
        super.init()
        statusLoading()
    }
    
    //MARK: internal
    
    func statusLoading()
    {
        status = MConnectingStatusLoading()
    }
    
    func statusPin()
    {
        status = MConnectingStatusPin()
    }
}
