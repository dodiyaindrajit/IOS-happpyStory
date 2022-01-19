//
//  FavariteViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 23/12/21.
//

import UIKit

class ExploreViewController: UIViewController {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()

    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0.4
        return view
    }()

    private var models = [UserPost]()
    private var collectionView: UICollectionView?
    private var tabbedSearchCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchbar()
        configureExploreCollection()
        configureDimmedView()
        configureTabbedSearch()
    }

    private func configureSearchbar() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }

    private func configureExploreCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4) / 3, height: (view.width - 4) / 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollecationViewCell.self, forCellWithReuseIdentifier: PhotoCollecationViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }

    private func configureDimmedView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)
        view.addSubview(dimmedView)
    }

    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        tabbedSearchCollectionView?.register(PhotoCollecationViewCell.self, forCellWithReuseIdentifier: PhotoCollecationViewCell.identifier)
        tabbedSearchCollectionView?.backgroundColor = .yellow
        tabbedSearchCollectionView?.isHidden = true
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        view.addSubview(tabbedSearchCollectionView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }
}

// MARK: - SearchBarDelegate

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        guard let text = searchBar.text,!text.isEmpty else {
            return
        }
        quary(searchfor: text)
    }

    private func quary(searchfor text: String) {}

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))

        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self.dimmedView.alpha = 0.4
        }) { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }

    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        tabbedSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.4, animations: {
            self.dimmedView.alpha = 0
        }) {
            done in
            if done {
                self.dimmedView.isHidden = true
            }
        }
    }
}

// MARK: - UICollecationViewDelegate,DataSource,FlowLayout

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == tabbedSearchCollectionView {
//            return UICollectionViewCell()
//        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollecationViewCell.identifier, for: indexPath) as? PhotoCollecationViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(debug: "test")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        // change search Context
        if collectionView == tabbedSearchCollectionView {
            return
        }

//        let model = models[indexPath.row]
        let user = User(userName: "karmaln.flutter", name: (frist: "Amit", last: "Prajapati"), birthDate: Date(), gender: Gender.male, count: UserCount(followers: 12, following: 34, posts: 65), profilePhoto: URL(string: "https://www.google.com")!, joinDate: Date())

        let post = UserPost(identifier: "", postType: .photo, thumbnilImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)

        let vc = PostViewController(model: post)
        vc.title = user.userName
        navigationController?.pushViewController(vc, animated: true)
    }
}
