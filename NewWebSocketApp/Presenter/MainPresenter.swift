//
//  MainPresenter.swift
//  NewWebSocketApp
//
//  Created by Bender on 20.05.2024.
//

import SocketIO
import UIKit

protocol MainPresenterProtocol: AnyObject {
    var items: [Item] { get }
    func connectSocket()
    func disconnectSocket()
}

import SocketIO

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var items: [Item] = []
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    init(view: MainViewProtocol) {
        self.view = view
        setupSocket()
    }
    
    private func setupSocket() {
        manager = SocketManager(socketURL: URL(string: "https://waxpeer.com/socket.io/")!, config: [.log(true), .compress, .forceWebsockets(true)])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket connected")
            self?.subscribeToEvents()
        }
        
        socket.on("subscribed") { data, ack in
            print("Subscribed to event: \(data)")
        }
        
        socket.on("add_item") { [weak self] data, ack in
            self?.handleNewItem(data)
        }
        
        socket.on("removed") { [weak self] data, ack in
            self?.handleRemovedItem(data)
        }
        
        socket.on("update") { [weak self] data, ack in
            self?.handleUpdatedItem(data)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket disconnected")
        }
        
        socket.on(clientEvent: .error) { data, ack in
            print("Socket error: \(data)")
        }
    }
    
    // Подключение к сокету
    func connectSocket() {
        guard socket.status != .connected else {
            print("Socket is already connected")
            return
        }
        socket.connect()
    }
    
    // Отключение от сокета
    func disconnectSocket() {
        guard socket.status == .connected else {
            print("Socket is already disconnected")
            return
        }
        socket.disconnect()
    }
    
    // Подписка на события
    private func subscribeToEvents() {
        socket.emit("subscribe", ["name": "csgo"])
        socket.emit("subscribe", ["name": "add_item"])
        socket.emit("subscribe", ["name": "remove"])
    }
    
    // Обработка нового элемента
    private func handleNewItem(_ data: [Any]) {
        guard let itemData = data.first as? [String: Any], let item = Item(json: itemData) else { return }
        items.append(item)
        view?.showItems(items)
    }
    
    // Обработка удаления элемента
    private func handleRemovedItem(_ data: [Any]) {
        guard let itemData = data.first as? [String: Any], let itemId = itemData["item_id"] as? Int else { return }
        items.removeAll { $0.itemId == itemId }
        view?.showItems(items)
    }
    
    // Обработка обновления элемента
    private func handleUpdatedItem(_ data: [Any]) {
        guard let itemData = data.first as? [String: Any], let itemId = itemData["item_id"] as? Int else { return }
        if let index = items.firstIndex(where: { $0.itemId == itemId }) {
            items[index] = Item(json: itemData)!
            view?.showItems(items)
        }
    }
}
