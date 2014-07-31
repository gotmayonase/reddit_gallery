print "Generating subreddits:"
%w{
  earthporn villageporn cityporn spaceporn waterporn abandonedporn animalporn humanporn botanicalporn adrenalineporn
  destructionporn movieposterporn albumartporn machineporn newsporn geekporn bookporn mapporn adporn designporn roomporn
  militaryporn historyporn quotesporn skyporn fireporn infrastructureporn 
}.each do |subreddit|
  Subreddit.find_or_create_by(name: subreddit)
  print '.'
end
puts
