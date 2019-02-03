
import Foundation
import UIKit
import SnapKit

class ActivityIndicator: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    var loadingView = UIView()
    var superView: UIView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not implemented")
    }

    func showActivityIndicatorView(uiView: UIView, alpha: CGFloat) {
        superView = uiView
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        loadingView.backgroundColor = .white
        loadingView.alpha = alpha
        uiView.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        loadingView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    func showActivityIndicator(uiView: UIView) {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        uiView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    func removeActivityIndicator() {
        UIView.animate(withDuration: 1.0, animations: {
            self.activityIndicator.alpha = 0

        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.activityIndicator.removeFromSuperview()
        }
    }

    func removeLoadingView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.activityIndicator.alpha = 0
            self.loadingView.alpha = 0
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadingView.removeFromSuperview()
        }
    }
}
