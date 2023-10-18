import WidgetKit
import SwiftUI

func isHuffmanHallOpenNow(currentDate:Date) -> Bool {
    let currentDay = Calendar.current.component(.weekday, from: currentDate) //getting day Sun=1 .... Sat=7
    let currentTime = Calendar.current.component(.hour, from: currentDate) * 60 + Calendar.current.component(.minute, from: currentDate) //make time into minutes ex)12:30 -> 12*60+30 = 750
    switch currentDay {
    case 1: // Sunday
        if (7*60+59...14*60+29).contains(currentTime) || (16*60+59...20*60+59).contains(currentTime) {
            return true
        }
    case 2...5: // Monday, Tuesday, Wednesday, Thursday
        if (7*60+29...10*60+29).contains(currentTime) || (11*60+29...13*60+59).contains(currentTime) || (16*60+59...20*60+59).contains(currentTime) {
            return true
        }
    case 6: // Friday
        if (7*60+29...10*60+29).contains(currentTime) || (11*60+29...13*60+59).contains(currentTime) || (16*60+59...19*60+59).contains(currentTime) {
            return true
        }
    case 7: // Saturday
        if (7*60+59...14*60+29).contains(currentTime) || (16*60+59...19*60+29).contains(currentTime) {
            return true
        }
    default:
        return false
    }

    return false
}

func isCurtisHallOpenNow(currentDate:Date) -> Bool {
    let currentDay = Calendar.current.component(.weekday, from: currentDate)
    let currentTime = Calendar.current.component(.hour, from: currentDate) * 60 + Calendar.current.component(.minute, from: currentDate)
    switch currentDay {
    case 1: // Sunday
        if (7*60+59...14*60+29).contains(currentTime) || (16*60+29...19*60+59).contains(currentTime) {
            return true
        }
    case 2...6: // Week
        if (7*60+29...10*60+29).contains(currentTime) || (10*60+59...14*60+29).contains(currentTime) || (16*60+29...19*60+59).contains(currentTime) {
            return true
        }
    case 7: // Saturday
        if (7*60+59...14*60+29).contains(currentTime) || (16*60+29...18*60+59).contains(currentTime) {
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
        if (11*60+59...21*60+59).contains(currentTime){
            return true
        }
    case 2...6: // Week
        if (6*60+59...10*60+29).contains(currentTime) || (11*60+04...21*60+59).contains(currentTime) {
            return true
        }
    case 7: // Saturday
        if (11*60+59...21*60+59).contains(currentTime) {
            return true
        }
    default:
        return false
    }

    return false
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
    var body: some View {
        ZStack {
            HStack{
                VStack(spacing:10){
                    if entry.statusH == true {
                        Circle().foregroundColor(Color.green)
                    } else {
                        Circle().foregroundColor(Color.red)
                    }
                    if entry.statusC == true {
                        Circle().foregroundColor(Color.green)
                    } else {
                        Circle().foregroundColor(Color.red)
                    }
                    if entry.statusS == true {
                        Circle().foregroundColor(Color.green)
                    } else {
                        Circle().foregroundColor(Color.red)
                    }
                }.frame(minWidth:50,maxWidth: 50, minHeight: 80, maxHeight:80)
                VStack(spacing:10){
                    Text("Huffman").foregroundStyle(fontColor)
                    Text("Curtis").foregroundStyle(fontColor)
                    Text("Slayter").foregroundStyle(fontColor)
                }.padding()
            }
        }.widgetBackground(Back)
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
