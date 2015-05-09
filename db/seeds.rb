# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
                { name: 'Sajani',
                  phone_number: '+919840692259',
                  blood_group: 'AB+',
                  latitude: '13.060422',
                  longitude: '80.249583',
                  area: 'Velachery'
                },
                { name: 'Raji',
                  phone_number: '+919003240109',
                  blood_group: 'A+',
                  latitude: '13.460422',
                  longitude: '80.649583',
                  area: 'Nandanam'
                },
                { name: 'Aruna',
                  phone_number: '+919940257943',
                  blood_group: 'B-',
                  latitude: '13.760422',
                  longitude: '80.949583',
                  area: 'Tambaram'
                }
            ])

BloodRequest.create([
                        {
                            user_id: 1,
                            blood_group: 'A+',
                            latitude: '13.060422',
                            longitude: '80.249583',
                            area: 'Velachery',
                            active: true
                        },
                        {
                            user_id: 1,
                            blood_group: 'A+',
                            latitude: '13.060422',
                            longitude: '80.249583',
                            area: 'Velachery',
                            active: false
                        }
                    ])