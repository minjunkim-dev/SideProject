    
struct TheaterLocation {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
    
    init(type: String, location: String, latitude: Double, longitude: Double) {
        self.type = type
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
}

var theaterLocation: [TheaterLocation] = [
    TheaterLocation(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
    TheaterLocation(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
    TheaterLocation(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
    TheaterLocation(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
    TheaterLocation(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
    TheaterLocation(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
]

enum TheaterType: String {
    case megabox = "메가박스"
    case lottecinema = "롯데시네마"
    case cgv = "CGV"
    case all = "전체"
}
