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

ActiveRecord::Schema.define(:version => 20110629190650) do

  create_table "accesses", :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "secret",                  :default => 0
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.string   "attachment_file_name"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.text     "address"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions", :force => true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.integer  "archived",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.string   "updates"
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "attachment"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.string   "attachment_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "archived",    :default => 0
    t.string   "status",      :default => "inquiry"
    t.string   "repository"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer "user_id"
    t.integer "topic_id"
  end

  create_table "tasks", :force => true do |t|
    t.text     "description"
    t.string   "status",                                                :default => "pending"
    t.decimal  "duration",                :precision => 8, :scale => 2, :default => 0.0
    t.string   "priority",                                              :default => "medium"
    t.integer  "secret",                                                :default => 0
    t.integer  "user_id"
    t.integer  "assigned_user_id"
    t.integer  "parent_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "attachment"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.string   "attachment_file_name"
    t.datetime "planned_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "discussion_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "attachment"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.string   "attachment_file_name"
  end

  create_table "users", :force => true do |t|
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
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "role"
    t.integer  "company_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
