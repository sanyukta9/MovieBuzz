# MovieBuzz

A UIKit-based iOS app built on MVC/MVVM architecture, integrated with the TMDB API. Displays now-playing movies with details, reviews, cast, and similar movies.

---

## Features

- Now-playing movies from TMDB
- Movie detail screen — ratings, genres, synopsis
- Reviews, Cast, Similar Movies sections
- Search with Trie-based prefix matching
- Recently searched movies
- Protocol-delegate binding
- Implemented combine binding

---

## Screenshots

<table>
  <tr>
    <td align="center"><b>Movie List</b></td>
    <td align="center"><b>Movie Detail</b></td>
    <td align="center"><b>Cast & Similar</b></td>
  </tr>
  <tr>
    <td><img width="220" src="https://github.com/user-attachments/assets/8af022c9-99a1-4ab2-813d-6108eae948c1"/></td>
    <td><img width="220" src="https://github.com/user-attachments/assets/5d752e3f-2b5e-4bee-ae89-3253bfe3a946"/></td>
    <td><img width="220" src="https://github.com/user-attachments/assets/72afed9b-0aa2-440a-9dc0-555284ca7f0e"/></td>
  </tr>
</table>

---

## Tech Stack

- Swift · UIKit · XIBs
- TMDB REST API
- URLSession · JSONDecoder
- DispatchGroup · DispatchQueue

---

## Setup

1. Clone the repo
2. Open `MovieBuzz.xcodeproj`
3. Add your TMDB API key in `Constants.swift`
4. Run on simulator or device
