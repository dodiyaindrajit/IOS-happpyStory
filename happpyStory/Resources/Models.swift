//
//  StorageManager.swift
//  Instagram
//
//  Created by karmaln technology on 06/01/22.
//

import Foundation

public enum UserPostType {
    case photo, video
}

enum Gender {
    case male, female, other
}

public struct User {
    let userName: String
    let name: (frist: String, last: String)
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let profilePhoto: URL
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnilImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}

public struct PostLike {
    let username: String
    let postIdentifier: String
}

public struct CommentLike {
    let username: String
    let postIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
