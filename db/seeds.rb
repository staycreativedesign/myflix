# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Category.create(name: "TV Shows")
  Category.create(name: "Other Shows")

  futurama = Video.create( title: 'Futurama new', 
                description: "Futurama is an American adult animated science fiction sitcom created by Matt Groening for the Fox Broadcasting Company. The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century. The series was envisioned by Groening in the late 1990s while working on The Simpsons, later bringing Cohen aboard to develop storylines and characters to pitch the show to Fox.",
                small_cover_url: "tmp/futurama.jpg",
                large_cover_url: "tmp/monk_large.jpg",
                category_id: 1
              )


  southpark = Video.create( title: 'South Park new', 
                description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become infamous for its crude language and dark, surreal humor that satirizes a wide range of topics. The ongoing narrative revolves around four boys—Stan Marsh, Kyle Broflovski, Eric Cartman, and Kenny McCormick—and their bizarre adventures in and around the titular Colorado town. Much like The Simpsons, South Park utilizes a very large ensemble cast of recurring characters.",
                small_cover_url: "tmp/south_park.jpg",
                large_cover_url: "tmp/monk_large.jpg",
                category_id: 1
              )

  Video.create( title: 'South Park 2', 
                description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become infamous for its crude language and dark, surreal humor that satirizes a wide range of topics. The ongoing narrative revolves around four boys—Stan Marsh, Kyle Broflovski, Eric Cartman, and Kenny McCormick—and their bizarre adventures in and around the titular Colorado town. Much like The Simpsons, South Park utilizes a very large ensemble cast of recurring characters.",
                small_cover_url: "tmp/south_park.jpg",
                large_cover_url: "tmp/monk_large.jpg",
                category_id: 2
              )
  Video.create( title: 'South Park 3', 
                description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become infamous for its crude language and dark, surreal humor that satirizes a wide range of topics. The ongoing narrative revolves around four boys—Stan Marsh, Kyle Broflovski, Eric Cartman, and Kenny McCormick—and their bizarre adventures in and around the titular Colorado town. Much like The Simpsons, South Park utilizes a very large ensemble cast of recurring characters.",
                small_cover_url: "tmp/south_park.jpg",
                large_cover_url: "tmp/monk_large.jpg",
                category_id: 2
              )
  Video.create( title: 'South Park 4', 
                description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become infamous for its crude language and dark, surreal humor that satirizes a wide range of topics. The ongoing narrative revolves around four boys—Stan Marsh, Kyle Broflovski, Eric Cartman, and Kenny McCormick—and their bizarre adventures in and around the titular Colorado town. Much like The Simpsons, South Park utilizes a very large ensemble cast of recurring characters.",
                small_cover_url: "tmp/south_park.jpg",
                large_cover_url: "tmp/monk_large.jpg",
                category_id: 2
              )

  gus = User.create(full_name: "Gus", password: "red500", email: "pares101@aol.com")

  Review.create(user: gus, video: southpark, rating: '5', description: "This is the description" )
  QueueItem.create(user: gus, video: southpark, position: 1)
  QueueItem.create(user: gus, video: futurama, position: 2)