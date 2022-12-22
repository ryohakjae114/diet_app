crumb :root do
  link "Home", root_path
end

crumb :items do
  link "アイテム一覧", admins_items_path
  parent :root
end

crumb :item_show do |item|
  link "#{item.name}", admins_item_path(item)
  parent :items
end

crumb :item_edit do |item|
  link "変更"
  parent :item_show, item
end

crumb :recipes do
  link "レシピ一覧", admins_recipes_path
  parent :root
end

crumb :recipe_show do |recipe|
  link "#{recipe.name}", admins_recipe_path(recipe)
  parent :recipes
end

crumb :recipe_edit do |recipe|
  link "変更"
  parent :recipe_show, recipe
end

crumb :recipe_item_new do |recipe|
  link "アイテム追加"
  parent :recipe_show, recipe
end

crumb :users do
  link "ユーザ一覧", admins_users_path
  parent :root
end

crumb :user_edit do |user|
  link "変更"
  parent :users
end

crumb :posts do
  link "投稿一覧", admins_users_path
  parent :users
end