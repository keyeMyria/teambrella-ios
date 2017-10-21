//
/* Copyright(C) 2017 Teambrella, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License(version 3) as published
 * by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see<http://www.gnu.org/licenses/>.
 */

import Foundation

class EthereumWorker: CryptoWorker {
    struct Constant {
        static let maxAttempts = 3
        static let gasLimit = 1300000
    }
    
    let queue = DispatchQueue(label: "com.teambrella.ethereumWorker.queue", qos: .background)
    lazy var processor: EthereumProcessor = { EthereumProcessor.standard }()
    var hasNews: Bool = false
    
    private var observerToken: NSKeyValueObservation?
    
    init() {
        observerToken = service.server.observe(\.timestamp) { [weak self] object, change in
            self?.processor.key = object.key
        }
    }
    
    func sync() {
        self.queue.async { [unowned self] in
            var attemptsLeft = Constant.maxAttempts
            while attemptsLeft > 0 && self.hasNews {
                self.createWallets(gasLimit: Constant.gasLimit)
                self.verifyIfWalletIsCreated()
                self.depositWallet()
                self.autoApproveTxs()
                self.cosignApprovedTransactions()
                self.masterSign()
                self.publishApprovedAndCosignedTxs()
                self.hasNews = self.update()
                attemptsLeft -= 1
            }
        }
    }
    
    @discardableResult
    func createWallets(gasLimit: Int) -> Bool {
        let myPublicKey = processor.key.publicKey
        // WIP!
        return false
    }
    
    func verifyIfWalletIsCreated() {
        
    }
    
    func depositWallet() {
        
    }
    
    func autoApproveTxs() {
        
    }
    
    func cosignApprovedTransactions() {
        
    }
    
    func masterSign() {
        
    }
    
    func publishApprovedAndCosignedTxs() {
        
    }
    
    func update() -> Bool {
        return false
    }
    
}