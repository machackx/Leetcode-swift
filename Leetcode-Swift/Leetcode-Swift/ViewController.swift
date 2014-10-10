//
//  ViewController.swift
//  Algorithems
//
//  Created by Ce YANG on 08/10/2014.
//  Copyright (c) 2014 Ce Yang Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //First Palindrome
        let a = Palindrome()
        a.reverse(508);
        a.isPalindrome(302);
        a.findLongestPalindrome(inputString: "abbaaadd")
        a.longestPalindromeSimple("abaaba");
        a.longestPalindromeON("abaaba")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

