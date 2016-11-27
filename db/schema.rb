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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161127194945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organisations", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.text     "history"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_organisations_on_name", unique: true, using: :btree
  end

  create_table "planets", force: :cascade do |t|
    t.integer  "star_id",                               null: false
    t.string   "standard_code",                         null: false
    t.string   "internal_code",                         null: false
    t.string   "particular_name"
    t.string   "position",             default: "a",    null: false
    t.float    "star_distance",        default: 1.0,    null: false
    t.integer  "diameter",             default: 12742,  null: false
    t.float    "mass",                 default: 1.0,    null: false
    t.float    "orbital_period",       default: 365.25, null: false
    t.float    "orbital_eccentricity", default: 0.01,   null: false
    t.float    "rotation_period",      default: 1.0,    null: false
    t.float    "surface_gravity",      default: 1.0,    null: false
    t.float    "surface_pressure",     default: 1.0,    null: false
    t.integer  "surface_temperature",  default: 350,    null: false
    t.string   "surface_type",         default: "t",    null: false
    t.float    "escape_velocity",      default: 11.15,  null: false
    t.text     "composition"
    t.text     "description"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["particular_name"], name: "index_planets_on_particular_name", unique: true, using: :btree
  end

  create_table "stars", force: :cascade do |t|
    t.integer  "system_id",                        null: false
    t.string   "standard_code",                    null: false
    t.string   "internal_code",                    null: false
    t.string   "particular_name"
    t.string   "position",          default: "A",  null: false
    t.string   "spectral_class",                   null: false
    t.string   "spectral_subclass",                null: false
    t.string   "luminosity_class",                 null: false
    t.string   "prefix"
    t.string   "suffix"
    t.integer  "rotation",          default: 28,   null: false
    t.integer  "temperature",       default: 5750, null: false
    t.float    "age",               default: 4.5,  null: false
    t.float    "mass",              default: 1.0,  null: false
    t.float    "rayon",             default: 1.0,  null: false
    t.text     "composition"
    t.text     "description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["particular_name"], name: "index_stars_on_particular_name", unique: true, using: :btree
  end

  create_table "systems", force: :cascade do |t|
    t.string   "standard_code",               null: false
    t.string   "internal_code",               null: false
    t.string   "particular_name"
    t.integer  "x",               default: 0, null: false
    t.integer  "y",               default: 0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["particular_name"], name: "index_systems_on_particular_name", unique: true, using: :btree
  end

end
