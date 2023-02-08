//
//  PostCellDataModel.swift
//  Lec7
//
//  Created by e.korotkiy on 15.11.2022.
//

import UIKit

struct PostCellDataModel {
    func loadPosts() -> [PostCellModel] {
        let posts: [PostCellModel] = [.init(author: "Костя",
                                            description: "Lorem ipsum dolor sit amet.",
                                            image: UIImage(named: "cat1"),
                                            isLiked: false),
                                      .init(author: "Артур",
                                            description: "Quisque nisl erat",
                                            image: UIImage(named: "cat2"),
                                            isLiked: false),
                                      .init(author: "Андрей",
                                            description: "",
                                            image: UIImage(named: "cat3"),
                                            isLiked: false),
                                      .init(author: "Семен",
                                            description: "Nunc congue luctus lacus vitae congue. Fusce sit amet eros placerat, bibendum magna ut, fringilla purus. Donec laoreet sapien venenatis odio luctus posuere. Morbi in lorem odio. Nulla in dolor tortor. Etiam viverra accumsan velit. Duis porta lobortis gravida. Morbi vitae pharetra odio. Nam mi lacus, elementum eu nisl sit amet, finibus dapibus dui.",
                                            image: UIImage(named: "cat4"),
                                            isLiked: false),
                                      .init(author: "Сергей",
                                            description: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos",
                                            image: UIImage(named: "cat5"),
                                            isLiked: false),
                                      .init(author: "Алина",
                                            description: "Nulla in dolor tortor",
                                            image: UIImage(named: "cat6"),
                                            isLiked: false),
                                      .init(author: "Илья",
                                            description: "Nam mi lacus, elementum eu nisl sit amet, finibus dapibus dui",
                                            image: UIImage(named: "cat7"),
                                            isLiked: false),
                                      .init(author: "Олег",
                                            description: "Lorem ipsum",
                                            image: UIImage(named: "cat8"),
                                            isLiked: false),
                                      .init(author: "Паша",
                                            description: "Mauris suscipit mi sit amet tellus blandit, vel porttitor odio tincidunt",
                                            image: UIImage(named: "cat9"),
                                            isLiked: false),
                                      .init(author: "Макар",
                                            description: "Pellentesque volutpat viverra lacus", image: UIImage(named: "cat10"),
                                            isLiked: false),
                                      .init(author: "Даша",
                                            description: "Fusce sit amet eros placerat", image: UIImage(named: "cat11"),
                                            isLiked: false),
                                      .init(author: "Вика",
                                            description: "Curabitur pretium volutpat sollicitudin", image: UIImage(named: "cat12"),
                                            isLiked: false)]
        
        return posts
    }
}
