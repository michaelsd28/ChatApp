package model

interface Message {
    var id: String?
    var senderId: String?
    var receiverId: String?
    var message: String?
    var timestamp: String?
    var type: String?
}