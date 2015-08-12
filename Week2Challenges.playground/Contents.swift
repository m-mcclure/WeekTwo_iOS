//: Playground - noun: a place where people can play

import UIKit

//Monday's Code Challenge: Write a function that determines how many words there are in a sentence

//solution 1
let sentence = "How many words are in this sentence?"

func countWordsInSentence(sentence: String) -> Int {
  let sentenceArray = Array(sentence)
  let stringLength = sentenceArray.count
  var wordCount = 1
  
  for char in sentenceArray {
    if char == " " {
      wordCount++
    }
  }
  return wordCount
}

countWordsInSentence(sentence)


//solution 2
let sentence2 = "Count the words in this sentence."

func wordCount(sentence: String) -> Int {
  let sentenceArray = sentence.componentsSeparatedByString(" ")
  
  return sentenceArray.count
}

wordCount(sentence2)


//Tuesday: Code Challenge: Write a function that returns all the odd elements of an array

//solution 1:
let randomArray = [23, "red", false, true, "aquamarine", 666, 24, "twenty"]

func returnOddElements(array: [AnyObject]) -> [AnyObject] {
  var oddElementsArray = [AnyObject]()
  let count = array.count
  var i = 0
  
  for (i = 0; i < count; i++) {
    if i % 2 != 0 {
      let itemToAppend: AnyObject = array[i]
      oddElementsArray.append(itemToAppend)
    }
  }
  
  return oddElementsArray
}

returnOddElements(randomArray)


//solution 2:

let someArray = ["Poland", 343, true, false, "shark", "blue", 1942, 1981, 3.14, "umm"]

func returnOddElements2(anArray: [AnyObject]) -> [AnyObject] {
  var oddArray = [AnyObject]()

  for (index, element) in enumerate(anArray) {
    if index % 2 != 0 {
      oddArray.append(element)
    }
  }
  return oddArray
}

returnOddElements2(someArray)


//Wednesday: Code Challenge: Write a function that computes the list of the first 100 Fibonacci numbers.

func createFibonacciSequence(howManyFibNumbersYouWant: Double){
  var j = 0.0
  var k = 1.0
  var i = 0.0
  println(j)
  println(k)
  for (i = 0.0; i < howManyFibNumbersYouWant; i++){
    let l = j + k
    println(i)
    j = k
    k = l
  }
}

createFibonacciSequence(100)


/* NOTE: The challenge below works, but Playground was being buggy when all of my challenges were uncommented at the same time. If you uncomment Thursday's challenge and comment out the rest, it will work.

//Thursday: Code Challenge: Write a function that tests whether a string is a palindrome


func isStringAPalindrome(stringy: String){
  let stringArray = Array(stringy) 
  let reversedStringArray = stringArray.reverse()
  
  if stringArray == reversedStringArray {
    println("Yes, this string is a palindrome.")
  } else {
    println("No, this string is not a palindrome.")
  }
}

isStringAPalindrome("kayak")
isStringAPalindrome("Philadelphia")

*/

