# 01:00 pm -> 새벽 4시

every :day, :at => '04:30pm' do
  rake "image:remove_image"
end
