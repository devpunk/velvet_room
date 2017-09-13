import Foundation

final class MConnecting:Model<ArchConnecting>
{
    weak var timer:Timer?
    var status:MConnectingStatusProtocol?
    private(set) var modelPin:MConnectingPin?
    
    required init()
    {
        super.init()
        statusLoading()
    }
    
    //MARK: internal
    
    func createPin()
    {
        modelPin = MConnectingPin()
        statusPin()
        view?.updateStatus()
    }
}
