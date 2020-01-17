class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
        SQL
    DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
  SQL

  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end


# 1. Write a class that is mapped, or equated, to a database table. 
# 2. Build a method that creates a table that maps to the given class. 
# 3. Write a method that drops that table. 
# 4. Write a method that saves a given instance to the database table. 
# 5. Write a method that both creates a new instance of the class *and* saves that instance to a database table. 