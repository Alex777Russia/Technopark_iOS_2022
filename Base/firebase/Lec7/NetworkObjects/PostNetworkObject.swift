struct PostNetworkObject {
    let id: String
    let author: String
    let description: String
    let imageName: String
    let isLiked: Bool
    
    init?(dict: [String: Any], id: String) {
        guard
            let author = dict["author"] as? String,
            let description = dict["description"] as? String,
            let imageName = dict["imageName"] as? String,
            let isLiked = dict["isLiked"] as? Bool
        else {
            return nil
        }
        
        self.id = id
        self.author = author
        self.description = description
        self.imageName = imageName
        self.isLiked = isLiked
    }
}
