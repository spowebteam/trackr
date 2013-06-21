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

ActiveRecord::Schema.define(:version => 20130621150319) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "phone"
    t.string   "url"
    t.string   "address"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "active",      :default => false
    t.integer  "poc_id"
    t.integer  "manager_id"
    t.integer  "status"
    t.string   "description"
  end

  add_index "companies", ["poc_id", "manager_id"], :name => "index_companies_on_poc_id_and_manager_id"

  create_table "companies_teams", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "company_id"
  end

  add_index "companies_teams", ["company_id"], :name => "index_companies_teams_on_company_id"
  add_index "companies_teams", ["team_id"], :name => "index_companies_teams_on_team_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "designation"
    t.string   "landline"
    t.string   "mobile"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "company_id"
    t.boolean  "default"
    t.boolean  "active"
  end

  add_index "contacts", ["active"], :name => "index_contacts_on_active"
  add_index "contacts", ["company_id"], :name => "index_contacts_on_company_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "teams_users", ["team_id"], :name => "index_teams_users_on_team_id"
  add_index "teams_users", ["user_id"], :name => "index_teams_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "level"
    t.string   "phone"
    t.string   "identifier"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
