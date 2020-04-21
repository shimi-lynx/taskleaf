FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'テスト用のライブラリを準備する' }
    user
  end
end