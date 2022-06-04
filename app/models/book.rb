class Book < ApplicationRecord
  # scopeを定義するメリット
  # 繰り返し利用するクエリの再利用性が上がる。
  # クエリに名前をつけることで可読性が上がる。
  scope :costly, -> { where("proce > ?", 3000) }

  # 特定のパラメータを利用するscopeも定義可能。
  scope :written_about, -> (theme) { where("name like ?", "%#{theme}%") }
  # Book.costly.written_about("java") などのように重ねて呼び出すことも可能。可読性も高い。(普通のSQLを書く場合は一度に全部指定しないといけないので、こうはいかない！単体でもメソッドチェインでも呼び出せる！)

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # validateブロック内で独自のバリデーションを行う例。
  # errorsに何かしらの値が入っていればバリデーション失敗と判定されるため、自分でバリデーションを定義する場合は不正になる条件ならばerrorsにエラーメッセージを付与するという方法でバリデーションを行こなう。
  validate do |book|
    if book.name.include?("exercise")
      book.errors[:name] << "I don't like exercise."
    end
  end
end
