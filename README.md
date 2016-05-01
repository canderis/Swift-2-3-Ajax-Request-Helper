# SwiftAjaxRequest
A working Ajax Request helper file for swift


Usage:
ajaxRequest(
  [
      "one": "hi",
      "two": "2",
      "three": "testing",
      "four": "blah",
  
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
