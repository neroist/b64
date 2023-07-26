import std/base64

import uing/genui
import uing

var
  autoTranslate: bool
  safe: bool

proc main() = 
  let translationMenu = newMenu("Translation")
  translationMenu.addCheckItem("Automatically Encode/Decode") do (item: MenuItem, win: Window):
    autoTranslate = item.checked
  translationMenu.addCheckItem("Encode Safely") do (item: MenuItem, win: Window):
    safe = item.checked

  genui:
    window%Window("Base64", 800, 600, true):
      VerticalBox(padded = true):
        HorizontalBox(padded = true):
          lang1Combo%Combobox(["Base64", "Data"])[stretchy = true]
          Label("--->")
          lang2Combo%Combobox(["Base64", "Data"])[stretchy = true]

        HorizontalBox(padded = true)[stretchy = true]:
          entry1%MultilineEntry()[stretchy = true]
          HorizontalSeparator()
          entry2%MultilineEntry()[stretchy = true]

        tbutton%Button("Translate!")

  window.margined = true

  lang1Combo.selected = 1
  lang2Combo.selected = 0

  entry1.onchanged = proc (_: MultilineEntry) =
    if autoTranslate:
      tbutton.onclick(nil)

  entry2.readOnly = true

  tbutton.onclick = proc (_: Button) =
    if lang1Combo.selected == lang2Combo.selected:
      entry1.text = entry2.text
      return

    if lang1Combo.selected == 1:
      entry2.text = encode(entry1.text, safe)
    else:
      entry2.text = decode(entry1.text)

  window.show()
  mainLoop()

init()
main()
