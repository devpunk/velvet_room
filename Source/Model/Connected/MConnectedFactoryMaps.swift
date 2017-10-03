import UIKit

extension MConnected
{
    static let kEventBadgeMap:[
        MVitaLinkLogTransferType:UIImage] = [
            MVitaLinkLogTransferType.request: #imageLiteral(resourceName: "assetConnectBadgeDownload"),
            MVitaLinkLogTransferType.send: #imageLiteral(resourceName: "assetConnectBadgeUpload")]
    
    static let kEventTransferTitleMap:[
        MVitaLinkLogTransferType:String] = [
            MVitaLinkLogTransferType.request:
                String.localizedModel(
                    key:"MConnected_eventTransferTypeRequest"),
            MVitaLinkLogTransferType.send:
                String.localizedModel(
                    key:"MConnected_eventTransferTypeSend")]
    
    static let kEventSystemTitleMap:[
        MVitaLinkLogSystemType:String] = [
            MVitaLinkLogSystemType.connectionStart:
                String.localizedModel(
                    key:"MConnected_eventSystemConnectionStart")]
}
