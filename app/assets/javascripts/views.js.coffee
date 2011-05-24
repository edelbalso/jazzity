window.Jazzity or= {}

Jazzity.Staff = Backbone.View.extend
  tagName: "div",
  className: "staff"

  initialize: ->
    this.stave_offset = 0
    this.stave_delta = 70
    this.staves = {}

  draw_canvas: (options = {})->
    this.canvas_width = options["width"] || 170
    this.canvas_height = options["height"] || 120

    this.canvas_element = $("<canvas width='#{this.canvas_width}' height='#{this.canvas_height}'></canvas>")
    this.canvas_element.appendTo(this.el)
    this.canvas = this.canvas_element[0]

    this.renderer = new Vex.Flow.Renderer(this.canvas, Vex.Flow.Renderer.Backends.CANVAS);
    this.context  = this.renderer.getContext()

  draw_stave: (clef = "treble", options = {})->
    this.staves[clef] = new Vex.Flow.Stave(10, this.stave_offset, this.canvas_width - 20)
    this.staves[clef].addClef(clef).setContext(this.context).draw()
    this.stave_offset += this.stave_delta

  # This is necessary because VexFlow does not have any real implementation of a bass clef. 
  # So, we're basically taking bass-denominated notes and presenting them as if they were treble clef.
  # Come on VexFlow, this is pretty ridiculous.
  # 
  adjust_bass_notes: (notes)->
    _(notes).map (note)->
      new_note = _.clone(note)
      new_note.duration ||= "q"
      new_note.stem_direction = -1
      new_note.keys = _(new_note.keys).map (key, i)->
        [note_portion, octave_portion] = key.split("/")
        octave_portion = parseInt(octave_portion) + 1
        "#{note_portion}/#{octave_portion}"
      new_note

  draw_notes: (notes)->
    treble_notes = _(notes).map (note)->
      new_note = _.clone(note)
      new_note.duration ||= "q"
      new_note.keys = _(new_note.keys).select (key, i)->
        [note_portion, octave_portion] = key.split("/")
        if parseInt(octave_portion) < 4 then false else true
      new_note
    
    bass_notes   = _(notes).map (note)->
      new_note = _.clone(note)
      new_note.duration ||= "q"
      new_note.keys = _(new_note.keys).select (key, i)->
        [note_portion, octave_portion] = key.split("/")
        if parseInt(octave_portion) < 4 then true else false
      new_note

    treble_notes = _(treble_notes).reject (note)-> note.keys.length == 0
    bass_notes   = _(bass_notes).reject (note)-> note.keys.length == 0
    bass_notes   = this.adjust_bass_notes(bass_notes) if bass_notes.length > 0

    this.draw_notes_on_stave treble_notes, "treble" if this.staves["treble"] and treble_notes.length > 0
    this.draw_notes_on_stave bass_notes, "bass" if this.staves["bass"] and bass_notes.length > 0

  
  draw_notes_on_stave: (notes, clef = "treble")->
    self = this
    stave_notes = _(notes).map (note)->
      note.duration ||= "q"
      
      stave_note = new Vex.Flow.StaveNote(note)
      _(note.keys).each (key, i)->
        note_portion = key.split("/")[0]
        accidental = note_portion[1..note_portion.length]
        if accidental.length > 0
          stave_note.addAccidental(i, new Vex.Flow.Accidental(accidental))
      stave_note
    
    Vex.Flow.Formatter.FormatAndDraw this.context, this.staves[clef], stave_notes
    

Jazzity.ChordStaff = Jazzity.Staff.extend
  render: ->
    this.draw_canvas()
    this.draw_stave "treble", width: 170
    this.draw_notes [
      { keys: this.model.get("notes") }
    ]

Jazzity.VoicingStaff = Jazzity.Staff.extend
  render: ->
    this.draw_canvas(height: 180)
    this.draw_stave "treble", width: 170
    this.draw_stave "bass", width: 170
    this.draw_notes [
      { keys: this.model.get("notes") }
    ]

Jazzity.ScaleStaff = Jazzity.Staff.extend
  render: ->
    this.draw_canvas(width: 600)
    this.draw_stave "treble"
    this.draw_notes _(this.model.get("notes")).map (note) ->
      { keys: [note] }

Jazzity.ProgressionStaff = Jazzity.Staff.extend
  render: ->
    this.draw_canvas(width: 600)
    this.draw_stave "treble"
    this.draw_notes _(this.model.get("notes")).map (chord) ->
      { keys: chord }
