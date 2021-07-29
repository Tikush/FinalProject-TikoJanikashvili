
import UIKit

class PaySuccessViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var successButton: UIButton!
    
    // MARK: - Private Properties
    private var viewModel: PaySuccessViewModelProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        setupLayout()
    }
    
    private func setupLayout() {
        successButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func configureViewModel() {
        viewModel = PaySuccessViewModel(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func onMain(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
}
