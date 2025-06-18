# Premier League Teams Flutter App

A beautiful Flutter application that displays Premier League teams using the Football-Data.org API. Features team listings, detailed views, favorites management, and modern Material 3 design.

## 🏆 Features

### ✅ **Teams List Screen**
- **Grid/List View Toggle**: Switch between grid and list layouts
- **Search & Filter**: Real-time search by team name or short name  
- **Sorting**: Sort teams alphabetically (A-Z, Z-A)
- **Team Cards**: Display team crest, name, matches played, and favorite status
- **Navigation**: Tap teams to view detailed information

### ✅ **Team Detail Screen**
- **Hero Header**: Beautiful gradient header with team crest
- **Team Information**: Name, venue, founded year, club colors, website
- **Upcoming Matches**: Shows fixture details with opponent crests
- **Favorite Toggle**: Add/remove teams from favorites
- **Material 3 Design**: Modern cards and responsive layout

### ✅ **Favorites Screen**
- **Favorites Collection**: View all saved favorite teams
- **Quick Navigation**: Tap to view team details
- **Bulk Actions**: Clear all favorites with confirmation dialog
- **Empty State**: Helpful guidance when no favorites exist

### ✅ **Additional Features**
- **Persistent Storage**: Favorites saved locally using Drift database
- **Error Handling**: Comprehensive error states with retry options
- **Loading States**: Beautiful loading indicators throughout
- **Rate Limiting**: Respects API rate limits (10 requests/minute)
- **Attribution**: Required API attribution displayed

## 🏗️ Architecture

### **Clean Architecture with MVVM Pattern**
- **Data Layer**: Models, API service, local database
- **Presentation Layer**: Screens, widgets, state management
- **State Management**: Riverpod with providers and notifiers

### **Key Technologies**
- **Flutter**: Cross-platform mobile framework
- **Riverpod**: Robust state management with code generation
- **Drift**: Type-safe local database (SQLite)
- **Go Router**: Declarative navigation
- **Cached Network Image**: Efficient image loading and caching
- **Material 3**: Modern design system

### **Project Structure**
```
lib/
├── database/           # Local database (Drift)
├── models/            # Data models with JSON serialization
├── providers/         # Riverpod providers and state management
├── screens/           # Main UI screens
├── services/          # API service layer
└── widgets/           # Reusable UI components
```

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK 3.24.5 or later
- Dart SDK 3.5.4 or later
- Android Studio/VS Code with Flutter extensions

### **Installation**

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd football_api_test
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### **API Configuration**
The app uses the Football-Data.org API with the key: `7d6d02ad9fdf4f4bb24e1b89dcd1efc2`

**Free Tier Limitations:**
- 10 requests per minute
- Premier League data only
- Some features may be limited

## 🧪 Testing

### **Run Unit Tests**
```bash
flutter test
```

### **Run Analysis**
```bash
flutter analyze
```

### **Format Code**
```bash
dart format --set-exit-if-changed .
```

**Test Coverage:**
- ✅ 21 unit tests covering providers and state management
- ✅ Widget tests for main app functionality
- ✅ Mock implementations for API and database

## 📱 Screenshots

### Teams List (Grid View)
- Beautiful grid layout with team crests
- Search bar and sorting options
- Material 3 cards with elevation

### Teams List (List View)  
- Detailed list layout with team information
- Matches played counter
- Favorite toggle buttons

### Team Detail
- Hero header with gradient background
- Comprehensive team information
- Upcoming matches with opponent details

### Favorites
- Clean favorites collection
- Empty state guidance
- Bulk actions for management

## 🔧 Development

### **Adding New Features**
1. Create models in `lib/models/`
2. Add providers in `lib/providers/`
3. Implement UI in `lib/screens/` or `lib/widgets/`
4. Write unit tests in `test/`
5. Run code generation: `dart run build_runner build`

### **Code Style**
- Follows **Effective Dart** guidelines
- Uses **null-safety** throughout
- **Material 3** design principles
- **Riverpod** for state management patterns

### **Database Schema**
```sql
CREATE TABLE favorite_teams (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  short_name TEXT NOT NULL,
  tla TEXT NOT NULL,
  crest TEXT NOT NULL,
  venue TEXT,
  founded INTEGER,
  club_colors TEXT,
  added_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

## 📊 API Integration

### **Endpoints Used**
- `GET /competitions/PL/teams` - Premier League teams
- `GET /teams/{id}` - Individual team details  
- `GET /teams/{id}/matches` - Team matches

### **Error Handling**
- Network connectivity issues
- API rate limiting (429 status)
- Invalid responses
- Timeout handling

## 🎯 Future Enhancements

### **Planned Features**
- [ ] Team squad and player details
- [ ] Match result history with scores
- [ ] League standings and statistics
- [ ] Push notifications for favorite team matches
- [ ] Dark/Light theme toggle
- [ ] Multiple league support
- [ ] Offline mode with cached data

### **Technical Improvements**
- [ ] Integration tests
- [ ] Performance optimizations
- [ ] Accessibility improvements
- [ ] CI/CD pipeline setup

## 📄 License

This project is for educational purposes. Football data provided by [Football-Data.org](https://www.football-data.org/).

## 🙋‍♂️ Support

For questions or issues:
1. Check the existing unit tests for examples
2. Review the provider implementations
3. Consult the Football-Data.org API documentation

---

**Built with ❤️ using Flutter and Material 3**
