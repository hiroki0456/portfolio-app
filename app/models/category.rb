class Category < ActiveHash::Base
  # カテゴリーは柔軟性を持たせるために,
  # active_hashを使用する
  self.data = [
    {id: 0, name: "選択してください"},
    {id: 1, name: "生について"},
    {id: 2, name: "死について"},
    {id: 3, name: "愛について"},
    {id: 4, name: "運命について"},
    {id: 5, name: "結婚について"},
    {id: 6, name: "子供について"},
    {id: 7, name: "思考について"},
    {id: 8, name: "自由について"},
    {id: 9, name: "優しさについて"}
  ]

  include ActiveHash::Associations
  has_many :questions
end