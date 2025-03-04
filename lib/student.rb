class Student
  attr_accessor :name,:grade
  attr_reader :id
  def initialize(name,grade)
    @name,@grade =name,grade
  end

  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
      DB[:conn].execute(sql)
    end
    
    def save 
      sql = <<-SQL
      INSERT INTO students(
        name,
        grade
        )
        VALUES (?,?)
      SQL
      DB[:conn].execute(sql, self.name,self.grade)
      @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC").flatten.first
    end
    def self.create(name:,grade:)
      x = Student.new(name,grade)
      x.save
      x
    end



  
end
