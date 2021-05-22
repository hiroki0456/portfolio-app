json.array! @comments do |comment|
  json.user_name comment.user.nickname
  json.image_url comment.user.image_url
  json.profile comment.user.profile.content
  json.comment comment
end
  