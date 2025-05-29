# module Bach

using MIDI: Note
Fundamental(note::Note) = Fundamental(PC(note.pitch))

# module Bach
