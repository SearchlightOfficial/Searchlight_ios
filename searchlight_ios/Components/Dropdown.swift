//
//  Dropdown.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/22/24.
//

import SwiftUI

extension View {
    func transparentFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
}

struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct Dropdown: View {
    @Binding var text: String
    let options: Array<String>
    let label: String
    let placeholder: String
    var action: (() -> Void)?

    @State private var isOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Typography(text: label, color: .Grayscale._30, fontType: .Caption)
                .padding(.horizontal, 8)
            
            Button(action: {
                withAnimation() {
                    isOpen = !isOpen
                }
            }, label: {
                HStack {
                    Typography(text: text == "" ? placeholder : text, color: text == "" ? .Grayscale._40 : .Grayscale._10, fontType: .Body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(.Icons.expandMore)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.Grayscale._70)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color.Grayscale._50, lineWidth: 1)
            )
            .background(Color.Grayscale._70)
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12.0)
        .transparentFullScreenCover(isPresented: $isOpen) {
            GeometryReader { geometry in
                Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack {
                        VStack(spacing: 0) {
                            Typography(text: label, color: .Grayscale._20, fontType: .Caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 8.0)
                                .padding(.horizontal, 16.0)
                            
                            ForEach(options, id: \.self) { element in
                                Button(action: {
                                    text = element
                                    isOpen = false
                                    (action ?? {print("Dropdown Submited: " + text)})()
                                }, label: {
                                    Typography(text: element, color: .Grayscale._10, fontType: .HeadLine)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 12.0)
                                        .padding(.horizontal, 16.0)
                                })
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.Grayscale._70)
                        .cornerRadius(12)
                        .offset(y: isOpen ? 0 : 100)
                        .animation(.easeIn(duration: 1), value: isOpen)
                    }
                    .padding()
                }
                .background(Color.black.opacity(0.2))
                .onTapGesture { isOpen = false }
            }
        }
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var sex = ""
        
        var body: some View {
            VStack {
                Dropdown(text: $sex, options: ["남자", "여자", "알 수 없음"], label: "성별", placeholder: "성별을 선택해주세요")
            }
        }
    }
    
    return PreviewWrapper()
}
