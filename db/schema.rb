# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110508172047) do

  create_table "chord_qualities", :force => true do |t|
    t.string "name"
    t.string "code"
    t.string "cached_slug"
  end

  add_index "chord_qualities", ["cached_slug"], :name => "index_chord_qualities_on_cached_slug", :unique => true

  create_table "chord_scales", :force => true do |t|
    t.integer "chord_id"
    t.integer "mode_id"
    t.integer "strength"
    t.text    "information"
  end

  add_index "chord_scales", ["chord_id"], :name => "index_chord_scales_on_chord_id"
  add_index "chord_scales", ["mode_id"], :name => "index_chord_scales_on_mode_id"

  create_table "chord_symbols", :force => true do |t|
    t.integer "chord_id"
    t.string  "name"
    t.boolean "case_sensitive", :default => false
    t.integer "strength"
    t.boolean "primary",        :default => false
  end

  add_index "chord_symbols", ["chord_id"], :name => "index_chord_symbols_on_chord_id"
  add_index "chord_symbols", ["name"], :name => "index_chord_symbols_on_name"

  create_table "chord_tones", :force => true do |t|
    t.integer "chord_id"
    t.integer "position"
    t.integer "tone"
    t.integer "letter_index"
    t.integer "strength"
    t.boolean "omitable",     :default => false
    t.text    "information"
  end

  add_index "chord_tones", ["chord_id"], :name => "index_chord_tones_on_chord_id"

  create_table "chords", :force => true do |t|
    t.integer "chord_quality_id"
    t.integer "parent_id"
    t.string  "name"
    t.string  "cached_slug"
    t.text    "synonyms"
    t.text    "information"
  end

  add_index "chords", ["cached_slug"], :name => "index_chords_on_cached_slug", :unique => true
  add_index "chords", ["chord_quality_id"], :name => "index_chords_on_chord_quality_id"
  add_index "chords", ["parent_id"], :name => "index_chords_on_parent_id"

  create_table "concepts", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concepts", ["cached_slug"], :name => "index_concepts_on_cached_slug", :unique => true

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forms", ["cached_slug"], :name => "index_forms_on_cached_slug", :unique => true

  create_table "instruments", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instruments", ["cached_slug"], :name => "index_instruments_on_cached_slug", :unique => true

  create_table "keys", :force => true do |t|
    t.string  "name"
    t.string  "cached_slug"
    t.string  "long_name"
    t.boolean "primary",      :default => true
    t.integer "index"
    t.integer "letter_index"
    t.integer "cycle_index"
  end

  add_index "keys", ["cached_slug"], :name => "index_keys_on_cached_slug", :unique => true
  add_index "keys", ["cycle_index"], :name => "index_keys_on_cycle_index"
  add_index "keys", ["letter_index"], :name => "index_keys_on_letter_index"
  add_index "keys", ["name"], :name => "index_keys_on_name", :unique => true

  create_table "meters", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.integer  "beats"
    t.integer  "division"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meters", ["cached_slug"], :name => "index_meters_on_cached_slug", :unique => true

  create_table "modes", :force => true do |t|
    t.integer "scale_id"
    t.integer "mode"
    t.string  "name"
    t.string  "cached_slug"
    t.text    "synonyms"
    t.integer "dissonance"
    t.text    "information"
  end

  add_index "modes", ["cached_slug"], :name => "index_modes_on_cached_slug", :unique => true
  add_index "modes", ["mode"], :name => "index_modes_on_mode"
  add_index "modes", ["scale_id"], :name => "index_modes_on_scale_id"

  create_table "musicians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "cached_slug"
    t.date     "born_on"
    t.date     "died_on"
    t.integer  "prominence"
    t.integer  "instrument_id"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "musicians", ["cached_slug"], :name => "index_musicians_on_cached_slug", :unique => true
  add_index "musicians", ["instrument_id"], :name => "index_musicians_on_instrument_id"

  create_table "progression_components", :force => true do |t|
    t.integer  "progression_id"
    t.integer  "position"
    t.integer  "chord_id"
    t.integer  "index"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progression_components", ["chord_id"], :name => "index_progression_components_on_chord_id"
  add_index "progression_components", ["position"], :name => "index_progression_components_on_position"
  add_index "progression_components", ["progression_id"], :name => "index_progression_components_on_progression_id"

  create_table "progressions", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.integer  "bars"
    t.boolean  "full_tune",   :default => false
    t.integer  "meter_id"
    t.integer  "form_id"
    t.string   "summary"
    t.text     "information"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progressions", ["cached_slug"], :name => "index_progressions_on_cached_slug", :unique => true
  add_index "progressions", ["meter_id"], :name => "index_progressions_on_meter_id"

  create_table "scale_tones", :force => true do |t|
    t.integer "scale_id"
    t.integer "position"
    t.integer "tone"
    t.integer "letter_index"
  end

  create_table "scales", :force => true do |t|
    t.string  "name"
    t.string  "cached_slug"
    t.string  "information"
    t.integer "symmetry_index"
  end

  add_index "scales", ["cached_slug"], :name => "index_scales_on_cached_slug", :unique => true

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tunes", :force => true do |t|
    t.string   "name"
    t.string   "alternate_name"
    t.string   "cached_slug"
    t.integer  "vehicle_id"
    t.integer  "meter_id"
    t.integer  "key_id"
    t.integer  "secondary_key_id"
    t.string   "tonality",                   :default => "Major"
    t.string   "concept",                    :default => "Instrumental"
    t.integer  "form_id"
    t.integer  "form_length"
    t.string   "form_lengths"
    t.integer  "starting_chord_id"
    t.integer  "ending_chord_id"
    t.integer  "contrafact_of_tune_id"
    t.integer  "tempo"
    t.integer  "aebersold_playalong_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tunes", ["aebersold_playalong_number"], :name => "index_tunes_on_aebersold_playalong_number"
  add_index "tunes", ["cached_slug"], :name => "index_tunes_on_cached_slug", :unique => true
  add_index "tunes", ["form_id"], :name => "index_tunes_on_form_id"
  add_index "tunes", ["key_id"], :name => "index_tunes_on_key_id"
  add_index "tunes", ["meter_id"], :name => "index_tunes_on_meter_id"
  add_index "tunes", ["secondary_key_id"], :name => "index_tunes_on_secondary_key_id"
  add_index "tunes", ["vehicle_id"], :name => "index_tunes_on_vehicle_id"

  create_table "vehicles", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicles", ["cached_slug"], :name => "index_vehicles_on_cached_slug", :unique => true
  add_index "vehicles", ["parent_id"], :name => "index_vehicles_on_parent_id"

  create_table "voicing_tones", :force => true do |t|
    t.integer "voicing_id"
    t.integer "position"
    t.integer "tone"
    t.integer "tone_reference_offset", :default => 0
    t.text    "information"
  end

  add_index "voicing_tones", ["voicing_id"], :name => "index_voicing_tones_on_voicing_id"

  create_table "voicings", :force => true do |t|
    t.integer "chord_id"
    t.string  "name"
    t.string  "cached_slug"
    t.text    "information"
  end

  add_index "voicings", ["cached_slug"], :name => "index_voicings_on_cached_slug", :unique => true
  add_index "voicings", ["chord_id"], :name => "index_voicings_on_chord_id"

end
