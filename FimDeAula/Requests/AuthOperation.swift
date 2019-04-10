//
//  AuthOperation.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 08/04/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

class AuthOperation: NSObject {
    
    static var logedPointerString = "grupo_selecionar"
    private var loginURL = URL(string: "https://graduacao.cesusc.edu.br/projetos/nucleo/uteis/login.php?&tid=0&lid=0&pid=24&arq_ret=R5QT1WSRQBMCVQVPFFQSF99MCT5RT44Q9WRW0RBM0FMM5QQ4R4CV59RWRF1F5SWCW0")
    
    func request() -> URLRequest? {
        guard let url = self.loginURL else { return nil }
        return URLRequest(url: url)
    }
    
    func processLogin(url: URL, completion: @escaping () -> ()) {
        if url.absoluteString.contains(AuthOperation.logedPointerString) {
            completion()
        }
    }
}
