//
//  ViewController.swift
//  RxSupport
//
//  Created by outofcoding on 06/14/2020.
//  Copyright (c) 2020 outofcoding. All rights reserved.
//

import UIKit

import RxSwift
import RxSupport

class ViewController: UIViewController {
    
    private lazy var disposeBag = DisposeBag()
    
    private let text = "number is"
    private let format = "string = "

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let optionalValue1: String? = "not nil"
        Observable.just(optionalValue1)
            .notNil()
            .subscribe(weak: self) { (self, value) in
                print("string = \(value)")
            }
        .disposed(by: disposeBag)
        
        let optionalValue2: String? = nil
        Observable.just(optionalValue2)
            .or("null value")
            .subscribe(weak: self) { (self, value) in
                print("string = \(value)")
            }
        .disposed(by: disposeBag)
        
        Observable.just(1)
            .map { [weak self] number -> String? in
                if let self = self {
                    return "\(self.text) \(number)"
                } else {
                    return nil
                }
            }
            .notNil()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                print("\(self.format)\(value)")
            })
            .disposed(by: disposeBag)
        
        Observable.just(2)
            .map(weak: self) { (self, number) -> String in
                "\(self.text) \(number)"
            }
            .subscribe(weak: self) { (self, value) in
                print("\(self.format)\(value)")
            }
            .disposed(by: disposeBag)
    }
}

