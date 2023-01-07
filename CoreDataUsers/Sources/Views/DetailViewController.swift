//
//  DetailViewController.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 25.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: DetailPresenterProtocol?
    var datePicker = UIDatePicker()
    var dateFormatter = DateFormatter()
    var genders = ["male", "female"]
    var isEnabled = false
    
    // MARK: - Outlets
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var backAndEditButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var imageButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 70
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(imageButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameTextField: UITextField = {
     let textField = UITextField()
        textField.placeholder = "Write your name here"
        textField.returnKeyType = .done
        textField.borderStyle = .line
        textField.textColor = .black
        textField.isEnabled = false
        return textField
    }()
    
    private lazy var genderTextField: UITextField = {
     let textField = UITextField()
        textField.placeholder = "Write your gender here"
        textField.returnKeyType = .done
        textField.borderStyle = .line
        textField.textColor = .black
        
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        textField.inputView = genderPicker
        
        textField.isEnabled = false
        return textField
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write your birth date here"
        textField.returnKeyType = .done
        textField.borderStyle = .line
        textField.textColor = .black
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        textField.inputView = datePicker
        
        textField.isEnabled = false
        return textField
    }()
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupAvailability()
        setupLayout()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(backAndEditButtonsStack)
        backAndEditButtonsStack.addArrangedSubview(backButton)
        backAndEditButtonsStack.addArrangedSubview(editButton)
        view.addSubview(imageButton)
        view.addSubview(nameTextField)
        view.addSubview(genderTextField)
        view.addSubview(dateTextField)
    }
    
    private func setupAvailability() {
        switch isEnabled {
        case true:
            nameTextField.isEnabled = true
            genderTextField.isEnabled = true
            dateTextField.isEnabled = true
            imageButton.isEnabled = true
            editButton.setImage(UIImage(systemName: "Save"), for: .normal)
        case false:
            nameTextField.isEnabled = false
            genderTextField.isEnabled = false
            dateTextField.isEnabled = false
            imageButton.isEnabled = false
            editButton.setImage(UIImage(systemName: "Edit"), for: .normal)
        }
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: nil
        )
    }

    private func setupLayout() {
        backAndEditButtonsStack.snp.makeConstraints { make in
            make.centerY.equalTo(view).multipliedBy(0.3)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        
        editButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        imageButton.snp.makeConstraints { make in
            make.centerY.equalTo(view).multipliedBy(0.7)
            make.centerX.equalTo(view)
            make.width.height.equalTo(140)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(imageButton.snp.bottom).offset(100)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(nameTextField.snp.bottom).offset(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(dateTextField.snp.bottom).offset(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
        }
    }

    // MARK: - Actions
    
    @objc private func backButtonPressed() {
        
    }
    
    @objc private func editButtonPressed() {
        
    }
    
    @objc private func imageButtonPressed() {
        
    }
    
    @objc private func doneButtonPressed() {
        
    }
}

// MARK: - Extensions

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
        genderTextField.resignFirstResponder()
    }
    
}

extension DetailViewController: UIImagePickerControllerDelegate {
    
}

extension DetailViewController: UINavigationControllerDelegate {
    
}

extension DetailViewController: DetailViewProtocol {
   
    func setupDetailView(name: String, gender: String?, dateOfBirth: Date?, image: Data?) {
        
    }
    
    
}
