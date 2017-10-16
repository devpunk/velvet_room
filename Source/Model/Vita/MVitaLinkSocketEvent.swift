import Foundation

final class MVitaLinkSocketEvent:MVitaLinkSocket
{
    //MARK: internal
    
    func request(
        requestCommand:MVitaPtpMessageInRequestCommand)
    {
        let message:MVitaPtpMessageOutRequestEvent = MVitaPtpMessageOutRequestEvent(
            requestCommand:requestCommand)
        writeMessageAndRead(message:message)
    }
}
