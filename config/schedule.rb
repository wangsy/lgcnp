# 01:00 pm -> 새벽 4시

every :day, :at => '03:49am' do
  rake "image:remove_image"
end

every :day, :at => '06:49pm' do
  rake "image:slack_test"
end
