import Foundation

class Model<V:ViewMain>
{
    weak var view:V?
    private(set) weak var session:MSession!
    
    required init(session:MSession)
    {
        self.session = session
    }
}
