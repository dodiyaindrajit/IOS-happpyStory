//
//  ViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 23/12/21.
//

import UIKit

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let commnets: PostRenderViewModel
}

class HomeViewController: UIViewController {

    //MARK: - variable declaration
    private var feedrenderModels = [HomeFeedRenderViewModel]()

    private let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)

        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)

        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)

        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)

        return tableView
    }()

    //MARK: - Override Method (Life Cycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds // full screen frame = .bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        check Authentication
//        handleAuthentication()
    }

    //MARK: - Other Methods (Authentication , MockModels)
    private func handleAuthentication() {
        if !CommanStruc.isLogin {
            let loginvc = LoginViewController()
            loginvc.modalPresentationStyle = .fullScreen
            present(loginvc, animated: false, completion: nil)
            print("User Not Login -> LoginScreen")
        } else {
            print("User Already Login")
        }
    }

    private func createMockModels() {
        let user = User(userName: "amit.flutter", name: (frist: "Amit", last: "Prajapati"), birthDate: Date(), gender: Gender.male, count: UserCount(followers: 12, following: 34, posts: 65), profilePhoto: URL(string: "https://www.google.com")!, joinDate: Date())

        let post = UserPost(identifier: "", postType: .photo, thumbnilImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user
        )

        var comments = [PostComment]()
        for x in 0 ..< 4 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@dax\(x)\(x)", text: "Superb pic", createdDate: Date(), likes: []))
        }

        for _ in 0 ... 10 {
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                commnets: PostRenderViewModel(renderType: .comments(comments: comments)))

            feedrenderModels.append(viewModel)
        }
    }
}


//MARK: - UITableViewDelegate , TableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedrenderModels.count * 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedrenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedrenderModels[position]
        }

        let subSection = x % 4
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            // Actions
            return 1
        } else if subSection == 3 {
            // Commetns
            let commnetsModel = model.commnets

            switch commnetsModel.renderType {
            case let .comments(comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedrenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedrenderModels[position]
        }

        let subSection = x % 4
        if subSection == 0 {
            // header
            switch model.header.renderType {
            case let .header(user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            @unknown default: fatalError("Invalid Case")
            }
        } else if subSection == 1 {
            // post
            let postModel = model.post
            switch postModel.renderType {
            case let .primaryContent(post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }

        } else if subSection == 2 {
            // Actions
            let actionModel = model.actions
            switch actionModel.renderType {
            case let .actions(provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell

                cell.delegate = self
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 3 {
            // Commetns
            let commnetsModel = model.commnets

            switch commnetsModel.renderType {
            case let .comments(comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 60
        } else if subSection == 3 {
            return 50
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 20 : 0
    }
}


//MARK: - IGFeedPostHeaderTableViewCellDelegate
extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapmoreButton() {
        print("print from delegate Header Options Tap")

        let actionsheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)

        actionsheet.addAction(UIAlertAction(title: "Why you're seeing this post ?", style: .default, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Hide", style: .default, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Unfollow", style: .default, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Share", style: .default, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Report", style: .destructive, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
//        actionsheet.popoverPresentationController?.sourceView = tableView
//        actionsheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionsheet, animated: true, completion: nil)
    }
}


//MARK: - IGFeedPostActionTableViewCellDelegate
extension HomeViewController: IGFeedPostActionTableViewCellDelegate{
    func didTapLikeButton() {
        print("Like Click...!")
    }

    func didTapCommentButton() {
        print("Comment Click...!")
    }

    func didTapShareButton() {
        print("Share Click...!")
    }

    func didTapSaveButton() {
        print("Save Click...!")
    }


}
