class CreateHorses < ActiveRecord::Migration[7.1]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :pedigree_name
      t.date :foaled
      t.integer :sex
      t.integer :breed
      t.integer :group
      t.references :sire, foreign_key: { to_table: :horses }
      t.references :dam, foreign_key: { to_table: :horses }
      t.references :family_line
      t.boolean :only_year, null: false, default: false

      t.timestamps
    end

    create_table :family_lines do |t|
      t.references :bloodmare, foreign_key: { to_table: :horses }
      t.string :family_number
      t.string :imported_by
      t.date :imported_at
      t.boolean :only_year, null: false, default: true
      t.integer :from

      t.timestamps
    end

    create_table :grades do |t|
      t.string :code
      t.string :name
      t.integer :rank
      t.string :desc

      t.timestamps
    end

    create_table :graded_races do |t|
      t.string :code
      t.string :name
      t.string :official_name
      t.string :desc
      t.integer :breed
      t.integer :status
      t.references :grade

      t.timestamps
    end

    create_table :racing_records do |t|
      t.date :date
      t.references :horse
      t.references :graded_race
      t.integer :finnish

      t.timestamps
    end

    create_table :awards do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end

    create_table :awardings do |t|
      t.date :year
      t.references :horse
      t.references :award

      t.timestamps
    end

    add_foreign_key :horses, :family_lines
    add_foreign_key :graded_races, :grades
    add_foreign_key :racing_records, :horses
    add_foreign_key :racing_records, :graded_races
    add_foreign_key :awardings, :horses
    add_foreign_key :awardings, :awards
  end
end
