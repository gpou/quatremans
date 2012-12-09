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

ActiveRecord::Schema.define(:version => 20121209010940) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "coleccio_translations", :force => true do |t|
    t.integer  "coleccio_id"
    t.string   "locale"
    t.string   "nom"
    t.string   "slug"
    t.text     "descripcio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "coleccio_translations", ["coleccio_id"], :name => "index_coleccio_translations_on_coleccio_id"
  add_index "coleccio_translations", ["locale"], :name => "index_coleccio_translations_on_locale"

  create_table "coleccions", :force => true do |t|
    t.string   "slug",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "foto_translations", :force => true do |t|
    t.integer  "foto_id"
    t.string   "locale"
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "foto_translations", ["foto_id"], :name => "index_foto_translations_on_foto_id"
  add_index "foto_translations", ["locale"], :name => "index_foto_translations_on_locale"

  create_table "fotos", :force => true do |t|
    t.integer  "producte_id"
    t.integer  "position"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "producte_translations", :force => true do |t|
    t.integer  "producte_id"
    t.string   "locale"
    t.string   "nom"
    t.string   "slug"
    t.text     "descripcio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "producte_translations", ["locale"], :name => "index_producte_translations_on_locale"
  add_index "producte_translations", ["producte_id"], :name => "index_producte_translations_on_producte_id"

  create_table "productes", :force => true do |t|
    t.integer  "coleccio_id"
    t.string   "slug",                                       :null => false
    t.float    "preu"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "disponible",            :default => true
    t.boolean  "actiu",                 :default => true
    t.string   "tipus",                 :default => "model"
    t.integer  "dificultat"
    t.string   "coordenades_coleccio"
    t.string   "dibuix_file_name"
    t.string   "dibuix_content_type"
    t.string   "dibuix_file_size"
    t.text     "svg"
    t.integer  "position"
    t.text     "coleccio_path"
    t.text     "coleccio_mascara_path"
  end

end
