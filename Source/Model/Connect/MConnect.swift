import UIKit

class MConnect:Model<ArchConnect>
{
    var delegate:ConnectDelegate?
    var inputStream:InputStream?
    var outputStream:OutputStream?
    let requestPort:Int = 9309

    func startWireless()
    {
        delegate = ConnectDelegate()

        Stream.getStreamsToHost(
            withName:"localhost",
            port:80,
            inputStream: &inputStream,
            outputStream: &outputStream)
        
        outputStream?.delegate = delegate
        inputStream?.delegate = delegate

        inputStream?.schedule(in: RunLoop.main, forMode: RunLoopMode.commonModes)
        outputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.commonModes)
        outputStream?.open()
        inputStream?.open()
    }
}

class ConnectDelegate:NSObject, StreamDelegate
{
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event)
    {
        print(eventCode)
        print(aStream.streamError?.localizedDescription)
    }
}
