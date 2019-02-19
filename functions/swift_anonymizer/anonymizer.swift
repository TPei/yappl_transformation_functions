func main(args: [String:Any]) -> [String:Any] {
    if let data = args["data"] as? String {
        let length = data.count
        let response = String(repeating: "*", count: length)
        return [ "data" : response ]
    } else {
        return [ "data" : "" ]
    }
}
