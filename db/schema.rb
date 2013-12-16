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

ActiveRecord::Schema.define(:version => 20131216063003) do

  create_table "flags", :force => true do |t|
    t.integer  "message_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "heart",      :default => false
    t.boolean  "read",       :default => false
    t.boolean  "trashed",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "flags", ["message_id"], :name => "index_message_flags_on_message_id"
  add_index "flags", ["user_id"], :name => "index_message_flags_on_user_id"

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.boolean  "draft"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "sender"
    t.integer  "sender_id"
    t.string   "subject"
    t.string   "recipient_emails"
  end

  add_index "messages", ["sender"], :name => "index_messages_on_sender"

  create_table "recipients", :force => true do |t|
    t.integer  "message_id"
    t.string   "email_address"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "recipient_id"
  end

  add_index "recipients", ["email_address"], :name => "index_recipients_on_email_address"
  add_index "recipients", ["message_id"], :name => "index_recipients_on_message_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "session_token"
  end

  add_index "users", ["email", "password_hash"], :name => "index_users_on_email_and_password_hash"
  add_index "users", ["email"], :name => "index_users_on_email"

end
