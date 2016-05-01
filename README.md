# Swift Ajax Request
A working Ajax Request helper file for swift

Credits to [Rob](http://stackoverflow.com/questions/28008874/post-with-swift-and-api) on stack overflow for assistance.

###Usage:

```swift

ajaxRequest(
  [
      "one": "hi",
      "two": "2",
      "three": "testing",
      "four": "blah"
  ],
  url: "http://somesite.com/connection.php", // URL to php functions
  success: { (response) -> () in
      //code for success
      print(response)
      self.serverOutput.text = "\(response["data"])"
  },
  failure:{ (error) -> () in
      //code for failure
      self.serverOutput.text = "errorString = \(error)"
  }
)
```
