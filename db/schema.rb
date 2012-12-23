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

ActiveRecord::Schema.define(:version => 20121223120110) do

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

  create_table "addresses", :force => true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.boolean  "is_invoice"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "phone"
    t.string   "dni"
    t.integer  "provincia_id",     :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "country_id"
    t.string   "email"
  end

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

  create_table "configgrups", :force => true do |t|
    t.string  "nom"
    t.integer "coleccio_id"
    t.string  "tipus"
  end

  create_table "configgrups_configopcions", :id => false, :force => true do |t|
    t.integer "configgrup_id",  :null => false
    t.integer "configopcio_id", :null => false
  end

  create_table "configopcio_translations", :force => true do |t|
    t.integer  "configopcio_id"
    t.string   "locale"
    t.string   "nom"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "configopcio_translations", ["configopcio_id"], :name => "index_bb9507e3cc334beaa2f67ffecaed91649c6106ba"
  add_index "configopcio_translations", ["locale"], :name => "index_config_opcio_translations_on_locale"

  create_table "configopcions", :force => true do |t|
    t.string "nom"
    t.string "tipus"
    t.float  "preu"
    t.text   "svg"
  end

  create_table "configparametre_translations", :force => true do |t|
    t.integer  "configparametre_id"
    t.string   "locale"
    t.string   "nom"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "configparametre_translations", ["configparametre_id"], :name => "index_3a628862662a35a5f70cf4e2fc59cfba57e5f441"
  add_index "configparametre_translations", ["locale"], :name => "index_config_parametre_translations_on_locale"

  create_table "configparametres", :force => true do |t|
    t.string  "nom"
    t.integer "producte_id"
    t.integer "configgrup_id"
    t.string  "tipus"
    t.integer "position"
    t.integer "configopcio_id"
  end

  create_table "configzones", :force => true do |t|
    t.integer "configparametre_id"
    t.text    "svg"
    t.boolean "dibuix"
    t.string  "nom"
    t.boolean "configurador"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.float    "preu_ports"
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

  create_table "orderitemparametres", :force => true do |t|
    t.integer "orderitem_id"
    t.integer "configparametre_id"
    t.integer "configopcio_id"
    t.string  "label"
    t.string  "value"
    t.integer "producte_id"
  end

  create_table "orderitems", :force => true do |t|
    t.integer  "order_id"
    t.integer  "producte_id"
    t.decimal  "unit_price",  :precision => 10, :scale => 2
    t.integer  "quantity"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "number"
    t.integer  "paymentmode_id"
    t.string   "shipping_mode"
    t.decimal  "shipping_amount",  :precision => 10, :scale => 2
    t.decimal  "amount",           :precision => 10, :scale => 2
    t.decimal  "vat_amount",       :precision => 10, :scale => 2
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.string   "description"
    t.integer  "old_id"
    t.string   "spedition_number"
    t.integer  "user_id"
    t.boolean  "create_user",                                     :default => true
  end

  create_table "ordertransactions", :force => true do |t|
    t.integer  "order_id"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "reference"
    t.string   "message"
    t.string   "action"
    t.text     "params"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paymentmode_translations", :force => true do |t|
    t.integer  "paymentmode_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "paymentmode_translations", ["locale"], :name => "index_paymentmode_translations_on_locale"
  add_index "paymentmode_translations", ["paymentmode_id"], :name => "index_paymentmode_translations_on_paymentmode_id"

  create_table "paymentmodes", :force => true do |t|
    t.string   "slug"
    t.string   "name"
    t.string   "state",      :default => "inactive"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "slug",                                                             :null => false
    t.float    "preu"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.boolean  "disponible",                                  :default => true
    t.boolean  "actiu",                                       :default => true
    t.string   "tipus",                                       :default => "model"
    t.integer  "dificultat"
    t.string   "coordenades_coleccio"
    t.string   "dibuix_file_name"
    t.string   "dibuix_content_type"
    t.string   "dibuix_file_size"
    t.text     "svg",                   :limit => 2147483647
    t.integer  "position"
    t.text     "coleccio_path"
    t.text     "coleccio_mascara_path"
    t.text     "svg_darrera",           :limit => 2147483647
    t.text     "svg_davant",            :limit => 2147483647
    t.text     "svg_estampat_davant",   :limit => 2147483647
    t.text     "svg_estampat_darrera",  :limit => 2147483647
    t.text     "svg_estampat",          :limit => 2147483647
  end

  create_table "provincias", :force => true do |t|
    t.string   "name"
    t.integer  "country_id", :null => false
    t.float    "preu_ports"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
