//
//  AppDelegate.swift
//
//  Copyright (c) 2017-Present Jochen Pfeiffer
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.tintColor = UIColor(resource: .main)

        customizeNavigationBarAppearance()

        return true
    }

    private
    func customizeNavigationBarAppearance() {
        let customNavigationBarAppearance = UINavigationBarAppearance()
        customNavigationBarAppearance.configureWithOpaqueBackground()
        customNavigationBarAppearance.backgroundColor = UIColor(resource: .main)

        customNavigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavigationBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavigationBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavigationBarAppearance.doneButtonAppearance = barButtonItemAppearance

        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = customNavigationBarAppearance
        appearance.compactAppearance = customNavigationBarAppearance
        appearance.standardAppearance = customNavigationBarAppearance
        if #available(iOS 15.0, *) {
            appearance.compactScrollEdgeAppearance = customNavigationBarAppearance
        }
    }
}
