require 'byebug'
require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

class SaveRecord
  def save(table_name, columns, values, id)
    new_values = values.dup
    if id.nil?
      column_string = columns.join(", ")
      param_string = (['?'] * new_values.length).join(', ')
      QuestionsDatabase.instance.execute(<<-SQL, *new_values)
        INSERT INTO
          #{table_name} (#{column_string})
        VALUES
          (#{param_string})
        SQL
      self.id = QuestionsDatabase.instance.last_insert_row_id
    else
      column_string = columns.join(" = ? , ")
      column_string << " = ?"
      new_values << id
      QuestionsDatabase.instance.execute(<<-SQL, *new_values)
        UPDATE
          #{table_name}
        SET
          #{column_string}
        WHERE
          id = ?
        SQL
      id
    end
  end
end

class User < SaveRecord

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id.to_s)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL
    User.new(result.first)
  end

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
      SQL
    User.new(result.first)
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        CAST(COUNT(question_likes.id) / COUNT(DISTINCT (questions.id)) AS FLOAT) AS karma
      FROM
        users
      JOIN
        questions ON questions.user_id = users.id
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        users.id = ?
      SQL
    result.first['karma'] || 0
  end

  def save
    columns = %w[fname lname]
    values = [fname, lname]
    super('users', columns, values, id)
  end
end

class Question < SaveRecord

  attr_accessor :id, :title, :body, :user_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      SQL
    Question.new(result.first)
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
      SQL
    results.map { |result| Question.new(result) }
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def save
    columns = %w[title body user_id]
    values = [title, body, user_id]
    super('questions', columns, values, id)
  end
end

class QuestionFollow
  attr_accessor :id, :question_id, :user_id

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
      SQL
    QuestionFollow.new(result.first)
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.user_id) DESC
      LIMIT
        ?
    SQL
    results.map { |result| Question.new(result) }
  end
end

class QuestionLike
  attr_accessor :id, :question_id, :user_id

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
      SQL
    QuestionLike.new(result.first)
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS likes_count
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL
    result.first['likes_count']
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.user_id) DESC
      LIMIT
        ?
    SQL
    results.map { |result| Question.new(result) }
  end
end

class Reply < SaveRecord

  attr_accessor :id, :parent_question_id, :parent_reply_id, :body, :user_id

  def initialize(options = {})
    @id = options['id']
    @parent_question_id = options['parent_question']
    @parent_reply_id = options['parent_reply']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL
    Reply.new(result.first)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
      SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_question = ?
      SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_children_replies(reply_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply = ?
      SQL
    results.map { |result| Reply.new(result) }
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(parent_question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_reply_id)
  end

  def child_replies
    Reply.find_children_replies(self.id)
  end

  def save
    columns = %w[parent_question parent_reply body user_id]
    values = [parent_question_id, parent_reply_id, body, user_id]
    super('replies', columns, values, id)
  end
end
