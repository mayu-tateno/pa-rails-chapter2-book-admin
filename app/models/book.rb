class Book < ApplicationRecord
  # scopeを定義するメリット
  # 繰り返し利用するクエリの再利用性が上がる。
  # クエリに名前をつけることで可読性が上がる。
  scope :costly, -> { where("proce > ?", 3000) }

  # 特定のパラメータを利用するscopeも定義可能。
  scope :written_about, -> (theme) { where("name like ?", "%#{theme}%") }
  # Book.costly.written_about("java") などのように重ねて呼び出すことも可能。可読性も高い。(普通のSQLを書く場合は一度に全部指定しないといけないので、こうはいかない！単体でもメソッドチェインでも呼び出せる！)
end
