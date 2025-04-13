# 🔍 File-Content-Searcher

This simple batch script helps you quickly search through large folders by recursively scanning for a specified term. You can choose to search within **filenames** or **file contents**. It prompts for the target folder, search term, and method of search. Results are logged to a file in a folder named `Util` on your Desktop.

---

## 🧰 What It Does

- ✅ Recursively searches all subfolders
- 🔎 Lets you choose between searching:
  - File **names**
  - File **contents**
- 📄 Logs results to a text file:
  - `search_filename_log.txt` or `search_content_log.txt`
- 💻 Fully command-line-based — no installation needed
- 🆚 Offers a lightweight alternative to File Explorer and Notepad++ search

---

## 🚀 How to Use

1. **Run** the batch file by double-clicking it.
2. **Enter or paste the folder path** to search (e.g., `C:\Users\YourName\Documents`)
3. **Enter the search term** (case-insensitive)
4. **Choose the search type**:
   - `1` — search **within file contents**
   - `2` — search **by filename**
5. View the results:
   - Output is saved to your **Desktop** under `Util\search_content_log.txt` or `search_filename_log.txt`

---

## 📋 Output Details

- Each result includes the **full file path**.
- If searching **contents**, it also shows the **matching line number** and the **line**, 
- There is **no file-type filter** currently, so results may include system, binary, or undesired files — some manual review may be needed.
- My workflow is to run the filname search to narrow the scope for running the content search (if able)

---

## Output Example - Filename
Search Term: backpack
Selected Folder: C:\Program Files (x86)\Steam\steamapps\workshop\content\108600

=== Matching Files === 
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2256623447\mods\Firearms\media\models_x\Skinned\BackPacks
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2256623447\mods\Firearms\media\models_x\Skinned\BackPacks\AmmoCan_LHand.fbx
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2256623447\mods\Firearms\media\models_x\Skinned\BackPacks\AmmoCan_RHand.fbx
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2297098490\mods\ARSENAL(26)GunFighter[MOD 2.0]\media\models_X\Skinned\BackPacks
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2297098490\mods\ARSENAL(26)GunFighter[MOD 2.0]\media\models_X\Skinned\BackPacks\AmmoCan30_LHand.X
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\2297098490\mods\ARSENAL(26)GunFighter[MOD 2.0]\media\models_X\Skinned\BackPacks\AmmoCan30_RHand.X

---

## Output Example - Content
Search Term: backpack
Selected Folder: C:\Program Files (x86)\Steam\steamapps\workshop\content\108600

=== Matching Lines in Files === 
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\1299328280\mods\More Traits\42\media\lua\client\MoreTraits.lua:857:        for i, v in ipairs(_iSInventoryPage.backpacks) do
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\1299328280\mods\More Traits\42\media\lua\client\MoreTraits.lua:981:        for i, v in ipairs(_iSInventoryPage.backpacks) do
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600\1299328280\mods\More Traits\42\media\lua\client\MoreTraits.lua:1111:        for j, v in ipairs(_iSInventoryPage.backpacks) do

---

## 📝 License

Licensed under the [MIT License](LICENSE).

---

## 💬 Feedback

Have suggestions or want to contribute? Feel free to fork the repo, open an issue, or submit a pull request.
