//
//  SocketIOManager.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/28/24.
//
import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    //서버와 메세지를 주고받을 클래스, 소켓을 연결하고 해제하는 기능 등 메인 기능 탑재
    var manager: SocketManager!
    
    //클라이언트 소켓
    var socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: "<https://searchlight.kwl.kr>")!, config: [
            .log(true),
            .compress,
        ])
        
        self.socket = manager.defaultSocket // "/"로 된 룸
        
        super.init()
        
        // 소켓 연결될 때 실행
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket Connected", data, ack)
        }
        
        // 소켓 해제될 때 실행
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket Disconnected", data, ack)
        }
        
        // 소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
        // 데이터 수신 -> 디코딩 -> 모델 추가 -> 갱신
        
        socket.on("sesac") { dataArray, ack in
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let date = data["createdAt"] as! String
            let id = data["id"] as! String
            
            print("SESAC RECEIVED \\(chat), \\(name), \\(date)")
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat":chat, "name":name, "createdAt":date, "id": id])
        }
        
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
