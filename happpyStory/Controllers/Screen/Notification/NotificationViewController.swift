//
//  LikeViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 24/12/21.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableview: UITableView = {
        let tableView = UITableView()
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()

    private lazy var noNotificationsView = NoNotificationsView()

    private var models = [UserNotification]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fatchNotififcation()
        navigationItem.title = "Notification"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
//        spinner.startAnimating()
//        view.addSubview(noNotificationsView)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
//        addNoNotificationsView()
    }

    private func addNoNotificationsView() {
        tableview.isHidden = true
        view.addSubview(tableview)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.height / 8)
        noNotificationsView.center = view.center
    }

    private func fatchNotififcation() {


        for x in 0 ... 100 {
            let user = User(userName: "amit.flutter", name: (frist: "Amit", last: "Prajapati"), birthDate: Date(), gender: Gender.male, count: UserCount(followers: 12, following: 34, posts: 65), profilePhoto: URL(string: "https://www.google.com")!, joinDate: Date())

            let post = UserPost(identifier: "", postType: .photo, thumbnilImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [],owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow, text: "Hello World", user: user)

            models.append(model)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]

        switch model.type {
        case .like:
            let cell = tableview.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell

        case .follow:
            let cell = tableview.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
//            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension NotificationViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("Tapped on Like Post")
        switch model.type {
        case let .like(post):
            let vc = PostViewController(model: post)
            vc.title = "Photo"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow:
            fatalError("Dev Should never call....")
        }
    }
}

extension NotificationViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped on Follow Post")
    }
}
