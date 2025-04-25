# File-Content-Searcher

A portable Windows batch script for quickly finding files or text within folders.  
Recursively scans subdirectories, logs results to a “Util” folder on your Desktop, and offers a choice-driven interface.

---

## Features

- **Recursive search** through all subfolders  
- **Two modes**:
  1. Search **inside file contents** (line number + matching text)  
  2. Search **by filename**  
- **Continuous loop**: after each run, choose to:
  - 🔄 reuse the same folder  
  - 📂 select a new folder  
- **Plain-text logs** in `Util\search_content_log.txt` or `Util\search_filename_log.txt`

---

## Installation

No installation required—just download `Search_Tool.bat` and place it wherever you like.

---

## Usage

1. **Double-click** `Search_Tool.bat`.  
2. **Enter folder path** to scan.  
3. **Enter search term** (case-insensitive).  
4. **Choose search type**:
   - `1` — file **contents**  
   - `2` — **filenames**  
5. Review results in the log file on your Desktop.  
6. **When prompted**, press `1` to search again in the same folder or `2` to pick a new one.  

---

## Limitations

- There is **no file-type filter** currently, so results may include system, binary, or undesired files.
- Very large folders may produce large log files; consider narrowing your scope with filename search first.

---

## Changelog

### 0.1.3 (2025-04-25)
- Added continuous loop with “reuse folder” or “new folder” choice  
- Bumped version and updated header comments  

### 0.1.2 (2025-04-14)
- Fixed parsing of paths containing parentheses  
- Switched to `CHOICE` for search-type input  

### 0.1.1 (2025-04-13) - **no good due to parsing/path issues**
- Modularized logic into subroutines (`CALL`)  
- Attempted to remove Delayed Expansion support  
- Introduced parsing issues; reverted to 0.1.0  

### 0.1.0 (2025-04-12)
- Initial release: recursive filename/content search with Desktop\Util logs  

---

## Contributors

- **ConsistentHornet4** — improvement suggestions  
- **@BrainWaveCC** — term-handling fixes (paths with parentheses)  
- **@amakvana** — introduced `CHOICE` prompt for input-handling 

---

## License

This project is released under the [MIT License](LICENSE).  
