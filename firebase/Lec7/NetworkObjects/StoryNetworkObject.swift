struct StoryNetworkObject {
    let id: String
    let imageName: String
    let isViewed: Bool
    
    init?(dict: [String: Any], id: String) {
        guard
            let imageName = dict["imageName"] as? String,
            let isViewed = dict["isViewed"] as? Bool
        else {
            return nil
        }
        
        self.id = id
        self.imageName = imageName
        self.isViewed = isViewed
    }
}

struct CreateStoryData {
    let imageName: String
    let isViewed = Bool.random()
    
    func dict() -> [String: Any] {
        return [
            "imageName": imageName,
            "isViewed": isViewed
        ]
    }
}
