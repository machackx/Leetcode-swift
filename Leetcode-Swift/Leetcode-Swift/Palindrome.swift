//
//  Palindrome.swift
//  Algorithems
//
//  Created by Ce YANG on 08/10/2014.
//  Copyright (c) 2014 Ce Yang Studio. All rights reserved.
//

import Foundation

class Palindrome {

    func reverse(var num: Int) -> Int {
        //Take 123 as example 
        // 123 -> (3 + 12 * 10) => reverse (3 * 10 + 2) * 10 + 1
        assert(num >= 0, "number should greater than 0")
        var rev : Int = 0
        while (num != 0) {
            //first put 1 in 个位数
            rev = num % 10 + rev * 10 // 1: 3 + 0*10 2: 12%10 + 30
            num = Int(num / 10)       // 1: 12 2: 1
        }
        println("\(rev)")
        return rev;
    }
    
    func isPalindrome (var num : Int) -> Bool {
        if (num < 0)  {
            return false
        }else {
            var div : Int = 1
            while num / div > 10 {
                div *= 10
            }
            while (num != 0) {
                //比较首位两位
                var h = num / div
                var q = num % 10
                if h != q {
                    println("Not a Palindrome")
                    return false
                } else {
                    num = (num%div)
                    div /= 100
                }
            }
            println("Is a Palindrome")
            return true
        }
    }
    
    func findLongestPalindrome (inputString string: String) {
        //  absb
        //  100000000000
        //  010000000000
        //  001000000000
        //  000100000000
        
        let n = countElements(string)
        var longBegin = 0
        var maxLen = 1
        // Two dimensional array
        var numRows = 100
        var numColumns = 100
        /*
        var array = Array<Array<Bool>>()
        
        for column in 0...numColumns {
            array.append(Array(count: numRows, repeatedValue: Bool()))
        }
        */
        //嵌套
        var array = [[Bool]](count: numColumns, repeatedValue:[Bool](count: numRows, repeatedValue:false));
        for i in 0...n {
            array[i][i] = true
        }
        
        for(var i = 0; i < n-1; i++) {
            if(string[i] == string[i+1]) {
                array[i][i+1] = true
                longBegin = i
                maxLen = 2
            }
        }
        
        for (var len = 3; len <= n; len++) {
            for (var i = 0; i<n-len+1; i++) {
                var j = i+len-1
                if string[i] == string[j] && array[i+1][j-1] {
                    array[i][j] = true
                    longBegin = i
                    maxLen = len
                }
            }
        }
        println("Longest palindrome is \(string[longBegin..<longBegin+maxLen])")
    }
    
    func expandAroundCenter (s: String, c1:Int, c2 : Int) -> String {
        var l : Int = c1 //left
        var r : Int = c2 //right
        let n = countElements(s)
        while (l>=0 && r<=n-1 && s[l] == s[r]) {
            l--
            r++
        }
        if (l+1 >= 0 && (r-2)>=l) {
            return s[(l+1)...(r-1)]
        } else {
            return s[l...r]
        }
        
    }
    
    // 比findLongestPalindrome方法更节约了空间 算法复杂度O(N^2)
    func longestPalindromeSimple (s:String) -> String{
        let n = countElements(s)
        if n==0 {
            return "";
        }
        var longestString = s[0...1]
        for(var i=1; i<n-1; i++) {
            var p1: String = expandAroundCenter(s, c1: i, c2: i)
            if countElements(p1) > countElements(longestString) {
                longestString = p1
            }
            
            var p2 : String = expandAroundCenter(s, c1: i, c2: i+1)
            if countElements(p2) > countElements(longestString) {
                longestString = p2
            }
        }
        println(longestString)
        return longestString
    }
    
    // An O(N) Solution (Manacher’s Algorithm)
    // http://leetcode.com/2011/11/longest-palindromic-substring-part-ii.html
    // Transform S into T.
    // For example, S = "abba", T = "^#a#b#b#a#$".
    // ^ and $ signs are sentinels appended to each end to avoid bounds checking
    func preProcess(s:String) -> String {
        let n = countElements(s)
        if n==0 {
            return "^$"
        }
        var ret:String = "^"
        for (var i=0; i<n; i++) {
            ret += "#" + s[i..<(i+1)]
        }
        ret += "#$"
        
        return ret
        
    }
    
    func longestPalindromeON (string:String) -> String {
        var T:String = preProcess(string)
        let n = countElements(T)
        var P = [Int](count: n, repeatedValue: 0)
        var C = 0
        var R = 0
        for (var i=1; i<n-1; i++) {
            let i_mirror = 2*C-i
            if R>i {
                P[i]=min(R-i, P[i_mirror])
            } else {
                P[i] = 0
            }
            //P[i] = (R>i)? min(R-i, P[i_mirror]):0
            
            while (T[i+1+P[i]]==T[i-1-P[i]]) {
                P[i]++
            }
            
            if (i+P[i] > R){
                C=i
                R=i+P[i]
            }
        }
        
        // Find the maximum element in P.
        var maxLength = 0
        var centerIndex = 0
        for(var i=0; i<n-1; i++) {
            if (P[i] > maxLength) {
                maxLength = P[i];
                centerIndex = i;
            }
        }
        
        println("result is \(string[((centerIndex - 1 - maxLength)/2)..<maxLength])")
        return string[((centerIndex - 1 - maxLength)/2)..<maxLength];
    }
    
    init () {}
}