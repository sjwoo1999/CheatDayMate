import SwiftUI

struct HomeTabView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var chatGPTService: ChatGPTService
    @StateObject private var viewModel: HomeTabViewModel
    @StateObject private var tabBarViewModel = CustomTabBarViewModel()
    @StateObject private var dietRecordViewModel = DietRecordViewModel(apiKey: AppConfig.chatGPTAPIKey)
    @State private var showInputView = false
    @State private var blurRadius: CGFloat = 0
    
    init(authService: AuthService, chatGPTService: ChatGPTService) {
        _viewModel = StateObject(wrappedValue: HomeTabViewModel())
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(hex: "#ffeeae").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Top section
                    VStack(spacing: 10) {
                        
                        HStack {
                            
                            Button(action: { viewModel.addCalories(-10000) }) {
                                Text("-10,000 칼로리")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 15)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            Spacer()
                            Button(action: { viewModel.addCalories(10000) }) {
                                Text("+10,000 칼로리")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 15)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                            
                            /*
                            Button(action: { viewModel.addCalories(-10000) }) {
                                    Color.clear
                                }
                                .frame(width: 44, height: 44)  // 애플의 권장 최소 탭 영역
                                .contentShape(Rectangle())
                                
                                Spacer()
                                
                                Button(action: { viewModel.addCalories(10000) }) {
                                    Color.clear
                                }
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle())
                            */
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, geometry.safeAreaInsets.top + 10)
                         
                        
                        Text("오늘은? \(viewModel.formattedDate)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.orange)
                        
                        ProgressView(value: Double(viewModel.currentCalories), total: Double(viewModel.goalCalories))
                            .progressViewStyle(CalorieProgressStyle())
                            .frame(width: geometry.size.width * 0.85)
                    }
                    
                    Spacer()
                    
                    // Tab bar placeholder to maintain layout
                    Color.clear.frame(height: 60)
                }
                
                // Centered cat content
                GeometryReader { innerGeometry in
                    VStack(spacing: 10) {
                        Image(viewModel.catImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: innerGeometry.size.height * 0.35)
                        
                        Text(viewModel.catMessage)
                            .font(.system(size: 16))
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.orange, lineWidth: 2))
                    }
                    .frame(width: innerGeometry.size.width)
                    .position(x: innerGeometry.size.width / 2,
                              y: (innerGeometry.size.height - 60) / 2 + 60) // 60은 CustomTabBar의 예상 높이
                }
                
                // Tab bar
                VStack {
                    Spacer()
                    CustomTabBar(viewModel: tabBarViewModel, onPlusButtonTap: {
                        withAnimation(.spring()) {
                            showInputView = true
                            blurRadius = 10
                        }
                    })
                }
            }
            .blur(radius: blurRadius)
            
            // InputView
            if showInputView {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showInputView = false
                            blurRadius = 0
                        }
                    }
                
                InputView(isPresented: $showInputView, blurRadius: $blurRadius, dietRecordViewModel: dietRecordViewModel)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CalorieProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 30)
                    .foregroundColor(Color(hex: "#49406F").opacity(0.3))
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 30)
                    .foregroundColor(Color(hex: "#49406F"))
                
                HStack {
                    Spacer()
                    Text("\(Int((configuration.fractionCompleted ?? 0) * 150000)) / 150,000")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .padding(.trailing, 10)
                }
            }
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }
}
