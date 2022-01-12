//
//  PostViewController.swift
//  Instagram
//
//  Created by karmaln technology on 06/01/22.
//

import UIKit

/// states of a rendered cell
enum PostrenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String) // like,comment , share
    case comments(comments: [PostComment])
}

/// model of renderd post
struct PostRenderViewModel {
    let renderType: PostrenderType
}

class PostViewController: UIViewController {
    private let model: UserPost?

    private var renderModels = [PostRenderViewModel]()

    private let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)

        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)

        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)

        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)

        return tableView
    }()

    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModel()
    }

    private func configureModel() {
        guard let userPostModel = model else {
            return
        }
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // 4 Comments
        var comment = [PostComment]()
        for x in 0..<4{
            comment.append(PostComment(identifier: "123_\(x)", username: "@amit\(x)\(x)", text: "Cool", createdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comment)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions: return 1
        case let .comments(comments): return comments.count > 4 ? 4 : comments.count
        case .header: return 1
        case .primaryContent: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]

        switch model.renderType {
        case let .header(user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            cell.configure(with: user)
            return cell
        case let .primaryContent(post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
        case let .actions(actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
            return cell
        case let .comments(comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header: return 70
        case .primaryContent: return tableView.width
        case .actions: return 60
        case .comments: return 50
        }
    }
}
