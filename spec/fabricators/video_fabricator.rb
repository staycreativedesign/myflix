Fabricator(:video) do
	title { Faker::Lorem.word }
	description { Faker::Lorem.sentence(2)}
	category
end