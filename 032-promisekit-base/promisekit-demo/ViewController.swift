//
//  ViewController.swift
//  promisekit-demo
//
//  Created by  moma on 2019/1/19.
//  Copyright © 2019 imzyf. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        test1()
//        test2()
//        test3()
//        test4()
//        test5()
//        test6()
//        test7()
        test8()
//        test9()
    }

    func test1() {
        _ = cook()
            .then {
                self.eat(food: $0)
            }
            .then {
                self.wash(something: $0)
            }
            .done {
                print($0)
        }
        
        // 可简化为
        _ = cook()
            .then(eat)
            .then(wash)
            .done {
                print($0)
        }
    }
    
    // catch 处理
    func test2() {
        _ = failCook()
            .then(eat)
            .then(wash)
            .done {
                print($0)
            }
            .catch {
                print($0.localizedDescription)
        }
    }
    
    // ensure like finally
    func test3() {
        _ = failCook()
            .then(eat)
            .then(wash)
            .done {
                print($0)
            }
            .ensure {
                print("go to sleep")
            }
            .catch {
                print($0.localizedDescription)
        }
    }
    
    // map compactMap
    func test4() {
        _ = cook()
            .map {
                return "\($0), and a cup of coffee"
            }
            .then(eat)
            .done {
                print($0)
            }
    }
    
    // get tap
    func test5() {
        _ = cook()
            .get {
                printLog("--- \($0)")
            }
            .then(eat)
            .tap {
                print($0)
            }
            .done {
                printLog($0)
            }
    }
    
    /// when
    func test6() {
        _ = when(fulfilled: cupUp(), boil())
            .done {
                printLog("all finish: \($0.0) - \($0.1)")
            }
    }
    
    /// race
    func test7() {
        _ = race(cupUp(), boil())
            .done {
                printLog("the fast finish: \($0)")
            }
    }
    
    /// guarantee
    func test8() {
        firstly {
            easyCook()
        }.done {
            printLog("\($0)")
        }
    }
    
    /// after
    func test9() {
        printLog("emmm...")
        after(seconds: 3)
            .done {
                printLog("hello world")
            }
    }
}

extension ViewController {
    
    // cook -> get egg and rise
    func cook() -> Promise<String> {
        printLog("start to cook")
        let p = Promise<String> { resolver in
            // dely 1 second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                printLog("finish cook")
                resolver.fulfill("hot rise") 
            }
        }
        return p
    }
    
    // eat -> get empty and dirty bowl
    func eat(food: String) -> Promise<String> {
        printLog("start to eat: \(food)")
        let p = Promise<String> { resolver in
            // dely 1 second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                printLog("finish eat")
                resolver.fulfill("empty and dirty bowl")
            }
        }
        return p
    }
    
    // wash -> get clean bowl
    func wash(something: String) -> Promise<String> {
        printLog("start to wash: \(something)")
        let p = Promise<String> { resolver in
            // dely 1 second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                printLog("finish wash")
                resolver.fulfill("clean bowl")
            }
        }
        return p
    }
    
    // 切菜
    func cupUp() -> Promise<String> {
        printLog("开始切菜")
        let p = Promise<String> { resolver in
            // dely 2 second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                printLog("切菜完毕")
                resolver.fulfill("切好的菜")
            }
        }
        return p
    }
    
    // 烧水
    func boil() -> Promise<String> {
        printLog("开始烧水。")
        let p = Promise<String> { resolver in
            // dely 1 second
            after(seconds: 1)
                .done {
                    printLog("烧水完毕")
                    resolver.fulfill("烧好的水")
                }
        }
        return p
    }
}

extension ViewController {
    
    func failCook() -> Promise<String> {
        print("start to cook")
        let p = Promise<String> { resolver in
            // dely 1 second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                printLog("fail cook")
                let error = NSError(domain: "demo", code: 0, userInfo: [NSLocalizedDescriptionKey: "dont have rice"])
                resolver.reject(error)
            }
        }
        return p
    }
    
    func easyCook() -> Guarantee<String> {
        print("start to cook")
        let p = Guarantee<String> { seal in
            // dely 1 second
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                printLog("finish cook")
                seal("hot water")
            }
        }
        return p
    }
}

func printLog(_ string: String) {
    print("\(string) - \(Date()) ")
}
