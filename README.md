# 🚀 SpaceX Launch Explorer - Flutter App

A Flutter application to explore SpaceX launches, rockets, and launch details using **GraphQL API**, **GetX**, and **flutter_map**. It is optimized for performance, offline support, and interactive exploration.

---

## 📱 Features

- 🔭 Launch Explorer with infinite pagination
- 🚀 Rocket Catalog with details
- 🔍 Search & Filter (Year, Rocket, Success/Failure)
- 📍 Launch Detail Screen with interactive map
- 📅 Countdown Timer for upcoming launches
- 📶 Offline cache-first GraphQL query support
- 🎯 Bottom Navigation for seamless screen switching
- ✅ Full UI built using `GetX` (no Riverpod)
- 🌐 API powered by `graphql_flutter` package
- 🗺️ Map built using `flutter_map` with static lat/lng

---

## 🛠️ Tech Stack

| Area         | Tool / Library             |
|--------------|----------------------------|
| State Mgmt   | GetX                       |
| Flutter SDK  | Version 3.32.1             |
| HTTP Client  | graphql_flutter            |
| UI           | Flutter                    |
| Offline Mode | Hive (via GraphQL cache)   |
| Map          | flutter_map + OpenStreetMap|
| Date Utils   | intl                       |

---

## 🧩 Functional Overview

### 1. Launch Explorer
- Displays all past launches with pagination
- Loads next records on scroll
- Uses `cacheFirst` fetch policy to enable offline access

### 2. Rocket Catalog
- Lists all SpaceX rockets with description, success rate, height, mass, and diameter
- Displayed in a card format with proper formatting

### 3. Launch Details
- Shows:
    - Mission name
    - Launch date
    - Success/failure
    - Rocket name
    - Launch patch image
    - Map showing launch site location using `flutter_map`

### 4. Search & Filter
- User can apply:
    - Launch Year (extracted from UTC)
    - Rocket Name
    - Launch Success (true/false)
- Supports single or multi-filter
- Filters are client-side due to GraphQL limitations (see below)

### 5. Bonus Feature: Countdown Timer
- Dynamically shows T-minus timer for next upcoming launch
- Auto-updates every second
- Built using `Timer.periodic`

---

## ❗ Challenges & Limitations

### 🚫 Missing GraphQL Parameters

1. **Images Not Available**
    - Parameter: `flickr_images`
    - ❌ Not supported in current SpaceX GraphQL API
    - ✅ Workaround: Use `mission_patch` for launch thumbnails

2. **Launchpad Location**
    - GraphQL query field `launchpad` ❌ not supported
    - ✅ Used fixed coordinates manually for map preview

3. **Rocket Image**
    - No image parameter available in rocket schema
    - ✅ Used hardcoded image or icon fallback

### ⚠️ Filtering Limitations

- Server-side filtering is limited to predefined parameters.
- GraphQL throws validation errors like:

- Many variables like `rocketName`, `year`, `launchpad` are not used or allowed in the SpaceX GraphQL schema.
- ✅ Solution: Applied client-side filtering **after fetching paginated data**

### 📡 Pagination + Filter Conflict

- When applying filters on paginated list:
- Only visible page is filtered
- Next page loads unfiltered data again
- ✅ Temporary fix: Reset pagination on filter change
- ⚠️ Limitation: Full dataset not available for perfect filter

---

## ✅ How Offline Mode Works

- Integrated `Hive` using `initHiveForFlutter()` for GraphQL cache
- Fetch policy: `FetchPolicy.cacheFirst` to prioritize cache over network
- ✅ Ensures app shows last data even without internet

---

## 🧪 Testing Strategy

- Unit test for filter logic
- Widget test for UI rendering (RocketCard)
- ✅ Bonus tested: Countdown timer accuracy

---

## 🧾 Final Summary

| Module             | Status       |
|--------------------|--------------|
| Launch Explorer     | ✅ Complete |
| Rocket Catalog      | ✅ Complete |
| Launch Details      | ✅ Complete |
| Map Integration     | ✅ Complete |
| Search + Filter     | ✅ Done (client-side only) |
| Countdown Timer     | ✅ Complete |
| Offline Mode        | ✅ Enabled |
| Bonus Features      | ✅ 1/1 done |
| Testing             | ✅ Added |
| GraphQL Issues      | ⚠️ Handled gracefully |

---

## 🚀 How to Run

```bash
flutter SDK 3.32.1 version
flutter pub get
flutter run

🔗 API
Using SpaceX GraphQL API

🧠 Author
Developed by Rohit Mishra, Senior Flutter Developer.