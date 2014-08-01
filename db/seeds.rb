print "Generating subreddits:"
%w{
  earthporn villageporn cityporn spaceporn waterporn abandonedporn animalporn humanporn botanicalporn adrenalineporn
  destructionporn movieposterporn albumartporn machineporn newsporn geekporn bookporn mapporn adporn designporn roomporn
  militaryporn historyporn quotesporn skyporn fireporn infrastructureporn aerialporn agricultureporn apocalypseporn
  architectureporn artefactporn artporn autumnporn avporn beachporn boatporn bonsaiporn bridgeporn cabinporn carporn
  cemeteryporn churchporn climbingporn comicbookporn concertporn culinaryporn desertporn dessertporn earthlingporn
  exposureporn f1porn fashionporn foodporn fossilporn fractalporn futureporn gamerporn geologyporn gunporn hellscapeporn
  houseporn infraredporn instrumentporn knifeporn lavaporn macroporn megalithporn metalporn microporn motorcycleporn
  mtgporn mushroomporn organizationporn powerwashingporn ridesporn ruralporn seaporn sportsporn springporn stadiumporn
  starshipporn streetartporn summerporn teaporn technologyporn televisionposterporn thingscutinhalfporn toolporn
  uniformporn videoporn viewporn weatherporn winterporn
}.each do |subreddit|
  Subreddit.find_or_create_by(name: subreddit)
  print '.'
end
puts
