import Foundation

final class MHome:Model<ArchHome>
{
    var database:Database?
    var account:DAccount?
    
    required init()
    {
        super.init()
    }
}
