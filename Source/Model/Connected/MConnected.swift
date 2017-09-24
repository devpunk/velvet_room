import Foundation

final class MConnected:Model<ArchConnected>
{
    var status:MConnectedStatusProtocol?
    
    required init()
    {
        super.init()
        
        statusOn()
    }
}
