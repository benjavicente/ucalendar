class InitAppDb < ActiveRecord::Migration[6.1]
  def change
    # Modelos base

    create_table :holidays do |t|
      t.timestamps
      t.date    :day, null: false
      t.string  :name, null: false
      t.boolean :every_yeat, default: false, null: false
    end

    create_table :teachers do |t|
      t.timestamps
      t.string     :name, null: false
    end

    create_table :campus do |t|
      t.string :name, null: false
    end

    create_table :academic_units do |t|
      t.string :name, null: false
    end

    create_table :terms do |t|
      t.timestamps
      t.integer    :year, null: false
      t.integer    :period, null: false, limit: 8
      t.date       :first_day, null: false
      t.date       :last_day, null: false
    end
    add_index :terms, :year
    add_index :terms, :period

    create_table :subjects do |t|
      t.timestamps
      t.string     :code, null: false
      t.string     :name, null: false
      t.integer    :credits
      t.string     :fr_area
      t.string     :category
    end
    add_index :subjects, :code, unique: true

    create_table :courses do |t|
      t.timestamps
      t.belongs_to :term
      t.belongs_to :subject
      t.belongs_to :academic_unit
      t.belongs_to :campus
      t.string     :nrc, null: false
      t.integer    :section, null: false
      t.integer    :format
      t.integer    :total_vacancy
      t.boolean    :withdrawal?, default: true
      t.boolean    :english?, default: false
      t.boolean    :require_special_approval?, default: false
    end

    create_table :schedules do |t|
      t.belongs_to :course
    end

    create_table :schedule_events do |t|
      t.timestamps
      t.belongs_to :schedule
      t.integer    :category
      t.string     :classroom
      t.integer    :day, null: false
      t.integer    :module, null: false
    end

    create_table :exams do |t|
      t.timestamps
      t.belongs_to :schedule
      t.datetime   :start, null: false
      t.datetime   :end, null: false
      t.string     :name, null: false
    end

    create_table :courses_teachers, id: false do |t|
      t.belongs_to :course
      t.belongs_to :teacher
    end

    # Usuario y administración

    create_table :users do |t|
      t.string   :email, null: false, default: ''
      t.string   :encrypted_password, null: false, default: ''
      t.datetime :remember_created_at
    end
    add_index :users, :email, unique: true

    create_table :active_admin_comments do |t|
      t.string     :namespace
      t.text       :body
      t.references :resource, polymorphic: true
      t.references :author, polymorphic: true
      t.timestamps
    end
    add_index :active_admin_comments, [:namespace]
  end
end
