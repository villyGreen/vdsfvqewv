//
//  dViewController.swift
//  offers
//
//  Created by zz on 25.05.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
////
//  NewSectionTableViewCell.swift
//  Resume Creator
//
//  Created by vadim.vitkovskii on 25.05.2022.
//


class NewSectionTableViewCell: UITableViewCell {
    private var isSelect = false
    let label = UILabel()
    var imageToButton = UIImage()
    let button = UIButton()
    static let id = "NewSectionTableViewCell"
    func configure() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Check"), for: .normal)
        button.addTarget(self, action: #selector(setRow), for: .touchUpInside)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func setRow() {
        isSelect == true ? button.setImage(UIImage(named: "Check"), for: .normal) : button.setImage(UIImage(named: "Clear Glyph"), for: .normal)
        isSelect.toggle()
    }
}



class MyCustomViewController: UIViewController {
    let mainLabel = UILabel()
    let button = UIButton()
    let tableView = UITableView()
    let addButton = UIButton()
    private var dataSource = ["Qualifications", "Awards",
                              "Research experience", "Publications",
                              "Memberships", "Gender", "Marital status",
                              "Children", "Certificates and achievements",
                              "Additional educations"]
    override func viewDidLoad() {
        for name in UIFont.familyNames {
          print(name)
          if let nameString = name as? String

        {
              print(UIFont.fontNames(forFamilyName: nameString))
          }
        }
    
        super.viewDidLoad()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = "Add new block"
        button.setImage(UIImage(named: "􀅼"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        self.view.addSubview(addButton)
        self.view.addSubview(tableView)
        tableView.register(NewSectionTableViewCell.self, forCellReuseIdentifier: NewSectionTableViewCell.id)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addButton.setBackgroundImage(UIImage(named: "Button Shape-3"), for: .normal)
        addButton.setTitle("Add new block", for: .normal)
        mainLabel.textColor = .black
        mainLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 18)
        self.view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150),
            addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.view.backgroundColor = UIColor.white
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOffset = .init(width: 0, height: -2)
        self.view.layer.shadowRadius = 20
        self.view.layer.shadowOpacity = 0.5
    }
    @objc
    private func close() {
        self.dismiss(animated: true)
    }
}

extension MyCustomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewSectionTableViewCell.id, for: indexPath) as! NewSectionTableViewCell
        cell.configure()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.label.font = UIFont(name: "SFProDisplay-Light", size: 15)
        cell.label.tintColor = .black
        cell.label.text = dataSource[indexPath.row]
        cell.label.textColor = .black
    
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
//   }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
    }
    
}


final class WelcomeContainerViewController: BottomSheetContainerViewController
<HelloViewController, MyCustomViewController> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do something
    }
    
}


class HelloViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }

}


open class BottomSheetContainerViewController<Content: UIViewController, BottomSheet: UIViewController> : UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Initialization
    public init(contentViewController: Content,
                bottomSheetViewController: BottomSheet,
                bottomSheetConfiguration: BottomSheetConfiguration) {
        
        self.contentViewController = contentViewController
        self.bottomSheetViewController = bottomSheetViewController
        self.configuration = bottomSheetConfiguration
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - Bottom Sheet Actions
    public func showBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.height
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .full
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .full
        }
    }
    
    public func hideBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -100
        
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: [.curveEaseOut],
                           animations: {
                            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .initial
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .initial
        }
    }
    
    // MARK: - Pan Action
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetViewController.view)
        let velocity = sender.velocity(in: bottomSheetViewController.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        
        switch sender.state {
        case .began, .changed:
            if self.state == .full {
                guard translation.y > 0 else { return }
                
                topConstraint.constant = -(configuration.height - yTranslationMagnitude)
                
                self.view.layoutIfNeeded()
            } else {
                let newConstant = -(configuration.initialOffset + yTranslationMagnitude)
                
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configuration.height else {
                    self.showBottomSheet()
                    return
                }
                
                topConstraint.constant = newConstant
                
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .full {
                
                if velocity.y < 0 {
                    // Bottom Sheet was full initially and the user tried to move it to the top
                    self.showBottomSheet()
                } else if yTranslationMagnitude >= configuration.height / 2 || velocity.y > 1000 {
                    self.hideBottomSheet()
                } else {
                    self.showBottomSheet()
                }
            } else {
                
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y < -1000 {
                    
                    self.showBottomSheet()
                    
                } else {
                    self.hideBottomSheet()
                }
            }
        case .failed:
            if self.state == .full {
                self.showBottomSheet()
            } else {
                self.hideBottomSheet()
            }
        default: break
        }
    }
    
    // MARK: - Configuration
    public struct BottomSheetConfiguration {
        let height: CGFloat
        let initialOffset: CGFloat
    }
    
    private let configuration: BottomSheetConfiguration
    
    // MARK: - State
    public enum BottomSheetState {
        case initial
        case full
    }
    
    var state: BottomSheetState = .initial
    
    // MARK: - Children
    let contentViewController: Content
    let bottomSheetViewController: BottomSheet
    
    // MARK: - Top Constraint
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - Pan Gesture
    lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addChild(contentViewController)
        self.addChild(bottomSheetViewController)
        
        self.view.addSubview(contentViewController.view)
        self.view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.view.addGestureRecognizer(panGesture)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewController.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            contentViewController.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            contentViewController.view.topAnchor
                .constraint(equalTo: self.view.topAnchor),
            contentViewController.view.bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor)
        ])
        
        contentViewController.didMove(toParent: self)
        
        topConstraint = bottomSheetViewController.view.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
                        constant: -100)
        
        NSLayoutConstraint.activate([
            bottomSheetViewController.view.heightAnchor
                .constraint(equalToConstant: configuration.height),
            bottomSheetViewController.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            bottomSheetViewController.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            topConstraint
        ])
        
        bottomSheetViewController.didMove(toParent: self)
    }
    
    // MARK: - UIGestureRecognizer Delegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

import UIKit

class dViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var butt: UIBarButtonItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    @IBAction func gg(_ sender: UIBarButtonItem) {
        var window: UIWindow?
              window = UIWindow()
              let bottomSheet = WelcomeContainerViewController(
                  contentViewController: HelloViewController(),
                  bottomSheetViewController: MyCustomViewController(),
                  bottomSheetConfiguration: .init(
                      height: UIScreen.main.bounds.height * 0.8,
                      initialOffset: 60 + window!.safeAreaInsets.bottom
                  )
                  )
              bottomSheet.modalPresentationStyle = .overFullScreen
              self.present(bottomSheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDetails.id, for: indexPath) as! PersonalDetails
        cell.customInit(isPicker: false)
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PersonalDetails.self, forCellReuseIdentifier: PersonalDetails.id)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
