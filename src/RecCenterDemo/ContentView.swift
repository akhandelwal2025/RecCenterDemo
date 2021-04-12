//
//  ContentView.swift
//  RecCenterDemo
//
//  Created by Ankit Khandelwal on 2/19/21.
//

import SwiftUI

func populateDates(date:DateComponents) -> Array<individualDate>{
    let monthArray:Array<String> = ["January","February", "March","April","May","June","July","August","September","October","November","December"]
    var byWeek:Array<Array<Int>> = [[]]
    var isButtonArray:Array<Bool> = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    let currentDay:Int = date.day!
    let currentWeekDay:Int = date.weekday!
    let currentMonth:Int = date.month!
    let currentYear:Int = date.year!
    let daysInMonth:Int = getDaysInMonth(month:monthArray[currentMonth], year:currentYear)
    //print("Current Day:" + String(currentDay))
    //print("Current Week Day:" + String(currentWeekDay))
    //print("Current Month:" + String(currentMonth))
    //print("Current Year:" + String(currentYear))
    var currentWeekIndex:Int = 0
    let _:Int = currentDay%7
    if currentDay%7 <= currentWeekDay{
        currentWeekIndex = currentDay/7
    }
    else{
        currentWeekIndex = currentDay/7 + 1
    }
    var weeksInMonth:Int = currentWeekIndex
    print("weeksInMonth: " + String(weeksInMonth))
    print("currentDay: " + String(currentDay))
    print("currentWeekDay: " + String(currentWeekDay))
    if currentWeekDay==0 && daysInMonth > 28{
        weeksInMonth = 5
    }
    else if ((daysInMonth - currentDay)%7)+currentWeekDay > 6{
        print("here")
        weeksInMonth += (daysInMonth-currentDay)/7 + 2
    }
    else{
        print("there")
        weeksInMonth += (daysInMonth-currentDay)/7 + 1
    }
    print(weeksInMonth)

    if weeksInMonth == 5{
        byWeek = [[69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69]]
    }
    else if weeksInMonth == 6{
        byWeek = [[69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69]]
    }
    else{
        byWeek = [[69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69], [69,69,69,69,69,69,69]]
    }
    byWeek[currentWeekIndex][currentWeekDay] = currentDay
    isButtonArray[currentWeekIndex*7+currentWeekDay] = true
    var loopWeekIndex = currentWeekIndex
    var loopDayIndex = currentWeekDay
    for num in (1..<currentDay).reversed(){
        loopDayIndex -= 1
        if loopDayIndex < 0{
            loopDayIndex = 6
            loopWeekIndex -= 1
        }
        isButtonArray[loopWeekIndex*7+loopDayIndex] = true
        byWeek[loopWeekIndex][loopDayIndex] = num
    }
    loopWeekIndex = currentWeekIndex
    loopDayIndex = currentWeekDay
    if currentDay < daysInMonth{
        for num in (currentDay+1...daysInMonth){
            loopDayIndex += 1
            if loopDayIndex > 6{
                loopDayIndex = 0
                loopWeekIndex += 1
            }
            isButtonArray[loopWeekIndex*7+loopDayIndex] = true
            byWeek[loopWeekIndex][loopDayIndex] = num
        }

    }

    var inOneArray:Array<Int> = []
    for i in 0..<weeksInMonth{
        inOneArray.append(contentsOf: byWeek[i])
    }
    
    var toReturn:Array<individualDate> = []
    for (idx, num) in inOneArray.enumerated(){
        if num == 69{
            toReturn.append(individualDate(dateString: "", isButton: isButtonArray[idx]))
        }
        else{
            let toAdd:individualDate = individualDate(dateString: String(num), isButton: isButtonArray[idx])
            toReturn.append(toAdd)
        }
        
    }
    return toReturn
}
func getDaysInMonth(month:String, year:Int=0) -> Int{
    let normalMonths:[String:Int] = [
        "January":31,
        "March":31,
        "April":30,
        "May":31,
        "June":30,
        "July":31,
        "August":31,
        "September":30,
        "October":31,
        "November":30,
        "December":31]
    if month=="February"{
        if year%4 == 0{
            return 29
        }
        else{
            return 28
        }
    }
    else{
        return normalMonths[month]!
    }
}
func getProperMonthIndex(monthIndex:Int, numForward:Int) -> Int{
    var toReturn:Int = (monthIndex+numForward)%12
    if toReturn < 0{
        toReturn = 11
    }
    return toReturn
}
func calculateWeekday(dateToCalc:DateComponents, dateStart:DateComponents, calcGreater:Bool) -> Int{
    let monthArray:Array<String> = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    if calcGreater{
        let diffInDays = getDaysInMonth(month:monthArray[dateStart.month!], year:dateStart.year!) - dateStart.day! + 1
        return (dateStart.weekday!+diffInDays)%7
    }
    else{
        let diffInDays = dateStart.day!
        let toReturn = countBackwards(weekday: dateStart.weekday!, diffInDays: diffInDays)
        return toReturn
    }
    
    
}
func countBackwards(weekday:Int, diffInDays:Int) -> Int{
    var toReturn:Int = weekday
    for _ in 0..<diffInDays{
        if toReturn == 0{
            toReturn = 6
        }
        else{
            toReturn -= 1
        }
    }
    return toReturn
}

func printStuff() -> Int{
    return 1
}

struct ContentView: View {
    @EnvironmentObject var helper:Helper
    @State var activityChosen:String = ""
    var dictActivities:[String:Array<String>] = [
        "Reservation Times":["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        "Classes":["Zumba", "Water Aerobics", "Fitness"],
        "Sports":["Basketball", "Volleyball", "Spikeball", "Rock Climbing"]
    ]
    let screenWidth:Double = Double(UIScreen.main.bounds.size.width)
    let screenHeight:Double = Double(UIScreen.main.bounds.size.height)
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    List{
                        ForEach(Array(dictActivities.keys), id: \.self){ key in
                            Section(header:Text(key)){
                                ForEach(dictActivities[key]!, id:\.self){activity in
                                    Button(activity){
                                        withAnimation(.linear(duration: 0.5)){
                                            helper.viewShown.toggle()
                                            helper.activityChosen = activity
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if helper.viewShown{
                CalendarView(sW: self.screenWidth, sH: self.screenHeight)
            }
            
        }
        
    }
              
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalendarView: View {
    @EnvironmentObject var helper:Helper
    let monthArray:Array<String> = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    var screenWidth:Double
    var screenHeight:Double
    var min:Int
    var letters:Array<String>
    var months:Array<String>
    @State var date:DateComponents = DateComponents(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date())-1, day: Calendar.current.component(.day, from: Date()), weekday: Calendar.current.component(.weekday, from: Date())-1)
    @State var monthIndex:Int = Calendar.current.component(.month, from: Date())-1
    @State var data:Array<individualDate> = populateDates(date: DateComponents(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date())-1, day: Calendar.current.component(.day, from: Date()), weekday: Calendar.current.component(.weekday, from: Date())-1))
    init (sW:Double, sH:Double){
        self.screenWidth = sW
        self.screenHeight = sH
        self.min = 50
        self.letters = ["S", "M", "T", "W", "T", "F", "S"]
        self.months =  ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        print(self.data)
    }
    
    var body: some View {
            let columns = [GridItem(.fixed(CGFloat(0.7*self.screenWidth/9))),
                           GridItem(.fixed(CGFloat(0.7*self.screenWidth/9))),
                           GridItem(.fixed(CGFloat(0.7*self.screenWidth/9))),
                           GridItem(.fixed(CGFloat(0.7*self.screenWidth/9))),
                           GridItem(.fixed(CGFloat(0.7*self.screenWidth/9))),
                           GridItem(.fixed(CGFloat(0.7*self.screenWidth/9))),
                           GridItem(.fixed(CGFloat(0.7*self.screenWidth/9)))]
            ZStack{
                RoundedRectangle(cornerRadius:25, style: .continuous)
                    .fill(Color.white)
                    .frame(width:0.92*CGFloat(self.screenWidth), height:0.92*CGFloat(self.screenHeight))
                
                VStack{
                    Text(String(date.year!))
                        .padding(.vertical)
                        //.padding(.top, 20)
                        .font(.system(.largeTitle))
                        .frame(width:CGFloat(0.9*self.screenWidth*6.5/9), height:0.06*CGFloat(self.screenHeight), alignment:.topLeading)
                    HStack{
                        Spacer()
                        Button(action:{
                            self.monthIndex = getProperMonthIndex(monthIndex: self.monthIndex, numForward:-1)
                            let monthDays:Int = getDaysInMonth(month: self.monthArray[monthIndex], year:self.date.year!)
                            var yearNum:Int = self.date.year!
                            if monthIndex == 11{
                                yearNum -= 1
                            }
                            let tempDate:DateComponents = DateComponents(year: yearNum, month: monthIndex, day: monthDays)
                            let newWeekDay:Int = calculateWeekday(dateToCalc:tempDate, dateStart:self.date, calcGreater:false)
                            self.date = DateComponents(year: yearNum, month: monthIndex, day: monthDays, weekday: newWeekDay)
                            self.data = populateDates(date: self.date)
                        }) {
                            Text(self.months[getProperMonthIndex(monthIndex: self.monthIndex, numForward:-1)])
                                .fontWeight(.bold)
                        }
                        .frame(width:CGFloat(0.35*self.screenWidth/4), height:0.05*CGFloat(self.screenHeight))
                        .padding()
                        Spacer()
                        Button(action:{
                            self.monthIndex = getProperMonthIndex(monthIndex: self.monthIndex, numForward:0)
                        }) {
                            Text(self.months[getProperMonthIndex(monthIndex: self.monthIndex, numForward:0)])
                                .underline()
                                .fontWeight(.bold)
                        }
                        .frame(width:CGFloat(0.35*self.screenWidth/4), height:0.05*CGFloat(self.screenHeight))
                        .padding()
                        Spacer()
                        Button(action:{
                            self.monthIndex = getProperMonthIndex(monthIndex: self.monthIndex, numForward:1)
                            print("Month Index: " + String(self.monthIndex))
                            let monthDays:Int = getDaysInMonth(month: self.monthArray[monthIndex], year:self.date.year!)
                            var yearNum:Int = self.date.year!
                            if monthIndex == 0{
                                yearNum += 1
                            }
                            let tempDate:DateComponents = DateComponents(year: yearNum, month: monthIndex, day: monthDays)
                            let newWeekDay:Int = calculateWeekday(dateToCalc:tempDate, dateStart:self.date, calcGreater:true)
                            self.date = DateComponents(year: yearNum, month: monthIndex, day: 1, weekday: newWeekDay)
                            self.data = populateDates(date: self.date)
                        }) {
                            Text(self.months[getProperMonthIndex(monthIndex: self.monthIndex, numForward:1)])
                                .fontWeight(.bold)
                        }
                        .frame(width:CGFloat(0.35*self.screenWidth/4), height:0.05*CGFloat(self.screenHeight))
                        .padding()
                        Spacer()
                        Button(action:{
                            self.monthIndex = getProperMonthIndex(monthIndex: self.monthIndex, numForward:2)
                            let monthDays:Int = getDaysInMonth(month: self.monthArray[monthIndex], year:self.date.year!)
                            var yearNum:Int = self.date.year!
                            if monthIndex == 0 || monthIndex == 1{
                                yearNum += 1
                            }
                            let tempDate:DateComponents = DateComponents(year: yearNum, month: monthIndex, day: monthDays)
                            let newWeekDay:Int = calculateWeekday(dateToCalc:tempDate, dateStart:self.date, calcGreater:true)
                            self.date = DateComponents(year: yearNum, month: monthIndex, day: 1, weekday: newWeekDay)
                            self.data = populateDates(date: self.date)
                        }) {
                            Text(self.months[getProperMonthIndex(monthIndex: self.monthIndex, numForward:2)])
                                .fontWeight(.bold)
                        }
                        .frame(width:CGFloat(0.35*self.screenWidth/4), height:0.05*CGFloat(self.screenHeight))
                        .padding()
                        Spacer()
                    }.frame(width:CGFloat(0.9*self.screenWidth/9), height:0.05*CGFloat(self.screenHeight))
                    
                    LazyVGrid(columns: columns, spacing: 5, pinnedViews: [.sectionHeaders]){
                        Text("S")
                            .fontWeight(.bold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        Text("M")
                            .fontWeight(.semibold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        Text("T")
                            .fontWeight(.semibold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        Text("W")
                            .fontWeight(.semibold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        Text("T")
                            .fontWeight(.semibold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        Text("F")
                            .fontWeight(.semibold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        Text("S")
                            .fontWeight(.semibold)
                            .frame(width:CGFloat(self.screenWidth)/9, height:20)
                            .padding(.horizontal)
                        ForEach(self.data, id:\.id) {item in
                            if item.isButton{
                                Button(action:{
                                    print(item.dateString)
                                }) {
                                    Text(item.dateString)
                                        .fontWeight(.light)
                                        .frame(width:CGFloat(self.screenWidth)/9, height:20)
                                        .padding(.all)
                                        .foregroundColor(Color.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            else{
                                Text(item.dateString)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.gray)
                                    .frame(width:CGFloat(self.screenWidth)/9, height:20)
                                    .padding(.all)
                            }
                            
                        }.padding(.horizontal)
                        .frame(width:CGFloat((0.9*self.screenWidth)/9), height:0.05*CGFloat(self.screenHeight))
                    
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius:25, style: .continuous)
                            .fill(Color.blue)
                        VStack{
                            var lol:Array<Int> = [1]
                            var times:Array<Int> = [5,4,6,7,8,9]
                            Text(helper.activityChosen)
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                            List{
                                ForEach(lol, id:\.self){num in
                                    Section(header:Text("Times")){
                                        ForEach(times, id:\.self){time in
                                            var buttonString:String = String(time) + ":00 - " + String(time+1) + ":00"
                                            Button(String(buttonString)){
                                                print(time)
                                            }
                                        }
                                    }
                                }

                            }
                            .padding(.horizontal)
                            .frame(width:CGFloat((0.9*self.screenWidth)), height:0.3*CGFloat(self.screenHeight))

                            Button(action:{
                                withAnimation{
                                    helper.viewShown.toggle()
                                }
                                
                            }) {
                                Image(systemName:"xmark").resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                            .padding()
                        }
                        
                    }
                    
                    
                }
                
            }.frame(width:CGFloat(0.9*Double(self.screenWidth)), height: CGFloat(0.8*Double(screenHeight)))
            
            
        }
}

struct individualDate{
    let id = UUID()
    let dateString:String
    let isButton:Bool
}
struct PopUpWindow: View{
    var screenWidth:Int
    var screenHeight:Int
    var activity:String
    var strToPrint:String
    var dictActivities:[String:Array<String>]
    @State var date:Date = Date()
    @State var viewShown:Bool = false
    @EnvironmentObject var helper:Helper
    
    var body: some View{
        let activityTimes:[String:Array<Int>] = generateTimes()
        ZStack{
            RoundedRectangle(cornerRadius:25, style: .continuous)
                .fill(Color.white)
                .frame(width:0.92*CGFloat(self.screenWidth), height:0.82*CGFloat(self.screenHeight))
                       
            VStack{
                HStack{
                    HStack(){
                        Button(action:{
                            withAnimation(.linear(duration: 0.5)){
                                helper.viewShown.toggle()
                            }
                            
                        }) {
                            Image(systemName: "arrow.turn.up.left")
                        }.padding()
                    }
                    
                    HStack{
                        Text(activity)
                            .fontWeight(.heavy)
                    }
                }
            
                DatePicker("Activity", selection: $date, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                List{
                    let applicableTimes:Array<Int> = activityTimes[activity]!
                    ForEach(applicableTimes, id:\.self){time in
                        Text(String(time))
                    }
                }
                    
                        
            }.background(Color.white)
            .frame(width:0.7*CGFloat(self.screenWidth), height:0.8*CGFloat(self.screenHeight))
        }
        
        
    }
    
    func generateTimes() -> [String:Array<Int>]{
        var toReturn:[String:Array<Int>] = [:]
        for category in dictActivities.keys{
            for activity in dictActivities[category]!{
                var times:Set<Int> = []
                for _ in 0..<Int.random(in: 1...12){
                    times.insert(Int.random(in: 1...12))
                }
                toReturn[activity] = Array(times)
            }
            
        }
        return toReturn
    }
}

