import WidgetKit
import SwiftUI
import Foundation

func isCurtisHallOpenNow(currentDate:Date) -> Bool {
    let currentDay = Calendar.current.component(.weekday, from: currentDate)
    let currentTime = Calendar.current.component(.hour, from: currentDate) * 60 + Calendar.current.component(.minute, from: currentDate)
    switch currentDay {
    case 1: // Sunday
        if (7*60+55...14*60+25).contains(currentTime) || (16*60+25...19*60+55).contains(currentTime) {
            return true
        }
    case 2...6: // Week
        if (7*60+25...10*60+25).contains(currentTime) || (10*60+55...14*60+25).contains(currentTime) || (16*60+25...19*60+55).contains(currentTime) {
            return true
        }
    case 7: // Saturday
        if (7*60+55...14*60+25).contains(currentTime) || (16*60+25...18*60+55).contains(currentTime) {
            return true
        }

    default:
        return false
    }

    return false
}

func isHuffmanHallOpenNow(currentDate:Date) -> Bool {
    let currentDay = Calendar.current.component(.weekday, from: currentDate) //getting day Sun=1 .... Sat=7
    let currentTime = Calendar.current.component(.hour, from: currentDate) * 60 + Calendar.current.component(.minute, from: currentDate) //make time into minutes ex)12:30 -> 12*60+30 = 750
    switch currentDay {
    case 1: // Sunday
        if (7*60+55...14*60+25).contains(currentTime) || (16*60+55...20*60+55).contains(currentTime) {
            return true
        }
    case 2...5: // Monday, Tuesday, Wednesday, Thursday
        if (7*60+25...10*60+25).contains(currentTime) || (11*60+25...13*60+55).contains(currentTime) || (16*60+55...20*60+55).contains(currentTime) {
            return true
        }
    case 6: // Friday
        if (7*60+25...10*60+25).contains(currentTime) || (11*60+25...13*60+55).contains(currentTime) || (16*60+55...19*60+55).contains(currentTime) {
            return true
        }
    case 7: // Saturday
        if (7*60+55...14*60+25).contains(currentTime) || (16*60+55...19*60+25).contains(currentTime) {
            return true
        }
    default:
        return false
    }

    return false
}


func isSlayterOpenNow(currentDate:Date) -> Bool {
    let currentDay = Calendar.current.component(.weekday, from: currentDate)
    let currentTime = Calendar.current.component(.hour, from: currentDate) * 60 + Calendar.current.component(.minute, from: currentDate)
    switch currentDay {
    case 1: // Sunday
        if (11*60+55...21*60+55).contains(currentTime){
            return true
        }
    case 2...6: // Week
        if (6*60+55...10*60+25).contains(currentTime) || (11*60+00...21*60+55).contains(currentTime) {
            return true
        }
    case 7: // Saturday
        if (11*60+55...21*60+55).contains(currentTime) {
            return true
        }
    default:
        return false
    }

    return false
}
func getDateString(currentDate:Date)-> Text{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    let dateString = dateFormatter.string(from: currentDate)
    return Text(dateString)
}
struct dininghallEntry: TimelineEntry {
    let date: Date
    let statusH: Bool //Huffman Status
    let statusC: Bool //Curtis Status
    let statusS: Bool //Slayter Status
}
struct dininghallProvider: TimelineProvider {
    func placeholder(in context: Context) -> dininghallEntry {
        let currentDate = Date() //Get current date
        let statusH = isHuffmanHallOpenNow(currentDate:currentDate)
        let statusC = isCurtisHallOpenNow(currentDate:currentDate)
        let statusS = isSlayterOpenNow(currentDate:currentDate)
        return dininghallEntry(date: currentDate, statusH: statusH,statusC: statusC,statusS: statusS)
    }

    func getSnapshot(in context: Context, completion: @escaping (dininghallEntry) -> ()) {
        let currentDate = Date()
        let statusH = isHuffmanHallOpenNow(currentDate:currentDate)
        let statusC = isCurtisHallOpenNow(currentDate:currentDate)
        let statusS = isSlayterOpenNow(currentDate:currentDate)
        let entry = dininghallEntry(date: currentDate, statusH: statusH,statusC: statusC,statusS: statusS)
        completion(entry)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<dininghallEntry>) -> Void) {
        var entries: [dininghallEntry] = []

        let currentDate = Date()
        let nextRefreshTime = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let statusH = isHuffmanHallOpenNow(currentDate:currentDate)
        let statusC = isCurtisHallOpenNow(currentDate:currentDate)
        let statusS = isSlayterOpenNow(currentDate:currentDate)
        entries.append(dininghallEntry(date: currentDate, statusH: statusH,statusC: statusC,statusS: statusS))
        //refresh the widget every 1 minute
        let timeline = Timeline(entries: entries, policy: .after(nextRefreshTime))
        completion(timeline)
        }
    }


struct dininghall: Widget {
    let kind: String = "Denison Dining"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: dininghallProvider()) { entry in
            dininghallView(entry: entry)
        }
        .configurationDisplayName("Denison Dining Hall Status Widget")
        .description("Check if the dining hall is open.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
    }
}

struct dininghallView: View {
    let entry: dininghallEntry
    @Environment(\.colorScheme) var colorScheme
    //Colors for dark mode
    var fontColor: Color {
        colorScheme == .dark ? .white : .black
    }
    var Back : Color {
        colorScheme == .dark ? .black : .white
    }
    let image = Image("applogo")
    
    var body: some View {
        let currentDate = Date()
        ZStack(alignment: .center){
                HStack{
                    VStack(alignment: .leading,spacing:10){
                        Spacer()
                        HStack{
                            VStack(alignment: .leading){
                                image.resizable().frame(maxWidth: 40, maxHeight: 50)
                            }.padding(-10)
                            Spacer().frame(width: 25)
                            VStack(alignment: .leading){
                                Text("Today")
                                  .font(.system(size: 17)
                                      .weight(.bold)).foregroundColor(fontColor)
                                getDateString(currentDate: currentDate)
                                  .font(.system(size: 12))
                                  .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                            }
                        }
                        Spacer().frame(height: 1)
                        VStack(alignment: .leading, spacing:6){
                            HStack{
                                Spacer().frame(width: 15)
                                if entry.statusC == true {
                                    Circle().frame(width: 15, height: 15).foregroundColor(Color.green)
                                } else {
                                    Circle().frame(width: 15, height: 15).foregroundColor(Color.red)
                                }
                                Spacer().frame(width: 15)
                                Text("Curtis")
                                    .font(.system(size: 14))
                                  .foregroundColor(fontColor)
                            }
                            HStack{
                                Spacer().frame(width: 15)
                                if entry.statusH == true {
                                    Circle().frame(width: 15, height: 15).foregroundColor(Color.green)
                                } else {
                                    Circle().frame(width: 15, height: 15).foregroundColor(Color.red)
                                }
                                Spacer().frame(width: 15)
                                Text("Huffman")
                                    .font(.system(size: 14))
                                  .foregroundColor(fontColor)
                            }
                            HStack{
                                Spacer().frame(width: 15)
                                if entry.statusS == true {
                                    Circle().frame(width: 15, height: 15).foregroundColor(Color.green)
                                } else {
                                    Circle().frame(width: 15, height: 15).foregroundColor(Color.red)
                                }
                                Spacer().frame(width: 15)
                                Text("Slayter")
                                    .font(.system(size: 14))
                                  .foregroundColor(fontColor)
                            }
                        }
                        Spacer()
                    }.padding(-15).frame(minWidth: 70)
                }
        }.frame(width: 155, height: 155)
            .cornerRadius(21.67).widgetBackground(Back)
    }
}
//This is for iOS 17 containerBackground API and to make it work below iOS17.
extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        let currentDate = Date()
        Group {
            dininghallView(entry: dininghallEntry(date: currentDate, statusH: isHuffmanHallOpenNow(currentDate:currentDate),statusC: isCurtisHallOpenNow(currentDate:currentDate),statusS: isSlayterOpenNow(currentDate:currentDate)))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
