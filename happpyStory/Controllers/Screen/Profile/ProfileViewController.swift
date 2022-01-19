//
//  MoreSettingsViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 29/12/21.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Variable Delaration

    private var collectionView: UICollectionView?
    private var userPosts = [UserPost]()

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.frame.size.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView?.backgroundColor = .red

        // cell

        collectionView?.register(PhotoCollecationViewCell.self, forCellWithReuseIdentifier: PhotoCollecationViewCell.identifier)

        // Headers

        collectionView?.register(ProfileinfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileinfoHeaderCollectionReusableView.identifier)

        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)

        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    private func configuration() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
    }

    // MARK: - Obj-C Method

    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ProfileView - Collecation View Delegate , Data Source

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // 1) user info 2) user post
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // user bio
        if section == 0 {
            return 0
        }
        // return userPosts.count
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollecationViewCell.identifier, for: indexPath) as! PhotoCollecationViewCell

        //        cell.configure(with: model)
        cell.configure(debug: "test")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        // get the model and open post controller
        // let model = userPosts[indexPath.row]
        let user = User(userName: "karmaln.flutter", name: (frist: "Amit", last: "Prajapati"), birthDate: Date(), gender: Gender.male, count: UserCount(followers: 12, following: 34, posts: 65), profilePhoto: URL(string: "https://www.google.com")!, joinDate: Date())

        let post = UserPost(identifier: "", postType: .photo, thumbnilImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)

        let vc = PostViewController(model: post)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        if indexPath.section == 1 {
            // this is header
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView

            tabControlHeader.delegate = self

            return tabControlHeader
        }

        // this is body (grid view)
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileinfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileinfoHeaderCollectionReusableView

        profileHeader.delegate = self

        return profileHeader
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height / 2.1)
        }

        // sizee of section tabs
        return CGSize(width: collectionView.width, height: 50)
    }
}

// MARK: - ProfileHeader Delegate

extension ProfileViewController: ProfileinfoHeaderCollectionReusableViewDelegate {
    // caling highLights on click....!
    func profileHeaderDidTapHighLightProfileButton() {
        let vc = HIghLightViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        present(vc, animated: true)
    }

    func profileHeaderDidTapPostButton(_ header: ProfileinfoHeaderCollectionReusableView) {
        // scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }

    func profileHeaderDidTapFollowerButton(_ header: ProfileinfoHeaderCollectionReusableView) {
        let vc = ListViewController(data: ["Amit", "Vandana", "Jayesh", "Ranchhod", "Rahul", "Roy"])
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func profileHeaderDidTapFollowingButton(_ header: ProfileinfoHeaderCollectionReusableView) {
        let vc = ListViewController(data: ["Amit", "Vandana", "Jayesh", "Ranchhod", "Rahul", "Roy"])
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func profileHeaderDidTapEditProfileButton(_ header: ProfileinfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

// MARK: - ProfileTabs Delegate

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButton() {
        // Reload Collection view with data
    }

    func didTapTaggedButton() {
        // Reload Collection view with data
    }

    func didTapReelButton() {
        // Reload Collection view with data
    }
}
