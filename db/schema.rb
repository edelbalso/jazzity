# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20111121061853) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "chord_qualities", :force => true do |t|
    t.string "name"
    t.string "code"
    t.string "slug"
  end

  add_index "chord_qualities", ["slug"], :name => "index_chord_qualities_on_cached_slug", :unique => true

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
    t.string  "slug"
    t.text    "synonyms"
    t.text    "information"
  end

  add_index "chords", ["chord_quality_id"], :name => "index_chords_on_chord_quality_id"
  add_index "chords", ["parent_id"], :name => "index_chords_on_parent_id"
  add_index "chords", ["slug"], :name => "index_chords_on_cached_slug", :unique => true

  create_table "concepts", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concepts", ["slug"], :name => "index_concepts_on_cached_slug", :unique => true

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forms", ["slug"], :name => "index_forms_on_cached_slug", :unique => true

  create_table "instruments", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instruments", ["slug"], :name => "index_instruments_on_cached_slug", :unique => true

  create_table "keys", :force => true do |t|
    t.string  "name"
    t.string  "long_name"
    t.boolean "primary",      :default => true
    t.integer "index"
    t.integer "letter_index"
    t.integer "cycle_index"
  end

  add_index "keys", ["cycle_index"], :name => "index_keys_on_cycle_index"
  add_index "keys", ["letter_index"], :name => "index_keys_on_letter_index"
  add_index "keys", ["name"], :name => "index_keys_on_name", :unique => true

  create_table "meters", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "beats"
    t.integer  "division"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meters", ["slug"], :name => "index_meters_on_cached_slug", :unique => true

  create_table "modes", :force => true do |t|
    t.integer "scale_id"
    t.integer "mode"
    t.string  "name"
    t.string  "slug"
    t.text    "synonyms"
    t.integer "dissonance"
    t.text    "information"
  end

  add_index "modes", ["mode"], :name => "index_modes_on_mode"
  add_index "modes", ["scale_id"], :name => "index_modes_on_scale_id"
  add_index "modes", ["slug"], :name => "index_modes_on_cached_slug", :unique => true

  create_table "musician_authentications", :force => true do |t|
    t.integer  "musician_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.text     "user_information"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musicians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "slug"
    t.date     "born_on"
    t.date     "died_on"
    t.integer  "prominence"
    t.integer  "instrument_id"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                                               :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128,                               :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.string   "twitter_username"
    t.string   "location"
    t.string   "external_avatar_url"
    t.string   "website_url"
    t.decimal  "time_zone_offset",                      :precision => 5, :scale => 2
  end

  add_index "musicians", ["authentication_token"], :name => "index_musicians_on_authentication_token", :unique => true
  add_index "musicians", ["confirmation_token"], :name => "index_musicians_on_confirmation_token", :unique => true
  add_index "musicians", ["email"], :name => "index_musicians_on_email"
  add_index "musicians", ["instrument_id"], :name => "index_musicians_on_instrument_id"
  add_index "musicians", ["reset_password_token"], :name => "index_musicians_on_reset_password_token", :unique => true
  add_index "musicians", ["slug"], :name => "index_musicians_on_cached_slug", :unique => true

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
    t.string   "slug"
    t.integer  "bars"
    t.boolean  "full_tune",   :default => false
    t.integer  "meter_id"
    t.integer  "form_id"
    t.string   "summary"
    t.text     "information"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progressions", ["meter_id"], :name => "index_progressions_on_meter_id"
  add_index "progressions", ["slug"], :name => "index_progressions_on_cached_slug", :unique => true

  create_table "scale_tones", :force => true do |t|
    t.integer "scale_id"
    t.integer "position"
    t.integer "tone"
    t.integer "letter_index"
  end

  create_table "scales", :force => true do |t|
    t.string  "name"
    t.string  "slug"
    t.string  "information"
    t.integer "symmetry_index"
  end

  add_index "scales", ["slug"], :name => "index_scales_on_cached_slug", :unique => true

  create_table "searchables", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.string  "display_name"
    t.string  "model_type"
    t.string  "model_id"
    t.integer "key_id"
    t.integer "priority",     :default => 1, :null => false
  end

  add_index "searchables", ["name"], :name => "index_searchables_on_name"
  add_index "searchables", ["parent_id"], :name => "index_searchables_on_parent_id"

  create_table "tunes", :force => true do |t|
    t.string   "name"
    t.string   "alternate_name"
    t.string   "slug"
    t.integer  "vehicle_id"
    t.integer  "meter_id"
    t.integer  "primary_key_id"
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
  add_index "tunes", ["form_id"], :name => "index_tunes_on_form_id"
  add_index "tunes", ["meter_id"], :name => "index_tunes_on_meter_id"
  add_index "tunes", ["primary_key_id"], :name => "index_tunes_on_primary_key_id"
  add_index "tunes", ["secondary_key_id"], :name => "index_tunes_on_secondary_key_id"
  add_index "tunes", ["slug"], :name => "index_tunes_on_cached_slug", :unique => true
  add_index "tunes", ["vehicle_id"], :name => "index_tunes_on_vehicle_id"

  create_table "vehicles", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicles", ["parent_id"], :name => "index_vehicles_on_parent_id"
  add_index "vehicles", ["slug"], :name => "index_vehicles_on_cached_slug", :unique => true

  create_table "voicing_tones", :force => true do |t|
    t.integer "voicing_id"
    t.integer "position"
    t.integer "tone"
    t.integer "letter_index"
    t.integer "strength"
    t.boolean "omitable",     :default => false
    t.text    "information"
  end

  add_index "voicing_tones", ["voicing_id"], :name => "index_voicing_tones_on_voicing_id"

  create_table "voicings", :force => true do |t|
    t.integer "chord_id"
    t.integer "parent_id"
    t.string  "name"
    t.string  "slug"
    t.integer "octave_offset", :default => 0
    t.text    "information"
  end

  add_index "voicings", ["chord_id"], :name => "index_voicings_on_chord_id"
  add_index "voicings", ["slug"], :name => "index_voicings_on_cached_slug", :unique => true

end
