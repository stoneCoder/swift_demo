//
//  SwiftUIView.swift
//  TestUIDemo
//
//  Created by sinosun on 2020/9/29.
//  Copyright © 2020 sinosun. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        List(0..<5){item in
            Text("List").font(.title)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
