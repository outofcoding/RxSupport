// The MIT License (MIT)
//
// Copyright (c) 2019 outofcoding <outofcoding@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import RxSwift

public extension ObservableType {
    
    func flatMap<A: AnyObject, O: ObservableType>(weak obj: A?, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMap { try self.flatMapWeakly(weak: obj, value: $0, closure: selector) }
    }
    
    func flatMapFirst<A: AnyObject, O: ObservableType>(weak obj: A?, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMapFirst { try self.flatMapWeakly(weak: obj, value: $0, closure: selector) }
    }
    
    func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A?, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMapLatest { try self.flatMapWeakly(weak: obj, value: $0, closure: selector) }
    }
    
    func `do`<A: AnyObject>(weak obj: A?, _ onNext: @escaping (A, Self.Element) throws -> Void) -> Observable<Self.Element> {
        return self.do(onNext: { try self.weakly(weak: obj, value: $0, closure: onNext) })
    }
    
    func map<A: AnyObject, O>(weak obj: A?, _ transform: @escaping (A, Self.Element) throws -> O) -> Observable<O> {
        return map { try self.weakly(weak: obj, value: $0, closure: transform) }.notNil()
    }
    
    func subscribe<A: AnyObject>(weak obj: A?, _ onNext: @escaping (A, Self.Element) -> Void) -> Disposable {
        return subscribe(onNext: { self.weakly(weak: obj, value: $0, closure: onNext) })
    }
}

private extension ObservableType {

    func weakly<A: AnyObject, R>(weak obj: A?, value: Self.Element, closure: @escaping (A, Self.Element) throws -> R) rethrows -> R? {
        return try obj.map { try closure($0, value) }
    }
    
    func flatMapWeakly<A: AnyObject, O: ObservableType>(weak obj: A?, value: Self.Element, closure: @escaping (A, Self.Element) throws -> O) rethrows -> Observable<O.Element> {
        return try weakly(weak: obj, value: value, closure: closure)?.asObservable() ?? .empty()
    }
}
