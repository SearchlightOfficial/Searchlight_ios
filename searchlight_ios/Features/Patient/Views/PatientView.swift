//
//  PatientView.swift
//  searchlight_ios
//
//  Created by 김성빈 on 7/10/24.
//

import SwiftUI

struct PatientView: View {
    @ObservedObject var viewModel = PatientViewModel()
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Header(prevClick: {
                viewModel.prevStep()
            })
            
            Banner(text: "안녕하세요\n환자 정보를 입력해주세요.") {
                HStack(spacing: 24) {
                    HStack(spacing: 4) {
                        Image(.Icons.locationOn)
                        
                        Text(viewModel.location)
                            .fontModifier(.Body, .Grayscale._30)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        viewModel.getLocation()
                    }) {
                        Typography(text: "새로고침", color: .Colors.greenDarker, fontType: .Body)
                            .underline()
                    }
                }
                
                ScrollView {
                    VStack(spacing: 0) {
                        if viewModel.step >= 4 {
                            Input(text: $viewModel.symptoms, isError: $viewModel.isSymptomsError, label: "환자 증상", placholder: "환자 증상을 입력해주세요")
                        }

                        if viewModel.step >= 3 {
                            Input(text: $viewModel.KTAS, isError: $viewModel.isKTASError, label: "KTAS", placholder: "AAAAA10")
                        }
                        
                        if viewModel.step >= 2 {
                            CheckList(selected: $viewModel.emergency, options: ["일반", "코호트 격리", "음압격리", "일반격리", "외상소생실", "소아", "소아음압격리", "소아일반격리"], label: "응급실 종류")
                        }
                        
                        if viewModel.step >= 1 {
                            Dropdown(text: $viewModel.gender, options: ["남자","여자","알 수 없음"], label: "환자 성별", placeholder: "성별을 선택해주세요", action: {viewModel.nextStep()})
                        }
                        
                        Input(text: $viewModel.age, isError: $viewModel.isAgeError, label: "환자 추정 나이", placholder: "나이를 입력해주세요", action: {viewModel.nextStep()})
                    }
                }
                
                BasicButton(label: "다음", action: {
                    viewModel.nextStep()
                }, icon: .Icons.arrowForward)
            }
        }.onAppear {
            viewModel.getLocation()
        }.transparentFullScreenCover(isPresented: $viewModel.isModalPresented) {
            GeometryReader { geometry in
                Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack {
                        VStack(spacing: 0) {
                            Typography(text: "환자 정보를 확인해주세요.", color: .Grayscale._10, fontType: .Title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)

                            VStack (spacing: 8) {
                                HStack {
                                    Typography(text: "환자 추정 나이", color: .Grayscale._20, fontType: .Body)
                                    Spacer()
                                    Typography(text: viewModel.age + "세", color: .Grayscale._10, fontType: .HeadLine)
                                }.frame(maxWidth: .infinity)
                                
                                HStack {
                                    Typography(text: "환자 성별", color: .Grayscale._20, fontType: .Body)
                                    Spacer()
                                    Typography(text: viewModel.gender, color: .Grayscale._10, fontType: .HeadLine)
                                }.frame(maxWidth: .infinity)
                                
                                HStack {
                                    Typography(text: "응급실 종류", color: .Grayscale._20, fontType: .Body)
                                    Spacer()
                                    Typography(text: viewModel.emergency.count > 2 ? "\(viewModel.emergency.prefix(2).joined(separator: ",")) 외 \(viewModel.emergency.count - 2)": viewModel.emergency.joined(separator: ","), color: .Grayscale._10, fontType: .HeadLine)
                                }.frame(maxWidth: .infinity)
                                
                                HStack {
                                    Typography(text: "KTAS", color: .Grayscale._20, fontType: .Body)
                                    Spacer()
                                    Typography(text: viewModel.KTAS, color: .Grayscale._10, fontType: .HeadLine)
                                }.frame(maxWidth: .infinity)
                            }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            
                            HStack(spacing: 8) {
                                BasicButton(label: "아니요", variant: .Secondary, action: {viewModel.closeModal()})
                                
                                BasicButton(label: "네, 맞아요") {
                                    viewModel.fetchHospital()
                                    viewModel.isModalPresented = false
                                }
                                navigationDestination(isPresented: $viewModel.isHospitalViewActive) {
                                    HospitalView()
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                        .padding(.vertical, 8)
                        .background(Color.Grayscale._70)
                        .cornerRadius(12)
                        .onTapGesture() {}
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .background(Color.black.opacity(0.2))
                .onTapGesture { viewModel.closeModal() }
            }
        }
        .transaction({ transaction in
            transaction.disablesAnimations = true
            
        })
    }
}

#Preview {
    PatientView()
}
